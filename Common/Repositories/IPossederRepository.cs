using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Repositories
{
    public interface IPossederRepository<TPosseder> : ICRUDRepository<TPosseder, Guid>
    {
        // Récupère tous les jeux d'un utilisateur (la collection)
        IEnumerable<TPosseder> GetByUserId(Guid userId);

        // Vérifie si un utilisateur possède déjà un jeu spécifique
        bool Exists(Guid user_id, Guid jeu_id);

        // Met à jour l'état d'un jeu pour un utilisateur
       // void UpdateGameState(int possederId, string newState); // Update dans la procédure Stockée
    }
}
