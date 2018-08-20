using Core.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using System.Threading.Tasks;
using Web.ViewModels;

namespace Web.Controllers
{
    public class HomeController : Controller
    {
        private readonly IAuctionService auctionService;

        public HomeController(IAuctionService auctionService)
        {
            this.auctionService = auctionService;
        }

        public async Task<IActionResult> Index()
        {
            var activeSales = await this.auctionService.ListActiveSalesAsync();
            var viewModel = new SaleViewModel { ActiveSales = activeSales };

            return View(viewModel);
        }

        public IActionResult About()
        {
            ViewData["Message"] = "Your application description page.";

            return View();
        }

        public IActionResult Contact()
        {
            ViewData["Message"] = "Your contact page.";

            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
