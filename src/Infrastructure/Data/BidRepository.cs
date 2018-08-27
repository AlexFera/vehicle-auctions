using Core.Entities.LotAggregate;
using Core.Interfaces;
using Dapper;
using Interfaces;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace Infrastructure.Data
{
    public class BidRepository : IBidRepository
    {
        private readonly IConfiguration configuration;
        private readonly IElasticScaleClient elasticScaleClient;

        public BidRepository(
            IConfiguration configuration,
            IElasticScaleClient elasticScaleClient)
        {
            this.configuration = configuration;
            this.elasticScaleClient = elasticScaleClient;
        }

        public async Task<IEnumerable<Bid>> ListBidsAsync(int lotId, string countryCode)
        {
            var shardMap = this.elasticScaleClient.CreateOrGetListShardMap();
            using (var sqlConnection = shardMap.OpenConnectionForKey(this.elasticScaleClient.GetShardKeyByCountryCode(countryCode), this.elasticScaleClient.GetConnectionString()))
            {
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

        public async Task InsertBidAsync(int lotId, decimal amount, string userName, string countryCode)
        {
            var shardMap = this.elasticScaleClient.CreateOrGetListShardMap();
            using (var sqlConnection = shardMap.OpenConnectionForKey(this.elasticScaleClient.GetShardKeyByCountryCode(countryCode), this.elasticScaleClient.GetConnectionString()))
            {
                var p = new DynamicParameters();
                p.Add("@lotId", lotId);
                p.Add("@amount", amount);
                p.Add("@userName", userName);

                await sqlConnection.ExecuteScalarAsync<int>("Bid_Insert", p, commandType: CommandType.StoredProcedure);
            }
        }
    }
}
