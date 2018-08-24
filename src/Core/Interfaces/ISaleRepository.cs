using Core.Entities.SaleAggregate;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Core.Interfaces
{
    public interface ISaleRepository
    {
        Task<IEnumerable<Sale>> ListActiveSalesAsync();

        Task<int> GetLotCountAsync(int saleId, string countryCode);

        Task<Sale> GetSaleAsync(int saleId);
    }
}
