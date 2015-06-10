using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;

namespace DataAccess.Repository
{
    public class Sys_RoleUserRepository : RepositoryBase<Sys_RoleUser>, ISys_RoleUserRepository
    {
        public bool DeleteBatch(List<Sys_RoleUser> list)
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < list.Count; i++)
            {
                if (i == 0)
                {
                    sb.Append("(RoleID='" + list[i].RoleID + "' and UserID='" + list[i].UserID + "')");
                }
                else
                {
                    sb.Append("or (RoleID='" + list[i].RoleID + "' and UserID='" + list[i].UserID + "')");
                }
            }
            return this.DeleteBatchBySqlWhere(sb.ToString()) > 0;
        }
    }
}
