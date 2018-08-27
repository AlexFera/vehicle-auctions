using Core.Entities.LotAggregate;
using Core.Interfaces;
using Infrastructure.Identity;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using System.Threading.Tasks;
using Web.Hubs;
using Web.ViewModels;

namespace Web.Controllers
{
    public class LotController : Controller
    {
        private readonly IAuctionService auctionService;
        private readonly UserManager<ApplicationUser> userManager;
        private readonly IHubContext<BiddingHub> biddingHubContext;

        public LotController(
            IAuctionService auctionService,
            UserManager<ApplicationUser> userManager,
            IHubContext<BiddingHub> biddingHubContext)
        {
            this.auctionService = auctionService;
            this.userManager = userManager;
            this.biddingHubContext = biddingHubContext;
        }

        public async Task<IActionResult> List(int? saleId, string countryCode)
        {
            var lots = await this.auctionService.ListLotsAsync(saleId, countryCode);
            var viewModel = new LotSearchViewModel { Lots = lots, CountryCode = countryCode };

            return View(viewModel);
        }

        public async Task<IActionResult> Details(int lotId, int saleId, string countryCode)
        {
            var lot = await this.auctionService.GetLotAsync(lotId, saleId, countryCode);
            var viewModel = new LotDetailsViewModel { Lot = lot, CountryCode = countryCode };

            return View(viewModel);
        }

        [HttpPost]
        public async Task<EmptyResult> Bid([FromBody] Bid bid)
        {
            var user = await this.userManager.GetUserAsync(this.HttpContext.User);
            await this.auctionService.PlaceBidAsync(bid.LotId, bid.Amount, user.UserName, bid.SaleId, bid.CountryCode);
            var lot = await this.auctionService.GetLotAsync(bid.LotId, bid.SaleId, bid.CountryCode);

            await this.biddingHubContext.Clients.All.SendAsync("ReceiveMessage", user.UserName, new { lot.CurrentPrice, lot.NextBidAmount, lot.Id, bid.CountryCode });

            return new EmptyResult();
        }
    }
}