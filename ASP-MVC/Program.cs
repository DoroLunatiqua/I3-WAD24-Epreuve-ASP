using Common.Repositories;
using ASP_MVC.Handlers;

namespace ASP_MVC
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);


            // Add services to the container.
            builder.Services.AddControllersWithViews();
            //Ajout d'implémentation du service d'accès à l'HttpContext
            //(dans le but d'atteindre nos variables de session en dehors du controller ou de la vue)
            builder.Services.AddHttpContextAccessor();

            builder.Services.AddDistributedMemoryCache();
            //   options =>
            //   {
            //       options.ConnectionString = builder.Configuration.GetConnectionString("Session-DB");
            //       options.SchemaName = "dbo";
            //       options.TableName = "Session";
            //   }
            //   );
            builder.Services.AddSession(
                options => {
                    options.Cookie.Name = "CookieWad24";
                    options.Cookie.HttpOnly = true;
                    options.Cookie.IsEssential = true;
                    options.IdleTimeout = TimeSpan.FromMinutes(10);
                });
            builder.Services.Configure<CookiePolicyOptions>(options => {
                options.CheckConsentNeeded = context => true;
                options.MinimumSameSitePolicy = SameSiteMode.None;
                options.Secure = CookieSecurePolicy.Always;
            });

            builder.Services.AddScoped<IUserRepository<BLL.Entities.User>, BLL.Services.UserService>();
            builder.Services.AddScoped<IUserRepository<DAL.Entities.User>, DAL.Services.UserService>();
            builder.Services.AddScoped<SessionManager>();
            //builder.Services.AddMemoryCache();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (!app.Environment.IsDevelopment())
            {
                app.UseExceptionHandler("/Home/Error");
                app.UseHsts();
            }
            app.UseSession();
            app.UseCookiePolicy();

            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthorization();

            app.MapControllerRoute(
                name: "default",
                pattern: "{controller=Home}/{action=Index}/{id?}");

            app.Run();
        }
    }
}
