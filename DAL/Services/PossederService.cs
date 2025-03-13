using System;
using System.Collections.Generic;
using System.Data;
using Common.Repositories;
using DAL.Entities;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;

namespace DAL.Services
{
    public class PossederService : BaseService, IPossederRepository<Posseder>
    {
        public PossederService(IConfiguration config) : base(config, "Main-DB") { }

        // Vérifie si l'utilisateur possède déjà le jeu
        public bool Exists(Guid user_id, Guid jeu_id)
        {
            bool exists = false;
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_Posseder_CheckUserGame", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@UserId", user_id);
                    command.Parameters.AddWithValue("@JeuId", jeu_id);
                    connection.Open();

                    var result = command.ExecuteScalar();
                    exists = result != null && (int)result == 1;
                }
            }
            return exists;
        }

        // Récupère une possession par son ID
        public Posseder Get(Guid id)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_Posseder_GetById", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@PossederId", id);
                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new Posseder
                            {
                                PossederId = reader.GetInt32(0),
                                UserId = reader.GetGuid(1),
                                JeuId = reader.GetGuid(2),
                                Etat = reader.GetString(3)
                            };
                        }
                    }
                }
            }
            return null;
        }

        // Récupère tous les jeux possédés par tous les utilisateurs
        public IEnumerable<Posseder> GetAll()
        {
            List<Posseder> possessions = new List<Posseder>();

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_Posseder_GetAll", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            possessions.Add(new Posseder
                            {
                                PossederId = reader.GetInt32(0),
                                UserId = reader.GetGuid(1),
                                JeuId = reader.GetGuid(2),
                                Etat = reader.GetString(3)
                            });
                        }
                    }
                }
            }

            return possessions;
        }

        // Récupère tous les jeux possédés par un utilisateur spécifique
        public IEnumerable<Posseder> GetByUserId(Guid userId)
        {
            List<Posseder> possessions = new List<Posseder>();

            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_Posseder_GetByUserId", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@UserId", userId);
                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            possessions.Add(new Posseder
                            {
                                PossederId = reader.GetInt32(0),
                                UserId = reader.GetGuid(1),
                                JeuId = reader.GetGuid(2),
                                Etat = reader.GetString(3)
                            });
                        }
                    }
                }
            }

            return possessions;
        }

        // Insère une nouvelle possession
        public Guid Insert(Posseder entity)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_Posseder_Insert", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@UserId", entity.UserId);
                    command.Parameters.AddWithValue("@JeuId", entity.JeuId);
                    command.Parameters.AddWithValue("@Etat", entity.Etat);

                    connection.Open();

                    return (Guid)command.ExecuteScalar();
                }
            }
        }

        // Met à jour l'état d'un jeu possédé (seul l'état est modifiable selon ton énoncé)
        public void Update(Guid id, Posseder entity)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_Posseder_Update", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@PossederId", id);
                    command.Parameters.AddWithValue("@Etat", entity.Etat);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        // Supprime une possession
        public void Delete(Guid id)
        {
            using (SqlConnection connection = new SqlConnection(_connectionString))
            {
                using (SqlCommand command = new SqlCommand("SP_Posseder_Delete", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@PossederId", id);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }
    }
}
