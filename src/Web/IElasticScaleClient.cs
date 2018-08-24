using Microsoft.Azure.SqlDatabase.ElasticScale.ShardManagement;

namespace Web
{
    public interface IElasticScaleClient
    {
        ListShardMap<int> CreateOrGetListShardMap();
        void CreateSchemaInfo(string shardMapName);
        void CreateShard(ListShardMap<int> shardMap, string databaseShardName, int shardingKey);
    }
}