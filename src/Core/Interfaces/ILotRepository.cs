using Core.Entities.LotAggregate;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Core.Interfaces
{
    public interface ILotRepository
    {
        Task<IEnumerable<Lot>> ListLotsAsync(int saleId);

        Task<IEnumerable<Lot>> ListLotsAsync();

        Task<Lot> GetLotAsync(int lotId);
    }
}
