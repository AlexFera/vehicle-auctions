using Core.Entities.SaleAggregate;
using System.Collections.Generic;

namespace Web.ViewModels
{
    public class SaleViewModel
    {
        public IEnumerable<Sale> ActiveSales { get; set; }
    }
}
