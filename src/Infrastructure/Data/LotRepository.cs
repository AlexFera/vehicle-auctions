using Core.Entities.LotAggregate;
using Core.Interfaces;
using Dapper;
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

        public LotRepository(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        public async Task<IEnumerable<Lot>> ListLotsAsync(int saleId)
        {
            using (var sqlConnection = new SqlConnection(this.configuration.GetConnectionString("DatabaseConnection")))
            {
                sqlConnection.Open();

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

        public async Task<Lot> GetLotAsync(int lotId)
        {
            using (var sqlConnection = new SqlConnection(this.configuration.GetConnectionString("DatabaseConnection")))
            {
                sqlConnection.Open();

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
