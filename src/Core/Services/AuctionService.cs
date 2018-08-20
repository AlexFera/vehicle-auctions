using Core.Entities.LotAggregate;
using Core.Entities.SaleAggregate;
using Core.Interfaces;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Core.Services
{
    public class AuctionService : IAuctionService
    {
        private readonly ISaleRepository saleRepository;
        private readonly ILotRepository lotRepository;
        private readonly IBidRepository bidRepository;

        public AuctionService(
            ISaleRepository saleRepository,
            ILotRepository lotRepository,
            IBidRepository bidRepository
            )
        {
            this.saleRepository = saleRepository;
            this.lotRepository = lotRepository;
            this.bidRepository = bidRepository;
        }

        public async Task<Lot> GetLotAsync(int lotId, int saleId)
        {
            var lot = await this.lotRepository.GetLotAsync(lotId);
            lot.Bids = await this.bidRepository.ListBidsAsync(lotId);
            lot.Sale = await this.saleRepository.GetSaleAsync(saleId);
            SetCurrentPrice(lot);
            lot.NextBidAmount = lot.CurrentPrice + lot.Sale.BidIncrement;

            return lot;
        }

        private static void SetCurrentPrice(Lot lot)
        {
            if (lot.Bids.Any())
            {
                lot.CurrentPrice = lot.Bids.Last().Amount;
            }
            else
            {
                lot.CurrentPrice = lot.StartPrice;
            }
        }

        public async Task<IEnumerable<Sale>> ListActiveSalesAsync()
        {
            return await this.saleRepository.ListActiveSalesAsync();
        }

        public async Task<IEnumerable<Lot>> ListLotsAsync(int saleId)
        {
            return await this.lotRepository.ListLotsAsync(saleId);
        }
    }
}
