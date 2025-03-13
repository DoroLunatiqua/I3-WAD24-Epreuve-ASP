using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Common.Repositories;
using BLL.Entities;
using BLL.Mappers;
using DAL.Services;


namespace BLL.Services
{
    public class PossederService : IPossederRepository<Posseder>
    {

        private IPossederRepository<DAL.Entities.Posseder> _possederService;
        private readonly IUserRepository<DAL.Entities.User> _userService;


        public PossederService(IPossederRepository<DAL.Entities.Posseder> possederService, IUserRepository<DAL.Entities.User> userService)
        {
            _possederService = possederService;
            _userService = userService;
        }


        public void Delete(Guid id)
        {
           _possederService.Delete(id);
        }

        public bool Exists(Guid user_id, Guid jeu_id)
        {
            return _possederService.Exists(user_id, jeu_id);
        }

        public Posseder Get(Guid id)
        {
            var posseder = _possederService.Get(id);
            return posseder?.ToBLL();
        }

        public IEnumerable<Posseder> GetAll()
        {
            return _possederService.GetAll().Select(dal => dal.ToBLL());
        }

        public IEnumerable<Posseder> GetByUserId(Guid user_id)// permet de voir les possessions de Un user.
        {
            // Récupère tous les jeux possédés par un utilisateur en BLL
            var posseders = _possederService.GetByUserId(user_id)
                                .Select(dal => dal.ToBLL()) // Convertir chaque Posseder de DAL à BLL
                                .ToArray();

            // Récupère l'utilisateur via l'ID
            var user = _userService.Get(user_id)?.ToBLL(); // On récupère l'utilisateur pour associer à chaque posséder

            // Associe l'utilisateur à chaque Posseder
            foreach (var posseder in posseders)
            {
                posseder.SetUser(user); // Affecte l'utilisateur à chaque Posseder
            }

            return posseders; // Retourne la liste des possessions



        }

        public Guid Insert(Posseder posseder)
        {
            return _possederService.Insert(posseder.ToDaL());
        }

        public void Update(Guid id, Posseder posseder)
        {
            _possederService.Update(id, posseder.ToDaL());
        }
    }
}

