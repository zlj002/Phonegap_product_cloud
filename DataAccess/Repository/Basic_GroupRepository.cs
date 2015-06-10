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
    public class Basic_GroupRepository : RootRepositoryBase<Basic_Group>, IBasic_GroupRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Basic_GroupRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Basic_GroupRepository(string schoolID)
        {
            SchoolID = schoolID;
        }


        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Basic_GroupRepository(string schoolID, string currentUserID)
        {
            base.SchoolID = schoolID;
            base.CurrentUserID = currentUserID;
        }
        public List<Basic_Group> GetGroupByCurrentUser()
        {

            PageHelper<Basic_Group> pageQuery = new PageHelper<Basic_Group>();
            base.PageSqlTable = " select bo.* from Basic_GroupUser_Relationship bour  inner join   Basic_Group bo on bour.SchoolID = bo.SchoolID  and bour.GroupID = bo.ID ";
            pageQuery.OrderBy = " OrderIndex asc,UpdateTime DESC ";
            pageQuery.PageSize = 1000;
            pageQuery.QueryKeyValues.Add(new KeyValue("bour.SchoolID", base.SchoolID, KeyValueOperatorType.Equal));
            pageQuery.QueryKeyValues.Add(new KeyValue("bour.UserID", base.CurrentUserID, KeyValueOperatorType.Equal));

            return base.GetListPageByCustomSql(pageQuery).Data;
             
        }
    }
}
