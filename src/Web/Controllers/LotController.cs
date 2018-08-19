using Core.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using Web.ViewModels;

namespace Web.Controllers
{
    public class LotController : Controller
    {
        private readonly ILotRepository lotRepository;
        private readonly ISaleRepository saleRepository;

        public LotController(ILotRepository lotRepository, ISaleRepository saleRepository)
        {
            this.lotRepository = lotRepository;
            this.saleRepository = saleRepository;
        }

        public async Task<IActionResult> Search(int saleId)
        {
            var lots = await this.lotRepository.ListLotsAsync(saleId);
            var viewModel = new LotSearchViewModel { Lots = lots, SaleId = saleId };

            return View(viewModel);
        }

        public async Task<IActionResult> Details(int lotId, int saleId)
        {
            var lot = await this.lotRepository.GetLotAsync(lotId);
            var sale = await this.saleRepository.GetSaleAsync(saleId);
            var viewModel = new LotDetailsViewModel { Lot = lot, Sale = sale };

            return View(viewModel);
        }
    }
}