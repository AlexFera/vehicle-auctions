using Core.Entities.LotAggregate;
using Core.Entities.SaleAggregate;

namespace Web.ViewModels
{
    public class LotDetailsViewModel
    {
        public Sale Sale { get; set; }

        public Lot Lot { get; set; }
    }
}
