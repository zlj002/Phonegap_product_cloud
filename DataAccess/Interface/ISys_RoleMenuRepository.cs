using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface ISys_RoleMenuRepository : IRepository<Sys_RoleMenu>
    {
        bool DeleteBatch(List<Sys_RoleMenu> list);
    }
}
