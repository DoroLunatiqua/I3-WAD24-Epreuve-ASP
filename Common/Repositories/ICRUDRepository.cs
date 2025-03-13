using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common.Repositories
{
    public interface ICRUDRepository<TEntity, TId>
    {
        IEnumerable<TEntity> GetAll();
        TEntity Get(TId id);
        TId Insert(TEntity entity);
        void Update(TId id, TEntity entity);
        void Delete(TId id);
    }
}
