using Microsoft.Azure.SqlDatabase.ElasticScale.ShardManagement;

namespace Interfaces
{
    public interface IElasticScaleClient
    {
        ListShardMap<int> CreateOrGetListShardMap();

        void CreateSchemaInfo(string shardMapName);

        void CreateShard(ListShardMap<int> shardMap, string databaseShardName, int shardingKey);

        string GetConnectionString();

        int GetShardKeyByCountryCode(string countryCode);
    }
}