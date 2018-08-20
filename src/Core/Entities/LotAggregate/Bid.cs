using System;

namespace Core.Entities.LotAggregate
{
    public class Bid
    {
        public int Id { get; set; }

        public decimal Amount { get; set; }

        public DateTime PlacedDate { get; set; }

        public Buyer Placer { get; set; }
    }
}
