using Interfaces;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Azure.SqlDatabase.ElasticScale.ShardManagement;
using Microsoft.Azure.SqlDatabase.ElasticScale.ShardManagement.Schema;
using Microsoft.Extensions.Configuration;
using System.Data.SqlClient;
using System.Linq;

namespace Infrastructure.ElasticScale
{
    public class ElasticScaleClient : IElasticScaleClient
    {
        private readonly ShardMapManager shardMapManager;
        private readonly IConfiguration configuration;
        private readonly IHostingEnvironment env;
        private const string ShardMapName = "CountryShardMap";

        public ElasticScaleClient(
            ShardMapManager shardMapManager,
            IConfiguration configuration,
            IHostingEnvironment env)
        {
            this.shardMapManager = shardMapManager;
            this.configuration = configuration;
            this.env = env;
        }

        public ListShardMap<int> CreateOrGetListShardMap()
        {
            var shardMapExists = this.shardMapManager.TryGetListShardMap(ShardMapName, out ListShardMap<int> shardMap);

            if (!shardMapExists)
            {
                shardMap = this.shardMapManager.CreateListShardMap<int>(ShardMapName);
            }

            return shardMap;
        }

        public void CreateShard(ListShardMap<int> shardMap, string databaseShardName, int shardingKey)
        {
            var shard = CreateOrGetShard(shardMap, databaseShardName);
            shardMap.CreatePointMapping(shardingKey, shard);
        }

        // Create schema info so that the split-merge service can be used to move data in sharded tables
        // and reference tables.
        public void CreateSchemaInfo(string shardMapName)
        {
            var schemaInfo = new SchemaInfo();
            schemaInfo.Add(new ReferenceTableInfo("SaleType"));
            schemaInfo.Add(new ReferenceTableInfo("LotStatus"));
            schemaInfo.Add(new ReferenceTableInfo("Location"));
            schemaInfo.Add(new ReferenceTableInfo("Country"));
            schemaInfo.Add(new ShardedTableInfo("Bid", "CountryId"));
            schemaInfo.Add(new ShardedTableInfo("Buyer", "CountryId"));
            schemaInfo.Add(new ShardedTableInfo("Lot", "CountryId"));
            schemaInfo.Add(new ShardedTableInfo("LotItem", "CountryId"));
            schemaInfo.Add(new ShardedTableInfo("Sale", "CountryId"));
            schemaInfo.Add(new ShardedTableInfo("Seller", "CountryId"));
            schemaInfo.Add(new ShardedTableInfo("Vehicle", "CountryId"));

            // Register it with the shard map manager for the given shard map name
            if (this.shardMapManager.GetSchemaInfoCollection().Any(s => s.Key == shardMapName))
            {
                return;
            }

            this.shardMapManager.GetSchemaInfoCollection().Add(shardMapName, schemaInfo);
        }

        /// <summary>
        /// Returns a connection string to use for Data-Dependent Routing and Multi-Shard Query,
        /// which does not contain DataSource or InitialCatalog.
        /// </summary>
        public string GetConnectionStringForMultiShardConnection()
        {
            var connectionString = new SqlConnectionStringBuilder
            {
                UserID = this.configuration["ShardingUserName"],
                Password = this.configuration["ShardingPassword"],
                IntegratedSecurity = env.IsDevelopment(),
                ApplicationName = "VehicleAuctionsWebApp",
                ConnectTimeout = 30
            };

            return connectionString.ToString();
        }

        private Shard CreateOrGetShard(ListShardMap<int> shardMap, string databaseShardName)
        {
            var shardLocation = new ShardLocation(this.configuration["ShardingServerName"], databaseShardName);
            var shardExists = shardMap.TryGetShard(shardLocation, out Shard shard);

            if (!shardExists)
            {
                shard = shardMap.CreateShard(shardLocation);
            }

            return shard;
        }
    }
}
