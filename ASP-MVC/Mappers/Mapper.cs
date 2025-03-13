
using ASP_MVC.Models.User;
using BLL.Entities;


namespace ASP_MVC.Mappers
{
    internal static class Mapper
    {
        public static UserDetails ToDetails(this User user)
        {
            if (user is null) throw new ArgumentNullException(nameof(user));
            return new UserDetails()
            {
                User_Id = user.User_Id,
                Pseudo = user.Pseudo,
                Email = user.Email,
                CreatedAt = DateOnly.FromDateTime(user.CreatedAt),

            };
        }

        public static User ToBLL(this UserCreateForm user)
        {
            if (user is null) throw new ArgumentNullException(nameof(user));
            return new User(
                Guid.Empty,
                user.Email,
                user.Password,
                user.Pseudo,
                DateTime.Now
                );
        }
    }
}
