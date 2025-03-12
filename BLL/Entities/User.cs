using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BLL.Entities
{
    public class User
    {
        public Guid User_Id { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string Pseudo {  get; set; }
        public DateTime CreatedAt { get; set; }

        private DateTime? _disabledAt;

        public bool IsDisabled
        {
            get { return _disabledAt is not null; }
        }

        public User(Guid user_Id, string email, string password, string pseudo, DateTime createdAt)
        {
            User_Id = user_Id;
            Email = email;
            Password = password;
            Pseudo = pseudo;
            CreatedAt = createdAt;
        }


    }
}
