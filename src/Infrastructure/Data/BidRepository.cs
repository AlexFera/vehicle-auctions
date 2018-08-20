using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using Core.Entities.LotAggregate;
using Core.Interfaces;
using Dapper;
using Microsoft.Extensions.Configuration;

namespace Infrastructure.Data
{
    public class BidRepository : IBidRepository
    {
        private readonly IConfiguration configuration;

        public BidRepository(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        public async Task<IEnumerable<Bid>> ListBidsAsync(int lotId)
        {
            using (var sqlConnection = new SqlConnection(this.configuration.GetConnectionString("DatabaseConnection")))
            {
                sqlConnection.Open();

                var p = new DynamicParameters();
                p.Add("@lotId", lotId);

                var bids = await sqlConnection.QueryAsync<Bid, Buyer, Bid>("Bid_ListByLotId",
                    map: (bid, buyer) =>
                    {
                        bid.Placer = buyer;
                        return bid;
                    },
                    param: p,
                    commandType: CommandType.StoredProcedure);

                return bids;
            }
        }

        public async Task InsertBidAsync(int lotId, decimal amount, string userName)
        {
            using (var sqlConnection = new SqlConnection(this.configuration.GetConnectionString("DatabaseConnection")))
            {
                sqlConnection.Open();

                var p = new DynamicParameters();
                p.Add("@lotId", lotId);
                p.Add("@amount", amount);
                p.Add("@userName", userName);

                await sqlConnection.ExecuteScalarAsync<int>("Bid_Insert", p, commandType: CommandType.StoredProcedure);
            }
        }
    }
}
