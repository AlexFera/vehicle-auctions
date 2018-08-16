using Microsoft.AspNetCore.Mvc;
using System;

namespace Web.Controllers
{
    public class LotController : Controller
    {
        public IActionResult Search(int saleId)
        {
            if (saleId == -1)
            {
                throw new ArgumentException("test");
            }
            return View();
        }

        public IActionResult Details()
        {
            return View();
        }
    }
}