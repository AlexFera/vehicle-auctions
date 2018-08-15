using Core.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using System.Threading.Tasks;
using Web.ViewModels;

namespace Web.Controllers
{
    public class HomeController : Controller
    {
        private readonly ISaleRepository saleRepository;

        public HomeController(ISaleRepository saleRepository)
        {
            this.saleRepository = saleRepository;
        }

        public async Task<IActionResult> Index()
        {
            var sales = await this.saleRepository.ListActiveSalesAsync();
            foreach (var sale in sales)
            {
                break;
            }

            return View();
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
