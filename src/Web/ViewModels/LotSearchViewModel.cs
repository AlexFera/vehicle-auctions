using Core.Entities.LotAggregate;
using System.Collections.Generic;

namespace Web.ViewModels
{
    public class LotSearchViewModel
    {
        public IEnumerable<Lot> Lots { get; set; }

        public string CountryCode { get; set; }
    }
}
