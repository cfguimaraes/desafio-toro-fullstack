namespace Toro.Controllers
{

    using Microsoft.AspNetCore.Mvc;

    public class SyncController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Sync()
        {
            ViewData["Message"] = "Your welcome message";

            return View();
        }
    }
}