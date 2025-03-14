
using ASP_MVC.Handlers.Filtres;
using ASP_MVC.Mappers;
using ASP_MVC.Models.User;
using BLL.Entities;
using BLL.Services;
using Common.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;


namespace ASP_MVC.Controllers
{
    public class UserController : Controller
    {
        private IUserRepository<BLL.Entities.User> _userService;

        public UserController(IUserRepository<BLL.Entities.User> userService)
        {
            _userService = userService;
        }



        // GET: UserController
       
        public ActionResult Index()
        {
            return View();
        }

        // GET: UserController/Details/5
        public ActionResult Details(Guid id)
        {
            try
            {
                UserDetails model = _userService.Get(id).ToDetails();
                return View(model);
            }
            catch (Exception)
            {
                return RedirectToAction("Error", "Home");
            }
        }


        // GET: UserController/Create
        [AnonymousNeeded]
      
        public ActionResult Create()
        {
            return View();
        }

      
    // POST: UserController/Create
        [HttpPost]
        [AnonymousNeeded]

        public ActionResult Create (UserCreateForm form)
        {
            try
            {
                if (!form.Consent) ModelState.AddModelError(nameof(form.Consent), "Vous devez lire et accepter les conditions générales d'utilisation.");
                if (!ModelState.IsValid) throw new ArgumentException();
                Guid id = _userService.Insert(form.ToBLL());
                return RedirectToAction(nameof(Details), new { id = id });
            }
            catch
            {
                return View();
            }

        }
        // GET: UserController/Edit/{id}
        public ActionResult Edit(Guid id)
        {
            // Récupérer l'utilisateur via le service BLL
            User user = _userService.Get(id);

            if (user == null)
            {
                return NotFound(); // Si l'utilisateur n'existe pas
            }

            // Convertir en UserEditForm (DTO pour éviter d'exposer l'entité User)
            UserEditForm form = new UserEditForm
            {
                Pseudo = user.Pseudo
            };

            return View(form);
        }

        // POST: UserController/Edit/{id}
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Guid id, UserEditForm form)
        {
            try
            {
                if (!ModelState.IsValid)
                    return View(form);

                User user = _userService.Get(id); // Récupérer l'utilisateur

                if (user == null)
                    return NotFound();

                // Met à jour uniquement le pseudo
                user.Pseudo = form.Pseudo;


                _userService.Update(id, user);

                return RedirectToAction(nameof(Details), new { id = id });
            }
            catch
            {
                return View(form);
            }
        }


        // GET: UserController/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: UserController/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(Guid id, UserDelete form)
        {
            try
            {
                _userService.Delete(id);
                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return RedirectToAction(nameof(Delete), new { id = id });
            }
        }
    }
}
