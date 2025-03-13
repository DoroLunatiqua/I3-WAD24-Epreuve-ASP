using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using BLL.Services;
using BLL.Entities;


public class AuthController : Controller
{
    private readonly IMemoryCache _memoryCache;
    private readonly UserService _userService;

    public AuthController(IMemoryCache memoryCache, UserService userService)
    {
        _memoryCache = memoryCache;
        _userService = userService;
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
}
