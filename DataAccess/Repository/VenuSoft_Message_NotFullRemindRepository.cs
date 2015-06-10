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
    public class VenuSoft_Message_NotFullRemindRepository : RootRepositoryBase<VenuSoft_Message_NotFullRemind>, IVenuSoft_Message_NotFullRemindRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public VenuSoft_Message_NotFullRemindRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public VenuSoft_Message_NotFullRemindRepository(string schoolID)
        {
            SchoolID = schoolID;
        }


        public override OurHelper.PageHelper<VenuSoft_Message_NotFullRemind> GetListPage(OurHelper.PageHelper<VenuSoft_Message_NotFullRemind> pageQuery)
        {
            base.PageSqlTable = " select * from ( "
                                  + " SELECT * FROM [dbo].[VenuSoft_Message_NotFullRemind] r INNER JOIN [dbo].[VenuSoft_User] u ON r.UserID=u.ID "
                                + " ) A ";
            return base.GetListPageByCustomSql(pageQuery);
        }
    }
}
