using Interfaces;
using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;
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
                    var elasticScaleClient = services.GetRequiredService<IElasticScaleClient>();
                    var shardMap = elasticScaleClient.CreateOrGetListShardMap();
                    elasticScaleClient.CreateSchemaInfo(shardMap.Name);
                    if (!shardMap.GetShards().Any())
                    {
                        elasticScaleClient.CreateShard(shardMap, databaseShardName: "VehicleAuctions_EUShard", shardingKey: 1);
                        elasticScaleClient.CreateShard(shardMap, databaseShardName: "VehicleAuctions_UKShard", shardingKey: 2);
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
    }
}
