using Core.Entities;
using Core.Entities.SaleAggregate;
using Core.Interfaces;
using Dapper;
using Microsoft.Extensions.Configuration;
using System.Collections.Generic;
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
            using (var sqlConnection = new SqlConnection(this.configuration.GetConnectionString("DatabaseConnection")))
            {
                sqlConnection.Open();

                return await sqlConnection.QueryAsync<Sale, Seller, Location, Country, Sale>("Sale_List",
                    map: (sale, seller, location, country) =>
                    {
                        sale.Seller = seller;
                        sale.Location = location;
                        sale.Location.Country = country;
                        return sale;
                    });
            }
        }

        public async Task<IEnumerable<Sale>> ListLotsAsync()
        {
            using (var sqlConnection = new SqlConnection(this.configuration.GetConnectionString("DatabaseConnection")))
            {
                sqlConnection.Open();

                return await sqlConnection.QueryAsync<Sale, Seller, Location, Country, Sale>("Lot_ListBySaleId",
                    map: (sale, seller, location, country) =>
                    {
                        sale.Seller = seller;
                        sale.Location = location;
                        sale.Location.Country = country;
                        return sale;
                    });
            }
        }
    }
}
