﻿using System;

namespace Core.Entities.SaleAggregate
{
    public class Sale
    {
        public int SaleId { get; set; }

        public string Name { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime EndDate { get; set; }

        public int SellerId { get; set; }

        public int LocationId { get; set; }
    }
}
