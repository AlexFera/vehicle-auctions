using Core.Entities.LotAggregate;
using System.Collections.Generic;

namespace Web.ViewModels
{
    public class LotSearchViewModel
    {
        public int SaleId { get; set; }

        public IEnumerable<Lot> Lots { get; set; }
    }
}
