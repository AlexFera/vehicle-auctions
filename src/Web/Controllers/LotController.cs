using Microsoft.AspNetCore.Mvc;

namespace Web.Controllers
{
    public class LotController : Controller
    {
        public IActionResult Search()
        {
            return View();
        }

        public IActionResult Details()
        {
            return View();
        }
    }
}