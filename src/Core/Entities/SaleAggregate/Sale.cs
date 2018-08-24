using System;

namespace Core.Entities.SaleAggregate
{
    public class Sale
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime EndDate { get; set; }

        public SaleType SaleType { get; set; }

        public Seller Seller { get; set; }

        public Location Location { get; set; }

        public int NumberOfLots { get; set; }

        public decimal BidIncrement { get; set; }

        public int CountryId { get; set; }
    }
}
