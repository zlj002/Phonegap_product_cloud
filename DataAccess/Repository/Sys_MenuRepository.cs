using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;

namespace DataAccess.Repository
{
    public class Sys_MenuRepository : RepositoryBase<Sys_Menu>, ISys_MenuRepository
    {
        public OurHelper.PageHelper<Sys_Menu> GetPageListAllMenuRoleInfoByRoleID(OurHelper.PageHelper<Sys_Menu> pageQuery)
        {
            base.PageSqlTable = "  SELECT * FROM [dbo].[Sys_Menu] where 1=1 ";
            foreach (var item in pageQuery.QueryKeyValues)
            {
                if (item.Key == "RoleID")
                {
                    //base.PageSqlTable = "  select  r.*,case isnull(ru.MenuID,'') when '' then 0 when r.MenuID then 1 else 0  end as MenuIsBelongToRole from [Sys_Menu] r left join  [Sys_RoleMenu] ru on r.MenuID = ru.MenuID and ru.RoleID={"+base.PageParameters.Count+"} ";
                    //base.PageParameters.Add(item.Value);
                    StringBuilder sb = new StringBuilder();
                    sb.Append(" select * from (select  r.MenuID,r.MenuName,r.ParentMenuID,r.MenuIconClass,r.Depth,r.DisplayIndex,r.UpdateTime,   ");
                    sb.Append(" case isnull(ru.MenuID,'') when '' then 0 when r.MenuID then 1 else 0  end as MenuIsBelongToRole    ");
                    sb.Append(" ,MenuType='menu'   ");
                    sb.Append(" from [Sys_Menu] r   ");
                    sb.Append(" left join  [Sys_RoleMenu] ru    ");
                    sb.Append(" on r.MenuID = ru.MenuID and ru.RoleID={" + base.PageParameters.Count + "}    ");
                    base.PageParameters.Add(item.Value);
                    sb.Append(" where  1=1   and r.Status=1   ");
                    sb.Append(" union    ");
                    sb.Append(" select so.OperationID,so.OperationName,smo.MenuID,so.OperationClass,10,so.DisplayIndex,so.UpdateTime,   ");
                    sb.Append(" case isnull(srmo.OperationID,'') when '' then 0 when so.OperationID then 1 else 0  end as MenuIsBelongToRole    ");
                    sb.Append(" ,MenuType='operation'   ");
                    sb.Append(" from [Sys_MenuOperation] smo   ");
                    sb.Append(" left join Sys_Operation so    ");
                    sb.Append(" on smo.OperationID = so.OperationID   ");
                    sb.Append(" left join    ");
                    sb.Append(" [Sys_RoleMenuOperation] srmo   ");
                    sb.Append(" on smo.MenuID = srmo.MenuID and smo.OperationID=srmo.OperationID and srmo.RoleID={" + base.PageParameters.Count + "}     ");
                    base.PageParameters.Add(item.Value);
                    sb.Append(" where  1=1   and so.Status=1 ) Data   ");
                    base.PageSqlTable = sb.ToString();
                }

                if (item.Key == "Status")
                {
                    //base.PageSqlWhere = " and r.Status={" + base.PageParameters.Count + "} ";
                    //base.PageParameters.Add(item.Value);
                }
            }
            pageQuery.OrderBy = " Depth asc,DisplayIndex asc, UpdateTime desc ";

            return base.GetListPageByCustomSql(pageQuery);
        }


        public OurHelper.PageHelper<Sys_Menu> GetMenuListByUserID(OurHelper.PageHelper<Sys_Menu> pageQuery)
        {
            base.PageSqlTable = "  SELECT distinct m.* FROM [Sys_RoleMenu] rm inner join Sys_Menu m on rm.menuid=m.menuid inner join Sys_RoleUser ru on rm.RoleID = ru.RoleID  inner join Sys_Role r on rm.RoleID = r.RoleID  ";
            pageQuery.OrderBy = " Depth asc,DisplayIndex asc, UpdateTime desc  ";

            return GetListPageByCustomSql(pageQuery);
        }
    }
}
