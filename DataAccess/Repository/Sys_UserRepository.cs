using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;
using OurHelper;

namespace DataAccess.Repository
{
    public class Sys_UserRepository : RootRepositoryBase<Sys_User>, ISys_UserRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Sys_UserRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Sys_UserRepository(string schoolID)
        {
            SchoolID = schoolID;
        }

        /// <summary>
        ///检查登入
        /// </summary>
        /// <param name="loginID"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public Sys_User CheckLogin(string loginID, string password)
        {

            PageHelper<Sys_User> pageQuery = new PageHelper<Sys_User>();
            //四种登录方式
            ComplexKeyValue cKeyValue = new ComplexKeyValue();
            cKeyValue.QueryKeyValues.Add(new KeyValue("LoginID", loginID, KeyValueWhereType.Or));
            cKeyValue.QueryKeyValues.Add(new KeyValue("UserAccount", loginID, KeyValueWhereType.Or));
            cKeyValue.QueryKeyValues.Add(new KeyValue("Email", loginID, KeyValueWhereType.Or));
            cKeyValue.QueryKeyValues.Add(new KeyValue("MobileNumber", loginID, KeyValueWhereType.Or));
            cKeyValue.WhereType = KeyValueWhereType.And;
            pageQuery.ComplexKeyValues.Add(cKeyValue);
            //密码
            pageQuery.QueryKeyValues.Add(new KeyValue("Password", password));
            pageQuery.QueryKeyValues.Add(new KeyValue("SchoolID", base.SchoolID));

            return base.GetListPageByCustomSql(pageQuery).Data.FirstOrDefault();

        }

        public OurHelper.PageHelper<Sys_User> GetPageListAllUserRoleInfoByRoleID(OurHelper.PageHelper<Sys_User> pageQuery)
        {
            base.PageSqlTable = "  select  u.*,case isnull(ru.UserID,'') when '' then 0 when u.ID then 1 else 0  end as UserIsBelongToRole,ti.EmployeeID from [Sys_User] u left join  [Sys_RoleUser] ru on u.ID = ru.UserID left join [dbo].[Basic_TeacherInfo] ti on u.id = ti.ID ";
            pageQuery.OrderBy = " UpdateTime desc ";

            foreach (var item in pageQuery.QueryKeyValues)
            {
                if (item.Key == "RoleID")
                {
                    base.PageSqlTable = "  select  u.*,case isnull(ru.UserID,'') when '' then 0 when u.ID then 1 else 0  end as UserIsBelongToRole,ti.EmployeeID from [Sys_User] u left join  [Sys_RoleUser] ru on u.ID = ru.UserID and ru.RoleID={" + base.PageParameters.Count + "}   left join [dbo].[Basic_TeacherInfo] ti on u.id = ti.ID ";
                    base.PageParameters.Add(item.Value);
                    pageQuery.OrderBy = " UserIsBelongToRole desc, UpdateTime desc ";

                }

                if (item.Key == "SchoolID")
                {
                    base.PageSqlWhere = " and  u.SchoolID = {" + base.PageParameters.Count + "}  ";
                    base.PageParameters.Add(item.Value);
                }
                if (item.Key == "UserName")
                {
                    base.PageSqlWhere = " and (u.LoginID like {" + base.PageParameters.Count + "} or u.UserName like {" + base.PageParameters.Count + "} or ti.EmployeeID like {" + base.PageParameters.Count + "})";
                    base.PageParameters.Add("%" + item.Value + "%");
                }
                if (item.Key == "Status")
                {
                    base.PageSqlWhere = " and u.Status={" + base.PageParameters.Count + "} ";
                    base.PageParameters.Add(item.Value);
                }
            }

            return base.GetListPageByCustomSql(pageQuery);
        }

    }
}
