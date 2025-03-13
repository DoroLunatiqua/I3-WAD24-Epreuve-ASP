using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace BLL.Entities
{
    public class Posseder
    {
        public int PossederId { get; set; }
        public Guid UserId { get; set; }
        public Guid JeuId { get; set; }
        public string Etat { get; set; }


        // Propriété pour l'utilisateur
        public User? Utilisateur { get; private set; }
        // Constructeur sans l'utilisateur obligatoire
        public Posseder()
        {
        }

        // Constructeur qui garantit que l'utilisateur est toujours fourni
        public Posseder(User utilisateur)
        {
            Utilisateur = utilisateur ?? throw new ArgumentNullException(nameof(utilisateur), "L'utilisateur ne peut pas être null.");
        }

        // Méthode pour associer un utilisateur à un posséder
        public void SetUser(User utilisateur)
        {
            if (utilisateur != null)
            {
                Utilisateur = utilisateur;
            }
            else
            {
                throw new ArgumentNullException(nameof(utilisateur), "L'utilisateur ne peut pas être null.");
            }
        }
    }
}
