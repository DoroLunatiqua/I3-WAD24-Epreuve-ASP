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


        public IEnumerable<User> Get()
        {
            return _userService.Get().Select(dal => dal.ToBLL());
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
    }
}
