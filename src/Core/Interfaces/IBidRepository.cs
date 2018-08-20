using Core.Entities.LotAggregate;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Core.Interfaces
{
    public interface IBidRepository
    {
        Task<IEnumerable<Bid>> ListBidsAsync(int lotId);
    }
}
