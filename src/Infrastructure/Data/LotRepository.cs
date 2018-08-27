using Core.Entities.LotAggregate;
using Core.Interfaces;
using Dapper;
using Interfaces;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
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
            using (var sqlConnection = new SqlConnection(this.configuration.GetConnectionString("DatabaseConnection")))
            {
                var lots = await sqlConnection.QueryAsync<Lot, Vehicle, Lot>("Lot_List",
                    map: (lot, vehicle) =>
                    {
                        lot.Vehicle = vehicle;

                        return lot;
                    },
                    commandType: CommandType.StoredProcedure);

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
