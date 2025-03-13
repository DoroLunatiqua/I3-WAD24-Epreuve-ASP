using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL.Entities
{
    public class Posseder
    {
       
            public int PossederId { get; set; }
            public Guid UserId { get; set; }
            public Guid JeuId { get; set; }
            public string Etat { get; set; }
      }
 }




