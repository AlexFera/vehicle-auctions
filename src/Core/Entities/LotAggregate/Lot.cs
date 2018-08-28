using Core.Entities.SaleAggregate;
using System.Collections.Generic;

namespace Core.Entities.LotAggregate
{
    public class Lot
    {
        public int Id { get; set; }

        public decimal StartPrice { get; set; }

        public decimal ReservePrice { get; set; }

        public LotStatus LotStatus { get; set; }

        public Vehicle Vehicle { get; set; }

        public int SaleId { get; set; }

        public IEnumerable<Bid> Bids { get; set; }

        public Sale Sale { get; set; }

        public decimal CurrentPrice { get; set; }

        public decimal NextBidAmount { get; set; }

        public string CountryCode { get; set; }

        public bool ShowBiddingStatus { get; set; }

        public BiddingStatus BiddingStatus { get; set; }
    }
}
