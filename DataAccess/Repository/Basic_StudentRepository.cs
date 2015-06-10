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
    public class Basic_StudentRepository : RootRepositoryBase<Basic_Student>, IBasic_StudentRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Basic_StudentRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Basic_StudentRepository(string schoolID)
        {
            SchoolID = schoolID;
        }
        public override OurHelper.PageHelper<Basic_Student> GetListPage(OurHelper.PageHelper<Basic_Student> pageQuery)
        {
            base.PageSqlTable = "  select distinct t.*,u.LoginID,u.UserName  from [Basic_Student] t inner join  [Sys_User] u on t.ID = u.ID   ";
            pageQuery.OrderBy = " UpdateTime desc ";

            return base.GetListPageByCustomSql(pageQuery);
        }


        public Basic_Student GetStudentInfoByID(string ID)
        {
            return this.GetEntityByColNameAndColValue("ID",ID); 
        }
    }
}
