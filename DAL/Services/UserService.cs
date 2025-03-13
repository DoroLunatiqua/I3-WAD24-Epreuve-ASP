using Common.Repositories;
using DAL.Entities;
using DAL.Mappers;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;

using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Services
{
    public class UserService : BaseService, IUserRepository<DAL.Entities.User>
    {
        public UserService(IConfiguration config) : base(config, "Main-DB") { }

        public Guid CheckPassword(string email, string password)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = "SP_User_CheckPassword";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue(nameof(email), email);
                    command.Parameters.AddWithValue(nameof(password), password);
                    connection.Open();
                    return (Guid)command.ExecuteScalar();
                }
            }
        }

        public void Delete(Guid id)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = "SP_User_Delete";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue(nameof(id), id);
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        public IEnumerable<User> GetAll()
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = "SP_User_GetAll";
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            yield return reader.ToUser();
                        }
                    }
                }
            }
        }

        public User Get(Guid user_id)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = "SP_User_GetById";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue(nameof(user_id), user_id);
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return reader.ToUser();
                        }
                        else
                        {
                            throw new ArgumentOutOfRangeException(nameof(user_id));
                        }
                    }
                }
            }
        }

        public Guid Insert(User user)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = "SP_User_Insert";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue(nameof(User.Email), user.Email);
                    command.Parameters.AddWithValue(nameof(User.Password), user.Password);
                    command.Parameters.AddWithValue(nameof(User.Pseudo), user.Pseudo);
                    connection.Open();
                    return (Guid)command.ExecuteScalar();
                }
            }
        }

        public void Update(Guid id, User user)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = connection.CreateCommand())
                {
                    command.CommandText = "SP_User_Update";
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@UserId", id);
                    command.Parameters.AddWithValue("@Pseudo", user.Pseudo ?? (object)DBNull.Value);
                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        // RAJOUT DU GETBY EMAIL Pour le Login en solution MemoryCache
        public User GetByEmail(string email)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                using (var command = connection.CreateCommand())
                {
                    command.CommandText = "SELECT * FROM [User] WHERE Email = @Email";
                    command.Parameters.AddWithValue("@Email", email);
                    connection.Open();

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new User
                            {
                                User_Id = reader.GetGuid(reader.GetOrdinal("UserId")),
                                Email = reader.GetString(reader.GetOrdinal("Email")),
                                Pseudo = reader.GetString(reader.GetOrdinal("Pseudo")),
                                Password = reader.GetString(reader.GetOrdinal("Password")),
                                // Ajoute les autres propriétés de User ici
                            };
                        }
                        return null;
                    }
                }
            }
        }


    }
}
