using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;

namespace DataAccess.Repository
{
    public class Sys_RoleMenuRepository : RepositoryBase<Sys_RoleMenu>, ISys_RoleMenuRepository
    {
        public bool DeleteBatch(List<Sys_RoleMenu> list)
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < list.Count; i++)
            {
                if (i == 0)
                {
                    sb.Append("(RoleID='" + list[i].RoleID + "' and MenuID='" + list[i].MenuID + "')");
                }
                else
                {
                    sb.Append("or (RoleID='" + list[i].RoleID + "' and MenuID='" + list[i].MenuID + "')");
                }
            }
            return this.DeleteBatchBySqlWhere(sb.ToString()) > 0;
        }
    }
}
