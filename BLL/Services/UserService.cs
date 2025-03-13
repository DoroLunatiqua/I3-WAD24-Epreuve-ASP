using BLL.Entities;
using BLL.Mappers;
using Common.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Services
{
    public class UserService : IUserRepository<User>
    {
        private IUserRepository<DAL.Entities.User> _userService;

        public UserService(
            IUserRepository<DAL.Entities.User> userService)
        {
            _userService = userService;
        }


        public IEnumerable<User> GetAll()
        {
            return _userService.GetAll().Select(dal => dal.ToBLL());
        }

        public Guid Insert(User user)
        {
            return _userService.Insert(user.ToDAL());
        }

        public User Get(Guid id)
        {
            User user = _userService.Get(id).ToBLL();
            return user;
        }

        public void Update(Guid id, User user)
        {
            if (user is null) throw new ArgumentNullException(nameof(user));

            _userService.Update(id, user.ToDAL());
        }

        public Guid CheckPassword(string email, string password)
        {
            return _userService.CheckPassword(email, password);

        }

        public void Delete(Guid id)
        {
            _userService.Delete(id);
        }


        //public User Login(string email, string password)
        //{
        //    // 1. Chercher l'utilisateur en base de données (DAL)
        //    User user = _userService.GetByEmail(email); // Appelle ta méthode GetByEmail qui récupère l'utilisateur par son email

        //    // 2. Vérifier si l'utilisateur existe et si le mot de passe est correct
        //    if (user == null || user.Password != password)
        //    {
        //        // Si l'utilisateur n'existe pas ou le mot de passe est incorrect, on retourne null
        //        return null;
        //    }

        //    // 3. Si l'utilisateur est authentifié, on le met dans le cache (MemoryCache)
        //    _memoryCache.Set(user.User_Id.ToString(), user, TimeSpan.FromMinutes(30)); // Cache l'utilisateur pour 30 minutes

        //    // 4. On peut également stocker l'ID de l'utilisateur dans la session pour le retrouver facilement
        //    // Le code pour la session serait dans le controller, pas ici

        //    return user; // Retourner l'utilisateur authentifié
        //}


    }
}
