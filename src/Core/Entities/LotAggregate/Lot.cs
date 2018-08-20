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

        public IEnumerable<Bid> Bids { get; set; }

        public Sale Sale { get; set; }

        public decimal CurrentPrice { get; set; }

        public decimal NextBidAmount { get; set; }
    }
}
