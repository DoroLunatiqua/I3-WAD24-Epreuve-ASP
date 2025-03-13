using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Numerics;

namespace ASP_MVC.Models.User
{
    public class UserDetails
    {

        [ScaffoldColumn(false)]
        public Guid User_Id { get; set; }

        [DisplayName("Pseudo : ")]
        public string Pseudo { get; set; }

        [DisplayName("E-mail : ")]
        [EmailAddress]
        public string Email { get; set; }
        [DisplayName("Date d'inscription : ")]
        [DataType(DataType.Date)]
        public DateOnly CreatedAt { get; set; }
    }
}
