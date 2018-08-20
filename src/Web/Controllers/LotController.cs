using Core.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using Web.ViewModels;

namespace Web.Controllers
{
    public class LotController : Controller
    {
        private readonly IAuctionService auctionService;

        public LotController(IAuctionService auctionService)
        {
            this.auctionService = auctionService;
        }

        public async Task<IActionResult> Search(int saleId)
        {
            var lots = await this.auctionService.ListLotsAsync(saleId);
            var viewModel = new LotSearchViewModel { Lots = lots, SaleId = saleId };

            return View(viewModel);
        }

        public async Task<IActionResult> Details(int lotId, int saleId)
        {
            var lot = await this.auctionService.GetLotAsync(lotId, saleId);
            var viewModel = new LotDetailsViewModel { Lot = lot};

            return View(viewModel);
        }
    }
}