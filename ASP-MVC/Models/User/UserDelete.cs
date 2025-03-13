using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace ASP_MVC.Models.User
{
    public class UserDelete
    {
        [DisplayName("Pseudo")]
        public string Pseudo { get; set; }
        
        [DisplayName("E-mail")]
        [EmailAddress]
        public string Email { get; set; }

        [DisplayName("Password")]
        [DataType(DataType.Password)]

        public string Password { get; set; }


    }
}
