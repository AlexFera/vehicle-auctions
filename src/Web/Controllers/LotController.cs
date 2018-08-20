using Core.Entities.LotAggregate;
using Core.Interfaces;
using Infrastructure.Identity;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using Web.ViewModels;

namespace Web.Controllers
{
    public class LotController : Controller
    {
        private readonly IAuctionService auctionService;
        private readonly UserManager<ApplicationUser> userManager;

        public LotController(
            IAuctionService auctionService,
            UserManager<ApplicationUser> userManager)
        {
            this.auctionService = auctionService;
            this.userManager = userManager;
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
            var viewModel = new LotDetailsViewModel { Lot = lot };

            return View(viewModel);
        }

        [HttpPost]
        public async Task<JsonResult> Bid([FromBody] Bid bid)
        {
            var user = await this.userManager.GetUserAsync(this.HttpContext.User);
            await this.auctionService.PlaceBidAsync(bid.LotId, bid.Amount, user.UserName);
            var lot = await this.auctionService.GetLotAsync(bid.LotId, bid.SaleId);

            return Json(new { lot.CurrentPrice, lot.NextBidAmount });
        }
    }
}