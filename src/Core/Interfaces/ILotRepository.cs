using Core.Entities.LotAggregate;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Core.Interfaces
{
    public interface ILotRepository
    {
        Task<IEnumerable<Lot>> ListLotsAsync(int saleId);
    }
}
