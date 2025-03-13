using System.ComponentModel.DataAnnotations;

namespace ASP_MVC.Models.User
{
    public class UserEditForm
    {
        [Required]
        [StringLength(100, MinimumLength = 3, ErrorMessage = "Le pseudo doit contenir entre 3 et 100 caractères.")]
        public string Pseudo { get; set; }
    }

}
