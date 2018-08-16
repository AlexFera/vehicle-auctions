﻿namespace Core.Entities.LotAggregate
{
    public class Lot
    {
        public int Id { get; set; }

        public decimal StartPrice { get; set; }

        public decimal ReservePrice { get; set; }

        public LotStatus LotStatus { get; set; }

        public Vehicle Vehicle { get; set; }
    }
}
