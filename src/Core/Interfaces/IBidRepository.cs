using Core.Entities.LotAggregate;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Core.Interfaces
{
    public interface IBidRepository
    {
        Task<IEnumerable<Bid>> ListBidsAsync(int lotId, string countryCode);

        Task InsertBidAsync(int lotId, decimal amount, string userName, string countryCode);
    }
}
