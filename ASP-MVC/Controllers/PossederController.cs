using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace ASP_MVC.Controllers
{
    public class PossederController : Controller
    {
        // GET: PossederController
        public ActionResult Index()
        {
            return View();
        }

        // GET: PossederController/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: PossederController/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: PossederController/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: PossederController/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: PossederController/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: PossederController/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: PossederController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }
    }
}
