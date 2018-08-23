using Core.Entities.LotAggregate;
using Core.Interfaces;
using Infrastructure.Identity;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using System.Collections.Generic;
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

        public async Task<IActionResult> Search(int? saleId)
        {
            var lots = await this.auctionService.ListLotsAsync(saleId);
            var viewModel = new LotSearchViewModel { Lots = lots };

            return View(viewModel);
        }

        public async Task<IActionResult> Details(int lotId, int saleId)
        {
            var lot = await this.auctionService.GetLotAsync(lotId, saleId);
            var viewModel = new LotDetailsViewModel { Lot = lot };

            return View(viewModel);
        }

        [HttpPost]
        public async Task<EmptyResult> Bid([FromBody] Bid bid)
        {
            var user = await this.userManager.GetUserAsync(this.HttpContext.User);
            await this.auctionService.PlaceBidAsync(bid.LotId, bid.Amount, user.UserName, bid.SaleId);
            var lot = await this.auctionService.GetLotAsync(bid.LotId, bid.SaleId);

            await this.biddingHubContext.Clients.All.SendAsync("ReceiveMessage", user.UserName, new { lot.CurrentPrice, lot.NextBidAmount, lot.Id });

            return new EmptyResult();
        }
    }
}