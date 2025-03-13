using DAL.Entities;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Mappers
{
    internal static class Mapper
    {
        public static User ToUser(this IDataRecord record)
        {
            if (record is null) throw new ArgumentNullException(nameof(record));
            //if (record is null) return null;
            return new User()
            {
                User_Id = (Guid)record[nameof(User.User_Id)],
                Pseudo = (string)record[nameof(User.Pseudo)],
                Email = (string)record[nameof(User.Email)],
                Password = "********",
                CreatedAt = (DateTime)record[nameof(User.CreatedAt)],
                DisabledAt = (record[nameof(User.DisabledAt)] is DBNull) ? null : (DateTime?)record[nameof(User.DisabledAt)],
            };
        }


        public static Posseder ToPosseder(this IDataRecord record)
        {
            if (record is null) throw new ArgumentNullException(nameof(record));

            return new Posseder()
            {
                PossederId = (int)record[nameof(Posseder.PossederId)],
                UserId = (Guid)record[nameof(Posseder.UserId)],
                JeuId = (Guid)record[nameof(Posseder.JeuId)],
                Etat = (string)record[nameof(Posseder.Etat)]
            };
        }



    }


}
