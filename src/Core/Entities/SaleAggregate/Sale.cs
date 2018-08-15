using System;

namespace Core.Entities.SaleAggregate
{
    public class Sale
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime EndDate { get; set; }

        public int SellerId { get; set; }

        public Location Location { get; set; }
    }
}
