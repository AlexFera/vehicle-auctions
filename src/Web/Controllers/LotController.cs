using Core.Interfaces;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
using Web.ViewModels;

namespace Web.Controllers
{
    public class LotController : Controller
    {
        private readonly ILotRepository lotRepository;

        public LotController(ILotRepository lotRepository)
        {
            this.lotRepository = lotRepository;
        }

        public async Task<IActionResult> Search(int saleId)
        {
            var lots = await this.lotRepository.ListLotsAsync(saleId);
            var viewModel = new LotSearchViewModel { Lots = lots };

            return View(viewModel);
        }

        public IActionResult Details()
        {
            return View();
        }
    }
}