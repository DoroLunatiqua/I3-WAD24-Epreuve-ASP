using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using BLL.Services;
using BLL.Entities;
using ASP_MVC.Handlers;
using Common.Repositories;
using ASP_MVC.Models.Auth;
using ASP_MVC.Handlers.Filtres;


public class AuthController : Controller
{
    private IUserRepository<BLL.Entities.User> _userService;
    private SessionManager _sessionManager;

    public AuthController(
        IUserRepository<User> userService,
        SessionManager sessionManager
        )
    {
        _userService = userService;
        _sessionManager = sessionManager;
    }

    [AnonymousNeeded]
    public IActionResult Login()
    {
        /* Méthode vérifie si l'utilisateur à le droit ou non d'accéder à la page...*/
        if(_sessionManager.ConnectedUser is not null)
        {
            return RedirectToAction("Index", "Home");
        }
        return View();
    }
    [HttpPost]
    [AnonymousNeeded]
    public IActionResult Login(AuthLoginForm form)
    {
        try
        {
            if (!ModelState.IsValid) throw new ArgumentException(nameof(form));
            Guid id = _userService.CheckPassword(form.Email, form.Password);
            //C'est ici que nous définirons la variable de session
            User user = _userService.Get(id);

            ConnectedUser sessionUser = new ConnectedUser()
            {
                User_Id = user.User_Id,
                Email = user.Email,
                Pseudo = user.Pseudo,
            };
            _sessionManager.Login(sessionUser);
            return RedirectToAction("Details", "User", new { id = id }); //("Index", "Home");
        }
        catch (Exception)
        {
            return View();
        }
    }

        [ConnectionNeeded]
        public IActionResult Logout()
        {
            return View();
        }

        [HttpPost]
        [ConnectionNeeded]
        public IActionResult Logout(IFormCollection form)
        {
            try
            {
                _sessionManager.Logout();
                return RedirectToAction(nameof(Login));
            }
            catch (Exception)
            {
                return View();
            }
        }
    
    }

    //[HttpPost]
    //public IActionResult Login(LoginForm form)
    //{
    //    User user = _userService.Login(form.Email, form.Password);

    //    if (user == null)
    //    {
    //        ModelState.AddModelError("", "Email ou mot de passe incorrect.");
    //        return View(form);
    //    }

    //    // Stocker l'utilisateur dans MemoryCache
    //    _memoryCache.Set(user.User_Id.ToString(), user, TimeSpan.FromMinutes(30));

    //    // Stocker uniquement l'ID User en Session (pour lier à la cache)
    //    HttpContext.Session.SetString("UserId", user.User_Id.ToString());

    //    return RedirectToAction("Index", "Home");
    //}

