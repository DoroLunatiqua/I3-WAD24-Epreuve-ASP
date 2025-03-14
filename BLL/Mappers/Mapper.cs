﻿using BLL.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using D = DAL.Entities;

namespace BLL.Mappers
{
    internal static class Mapper
    {

        public static User ToBLL(this D.User user)
        {
            if (user is null) throw new ArgumentNullException(nameof(user));
            return new User(
                user.User_Id,
                user.Email,
                user.Password,
                user.Pseudo,
                user.CreatedAt

                );
        }

        public static D.User ToDAL(this User user)
        {
            if (user is null) throw new ArgumentNullException(nameof(user));
            return new D.User()
            {
                User_Id = user.User_Id,
                Email = user.Email,
                Password = user.Password,
                Pseudo = user.Pseudo,
                CreatedAt = user.CreatedAt,

            };
        }

        public static Posseder ToBLL(this D.Posseder posseder) {
            if (posseder == null) return null;

            return new Posseder
            {
                PossederId = posseder.PossederId,
                UserId = posseder.UserId,
                JeuId = posseder.JeuId,
                Etat = posseder.Etat
            };
        }
        public static D.Posseder ToDaL(this Posseder posseder) 
        {
            if (posseder == null) return null;

            return new D.Posseder
            {
                PossederId = posseder.PossederId,
                UserId = posseder.UserId,
                JeuId = posseder.JeuId,
                Etat = posseder.Etat
            };
        }
            



     }

}
