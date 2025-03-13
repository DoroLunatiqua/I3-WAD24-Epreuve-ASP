using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;

namespace DAL.Services
{
    public class PossederService : BaseService
    {
        public PossederService(IConfiguration config, string dbname) : base(config, dbname)
        {
        }
    }
}
