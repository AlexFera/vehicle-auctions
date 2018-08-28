using Core.Entities.LotAggregate;
using Core.Entities.SaleAggregate;
using Core.Interfaces;
using System;
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

        public async Task<Lot> GetLotAsync(int lotId, int saleId, string countryCode, string userName)
        {
            var lot = await this.lotRepository.GetLotAsync(lotId, countryCode);
            lot.Bids = await this.bidRepository.ListBidsAsync(lotId, countryCode);
            lot.Sale = await this.saleRepository.GetSaleAsync(saleId, countryCode);
            SetCurrentPrice(lot);
            lot.NextBidAmount = lot.CurrentPrice + lot.Sale.BidIncrement;
            lot.ShowBiddingStatus = lot.Bids.Any(b => b.Placer.UserName.Equals(userName, StringComparison.OrdinalIgnoreCase));
            if (lot.ShowBiddingStatus)
            {
                SetBiddingStatus(userName, lot);
            }

            return lot;
        }

        public async Task<IEnumerable<Sale>> ListActiveSalesAsync()
        {
            return await this.saleRepository.ListActiveSalesAsync();
        }

        public async Task<IEnumerable<Lot>> ListLotsAsync(int? saleId, string countryCode)
        {
            if (saleId.HasValue)
            {
                return await this.lotRepository.ListLotsAsync(saleId.Value, countryCode);
            }
            else
            {
                return await this.lotRepository.ListLotsAsync();
            }

        }

        public async Task PlaceBidAsync(int lotId, decimal amount, string userName, int saleId, string countryCode)
        {
            var lot = await this.GetLotAsync(lotId, saleId, countryCode, userName);

            if (amount > lot.CurrentPrice)
            {
                await this.bidRepository.InsertBidAsync(lotId, amount, userName, countryCode);
            }
        }

        public async Task<IEnumerable<Lot>> ListLotsAsync()
        {
            return await this.lotRepository.ListLotsAsync();
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

        private static void SetBiddingStatus(string userName, Lot lot)
        {
            var highestBid = lot.Bids.OrderByDescending(b => b.Id).FirstOrDefault();
            if (highestBid != null)
            {
                lot.BiddingStatus = BiddingStatus.Losing;
                if (highestBid.Placer.UserName.Equals(userName, StringComparison.OrdinalIgnoreCase))
                {
                    lot.BiddingStatus = BiddingStatus.Winning;
                }
            }
        }
    }
}
