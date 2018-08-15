using Core.Entities.SaleAggregate;
using Core.Interfaces;
using Dapper;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;

namespace Infrastructure.Data
{
    public class SaleRepository : ISaleRepository
    {
        private readonly IConfiguration configuration;

        public SaleRepository(IConfiguration configuration)
        {
            this.configuration = configuration;
        }

        public async Task<IEnumerable<Sale>> ListActiveSalesAsync()
        {
            using (var sqlConnection = new SqlConnection(this.configuration.GetConnectionString("CatalogConnection")))
            {
                return await sqlConnection.QueryAsync<Sale>("Sale_List", commandType: CommandType.StoredProcedure);
            }
        }
    }
}
