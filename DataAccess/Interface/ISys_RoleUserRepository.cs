using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface ISys_RoleUserRepository : IRepository<Sys_RoleUser>
    {
        bool DeleteBatch(List<Sys_RoleUser> list);
    }
}
