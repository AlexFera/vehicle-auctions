using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Azure.SqlDatabase.ElasticScale.ShardManagement;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using System;

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
    }
}
