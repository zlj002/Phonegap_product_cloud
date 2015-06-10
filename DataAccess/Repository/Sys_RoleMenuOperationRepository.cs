using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;

namespace DataAccess.Repository
{
    public class Sys_RoleMenuOperationRepository : RepositoryBase<Sys_RoleMenuOperation>, ISys_RoleMenuOperationRepository
    {

 

        public bool DeleteBatch(List<Sys_RoleMenuOperation> list)
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < list.Count; i++)
            {
                if (i == 0)
                {
                    sb.Append("(RoleID='" + list[i].RoleID + "' and MenuID='" + list[i].MenuID + "' and OperationID='"+list[i].OperationID+"' )");
                }
                else
                {
                    sb.Append("or (RoleID='" + list[i].RoleID + "' and MenuID='" + list[i].MenuID + "' and OperationID='" + list[i].OperationID + "' )");
                }
            }
            return this.DeleteBatchBySqlWhere(sb.ToString()) > 0;
        }


        public OurHelper.PageHelper<Sys_RoleMenuOperation> GetOperationListByUserID(OurHelper.PageHelper<Sys_RoleMenuOperation> pageQuery)
        {
            //        

            base.PageSqlTable = "  SELECT distinct srmo.* FROM Sys_RoleMenuOperation srmo  inner join Sys_RoleUser ru on srmo.RoleID = ru.RoleID  ";
            pageQuery.OrderBy = " OperationID asc   ";
            return base.GetListPageByCustomSql(pageQuery);
        }
    }
}
