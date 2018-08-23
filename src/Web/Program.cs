using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Azure.SqlDatabase.ElasticScale.ShardManagement;
using Microsoft.Azure.SqlDatabase.ElasticScale.ShardManagement.Schema;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using System;
using System.Linq;

namespace Web
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var host = CreateWebHostBuilder(args).Build();

            using (var scope = host.Services.CreateScope())
            {
                var services = scope.ServiceProvider;
                var loggerFactory = services.GetRequiredService<ILoggerFactory>();
                var configuration = services.GetRequiredService<IConfiguration>();
                try
                {
                    var shardMapManager = CreateOrGetShardMapManager(configuration);
                    var shardMap = CreateOrGetListShardMap(shardMapManager);
                    CreateSchemaInfo(shardMap.Name, shardMapManager);
                    if (!shardMap.GetShards().Any())
                    {
                        CreateShard(shardMap, "VehicleAuctions_EUShard", 1, configuration);
                        CreateShard(shardMap, "VehicleAuctions_UKShard", 2, configuration);
                    }
                }
                catch (Exception ex)
                {
                    var logger = loggerFactory.CreateLogger<Program>();
                    logger.LogError(ex, "An error occurred creating the shards.");
                }
            }

            host.Run();
        }

        public static IWebHostBuilder CreateWebHostBuilder(string[] args) =>
            WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>();

        private static ShardMapManager CreateOrGetShardMapManager(IConfiguration configuration)
        {
            var shardMapManagerConnection = configuration.GetConnectionString("ShardMapManagerConnection");
            var shardMapManagerExists = ShardMapManagerFactory.TryGetSqlShardMapManager(shardMapManagerConnection, ShardMapManagerLoadPolicy.Lazy, out ShardMapManager shardMapManager);

            if (!shardMapManagerExists)
            {
                shardMapManager = ShardMapManagerFactory.CreateSqlShardMapManager(shardMapManagerConnection);
            }

            return shardMapManager;
        }

        private static ListShardMap<int> CreateOrGetListShardMap(ShardMapManager shardMapManager)
        {
            var shardMapName = "CountryShardMap";
            var shardMapExists = shardMapManager.TryGetListShardMap(shardMapName, out ListShardMap<int> shardMap);

            if (!shardMapExists)
            {
                shardMap = shardMapManager.CreateListShardMap<int>(shardMapName);
            }

            return shardMap;
        }

        // Create schema info so that the split-merge service can be used to move data in sharded tables
        // and reference tables.
        private static void CreateSchemaInfo(string shardMapName, ShardMapManager shardMapManager)
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
            if (shardMapManager.GetSchemaInfoCollection().Any(s => s.Key == shardMapName))
            {
                return;
            }
            shardMapManager.GetSchemaInfoCollection().Add(shardMapName, schemaInfo);
        }

        private static Shard CreateOrGetShard(ListShardMap<int> shardMap, string databaseShardName, IConfiguration configuration)
        {
            var shardLocation = new ShardLocation(configuration["ShardingServerName"], databaseShardName);
            var shardExists = shardMap.TryGetShard(shardLocation, out Shard shard);

            if (!shardExists)
            {
                shard = shardMap.CreateShard(shardLocation);
            }

            return shard;
        }

        private static void CreateShard(ListShardMap<int> shardMap, string databaseShardName, int shardingKey, IConfiguration configuration)
        {
            var shard = CreateOrGetShard(shardMap, databaseShardName, configuration);
            shardMap.CreatePointMapping(shardingKey, shard);
        }
    }
}
