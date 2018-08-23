using Core.Entities.LotAggregate;
using Core.Entities.SaleAggregate;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Core.Interfaces
{
    public interface IAuctionService
    {
        Task<IEnumerable<Sale>> ListActiveSalesAsync();

        Task<IEnumerable<Lot>> ListLotsAsync(int? saleId);

        Task<IEnumerable<Lot>> ListLotsAsync();

        Task<Lot> GetLotAsync(int lotId, int saleId);

        Task PlaceBidAsync(int lotId, decimal amount, string userName, int saleId);
    }
}
