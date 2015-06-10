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
    public class Sys_PushMessageRepository : RootRepositoryBase<Sys_PushMessage>, ISys_PushMessageRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Sys_PushMessageRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Sys_PushMessageRepository(string schoolID)
        {
            SchoolID = schoolID;
        }




        public List<Sys_PushMessage> GetBadgeCountByUserID(string userID)
        {
            PageHelper<Sys_PushMessage> pageQuery = new PageHelper<Sys_PushMessage>();
            base.PageSqlTable = " select * from (select FeatureID,COUNT(1) BadgeCount from [dbo].[Sys_PushMessage] where UserID ={"+base.PageParameters.Count+"}  group by FeatureID) Data ";
            base.PageParameters.Add(userID);
            pageQuery.OrderBy = " FeatureID DESC ";
            pageQuery.PageSize = 1000; 

            return base.GetListPageByCustomSql(pageQuery).Data;
        }
    }
}
