using Core.Entities;
using Core.Entities.LotAggregate;
using Core.Entities.SaleAggregate;
using Core.Interfaces;
using Dapper;
using Interfaces;
using Microsoft.Azure.SqlDatabase.ElasticScale.Query;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace Infrastructure.Data
{
    public class LotRepository : ILotRepository
    {
        private readonly IConfiguration configuration;
        private readonly IElasticScaleClient elasticScaleClient;

        public LotRepository(
            IConfiguration configuration,
            IElasticScaleClient elasticScaleClient)
        {
            this.configuration = configuration;
            this.elasticScaleClient = elasticScaleClient;
        }

        public async Task<IEnumerable<Lot>> ListLotsAsync(int saleId, string countryCode)
        {
            var shardMap = this.elasticScaleClient.CreateOrGetListShardMap();
            using (var sqlConnection = shardMap.OpenConnectionForKey(this.elasticScaleClient.GetShardKeyByCountryCode(countryCode), this.elasticScaleClient.GetConnectionString()))
            {
                var p = new DynamicParameters();
                p.Add("@saleId", saleId);

                var lots = await sqlConnection.QueryAsync<Lot, Vehicle, Lot>("Lot_ListBySaleId",
                    map: (lot, vehicle) =>
                    {
                        lot.Vehicle = vehicle;

                        return lot;
                    },
                    param: p,
                    commandType: CommandType.StoredProcedure);

                return lots;
            }
        }

        public async Task<IEnumerable<Lot>> ListLotsAsync()
        {
            var shardMap = this.elasticScaleClient.CreateOrGetListShardMap();
            var shards = shardMap.GetShards();

            using (var multiShardConnection = new MultiShardConnection(shards, this.elasticScaleClient.GetConnectionString()))
            using (var multiShardCommand = multiShardConnection.CreateCommand())
            {
                multiShardCommand.CommandText = @"
                    SELECT TOP (1000) l.Id
	                    ,l.StartPrice
	                    ,l.ReservePrice
	                    ,l.SaleId
	                    ,ls.Value AS LotStatus
	                    ,v.Make
	                    ,v.Model
	                    ,v.VIN
	                    ,v.Color
	                    ,v.Mileage
	                    ,v.ImageUrl
	                    ,v.FirstRegistrationDate
	                    ,v.EngineCapacity
	                    ,v.EngineType
	                    ,v.NumberOfDoors
	                    ,v.FuelType
	                    ,v.EquipmentInterior
	                    ,v.EquipmentExterior
	                    ,v.EquipmentInfotainment
	                    ,v.EquipmentEngineTechnology
	                    ,v.VehicleSource
	                    ,v.CurrentCountryOfRegistration
	                    ,v.HasServiceHistory
	                    ,v.EuroEmissionStandard
	                    ,v.HasAccidentDamage
	                    ,v.HasSecondKeyAvailable
	                    ,v.TransmissionType
	                    ,v.EnginePower
                        ,c.Code
                    FROM [dbo].[Lot] l
                    INNER JOIN [dbo].[LotStatus] ls ON l.LotStatusId = ls.Id
                    INNER JOIN [dbo].[LotItem] li ON l.Id = li.LotId
                    INNER JOIN [dbo].[Vehicle] v ON li.Id = v.LotItemId
                    INNER JOIN [dbo].[Sale] s ON l.SaleId = s.Id
					INNER JOIN [dbo].[Location] lo ON s.LocationId = lo.Id
                    INNER JOIN [dbo].[Country] c ON lo.CountryId = c.Id";

                // Allow for partial results in case some shards do not respond in time
                multiShardCommand.ExecutionPolicy = MultiShardExecutionPolicy.PartialResults;

                multiShardCommand.CommandTimeout = 30;

                var lots = new List<Lot>();

                // Execute the command. 
                // We do not need to specify retry logic because MultiShardDataReader will internally retry until the CommandTimeout expires.
                using (var reader = await multiShardCommand.ExecuteReaderAsync())
                {
                    while (await reader.ReadAsync())
                    {
                        var columnIndex = 0;
                        var lot = new Lot { Bids = new List<Bid>(), Sale = new Sale(), Vehicle = new Vehicle() };
                        lot.Id = reader.GetInt32(columnIndex++);
                        lot.StartPrice = reader.GetDecimal(columnIndex++);
                        lot.ReservePrice = reader.GetDecimal(columnIndex++);
                        lot.SaleId = reader.GetInt32(columnIndex++);
                        lot.LotStatus = (LotStatus)Enum.Parse(typeof(LotStatus), reader.GetString(columnIndex++));
                        lot.Vehicle.Make = reader.GetString(columnIndex++);
                        lot.Vehicle.Model = reader.GetString(columnIndex++);
                        lot.Vehicle.VIN = reader.GetString(columnIndex++);
                        lot.Vehicle.Color = reader.GetString(columnIndex++);
                        lot.Vehicle.Mileage = reader.GetInt32(columnIndex++);
                        lot.Vehicle.ImageUrl = reader.GetString(columnIndex++);
                        lot.Vehicle.FirstRegistrationDate = reader.GetDateTime(columnIndex++);
                        lot.Vehicle.EngineCapacity = reader.GetDouble(columnIndex++);
                        lot.Vehicle.EngineType = reader.GetString(columnIndex++);
                        lot.Vehicle.NumberOfDoors = reader.GetInt16(columnIndex++);
                        lot.Vehicle.FuelType = reader.GetString(columnIndex++);
                        lot.Vehicle.EquipmentInterior = reader.GetString(columnIndex++);
                        lot.Vehicle.EquipmentExterior = reader.GetString(columnIndex++);
                        lot.Vehicle.EquipmentInfotainment = reader.GetString(columnIndex++);
                        lot.Vehicle.EquipmentEngineTechnology = reader.GetString(columnIndex++);
                        lot.Vehicle.VehicleSource = reader.GetString(columnIndex++);
                        lot.Vehicle.CurrentCountryOfRegistration = reader.GetString(columnIndex++);
                        lot.Vehicle.HasServiceHistory = reader.GetBoolean(columnIndex++);
                        lot.Vehicle.EuroEmissionStandard = reader.GetInt16(columnIndex++);
                        lot.Vehicle.HasAccidentDamage = reader.GetBoolean(columnIndex++);
                        lot.Vehicle.HasSecondKeyAvailable = reader.GetBoolean(columnIndex++);
                        lot.Vehicle.TransmissionType = reader.GetString(columnIndex++);
                        lot.Vehicle.EnginePower = reader.GetString(columnIndex++);
                        lot.CountryCode = reader.GetString(columnIndex++);

                        lots.Add(lot);
                    }
                }

                return lots;
            }
        }

        public async Task<Lot> GetLotAsync(int lotId, string countryCode)
        {
            var shardMap = this.elasticScaleClient.CreateOrGetListShardMap();
            using (var sqlConnection = shardMap.OpenConnectionForKey(this.elasticScaleClient.GetShardKeyByCountryCode(countryCode), this.elasticScaleClient.GetConnectionString()))
            {
                var p = new DynamicParameters();
                p.Add("@lotId", lotId);

                var lots = await sqlConnection.QueryAsync<Lot, Vehicle, Lot>("Lot_GetByLotId",
                    map: (lot, vehicle) =>
                    {
                        lot.Vehicle = vehicle;

                        return lot;
                    },
                    param: p,
                    commandType: CommandType.StoredProcedure);

                return lots.FirstOrDefault();
            }
        }
    }
}
