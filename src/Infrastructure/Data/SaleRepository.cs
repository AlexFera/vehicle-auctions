using Core.Entities;
using Core.Entities.SaleAggregate;
using Core.Interfaces;
using Dapper;
using Interfaces;
using Microsoft.Azure.SqlDatabase.ElasticScale.Query;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Infrastructure.Data
{
    public class SaleRepository : ISaleRepository
    {
        private readonly IConfiguration configuration;
        private readonly IElasticScaleClient elasticScaleClient;

        public SaleRepository(
            IConfiguration configuration,
            IElasticScaleClient elasticScaleClient)
        {
            this.configuration = configuration;
            this.elasticScaleClient = elasticScaleClient;
        }

        public async Task<IEnumerable<Sale>> ListActiveSalesAsync()
        {
            var shardMap = this.elasticScaleClient.CreateOrGetListShardMap();
            var shards = shardMap.GetShards();

            using (var multiShardConnection = new MultiShardConnection(shards, this.elasticScaleClient.GetConnectionStringForMultiShardConnection()))
            using (var multiShardCommand = multiShardConnection.CreateCommand())
            {
                multiShardCommand.CommandText = @"
                    SELECT
	                    -- Sale
	                    s.Id
	                    ,s.Name
	                    ,s.StartDate
	                    ,s.EndDate
	                    ,s.BidIncrement
	                    ,st.Value AS SaleType
	                    -- Seller
	                    ,sl.Id
	                    ,sl.CompanyName
	                    -- Location
	                    ,l.Id
	                    ,l.StreetAddress
	                    ,l.PostalCode
	                    ,l.City
	                    ,l.StateOrProvince
	                    -- Country
	                    ,c.Id
	                    ,c.Code
	                    ,c.Name
                    FROM [dbo].[Sale] s WITH (NOLOCK)
                    INNER JOIN [dbo].[SaleType] st WITH (NOLOCK) ON s.SaleTypeId = st.Id
                    INNER JOIN [dbo].[Seller] sl WITH (NOLOCK) ON s.SellerId = sl.Id
                    INNER JOIN [dbo].[Location] l WITH (NOLOCK) ON s.LocationId = l.Id
                    INNER JOIN [dbo].[Country] c WITH (NOLOCK) ON l.CountryId = c.Id";

                // Allow for partial results in case some shards do not respond in time
                multiShardCommand.ExecutionPolicy = MultiShardExecutionPolicy.PartialResults;

                multiShardCommand.CommandTimeout = 30;

                // Execute the command. 
                // We do not need to specify retry logic because MultiShardDataReader will internally retry until the CommandTimeout expires.
                using (var reader = await multiShardCommand.ExecuteReaderAsync())
                {
                    int rows = 0;
                    while (await reader.ReadAsync())
                    {
                        // Read the values using standard DbDataReader methods
                        object[] values = new object[reader.FieldCount];
                        reader.GetValues(values);

                        rows++;
                    }
                }

                return new List<Sale>();
            }
        }

        public async Task<int> GetLotCountAsync(int saleId)
        {
            using (var sqlConnection = new SqlConnection(this.configuration.GetConnectionString("DatabaseConnection")))
            {
                sqlConnection.Open();

                var p = new DynamicParameters();
                p.Add("saleId", saleId);

                return await sqlConnection.ExecuteScalarAsync<int>("LotCount_Get", p, commandType: CommandType.StoredProcedure);
            }
        }

        public async Task<Sale> GetSaleAsync(int saleId)
        {
            using (var sqlConnection = new SqlConnection(this.configuration.GetConnectionString("DatabaseConnection")))
            {
                sqlConnection.Open();

                var p = new DynamicParameters();
                p.Add("saleId", saleId);

                var sales = await sqlConnection.QueryAsync<Sale, Seller, Location, Country, Sale>("Sale_Get",
                     map: (sale, seller, location, country) =>
                     {
                         sale.Seller = seller;
                         sale.Location = location;
                         sale.Location.Country = country;
                         return sale;
                     },
                     param: p,
                     commandType: CommandType.StoredProcedure);

                foreach (var sale in sales)
                {
                    sale.NumberOfLots = await GetLotCountAsync(sale.Id);
                }

                return sales.FirstOrDefault();
            }
        }
    }
}
