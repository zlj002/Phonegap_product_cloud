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
    public class Basic_OrganizeRepository : RootRepositoryBase<Basic_Organize>, IBasic_OrganizeRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Basic_OrganizeRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Basic_OrganizeRepository(string schoolID)
        {
            SchoolID = schoolID;
        }


        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Basic_OrganizeRepository(string schoolID, string currentUserID)
        {
            base.SchoolID = schoolID;
            base.CurrentUserID = currentUserID;
        }
        public List<Basic_Organize> GetOrganizeByCurrentUser()
        {
            PageHelper<Basic_Organize> pageQuery = new PageHelper<Basic_Organize>();
            base.PageSqlTable = "  select bo.* from Basic_OrganizeUser_Relationship bour inner join Basic_Organize bo on bour.SchoolID = bo.SchoolID and bour.OrganizeID = bo.ID ";
            pageQuery.PageSize = 1000;
            pageQuery.OrderBy = " SchoolID asc ";
            pageQuery.QueryKeyValues.Add(new KeyValue("bour.SchoolID", base.SchoolID, KeyValueOperatorType.Equal)); pageQuery.QueryKeyValues.Add(new KeyValue("bour.UserID", base.CurrentUserID, KeyValueOperatorType.Equal));
            return base.GetListPageByCustomSql(pageQuery).Data;
             
        }
    }
}
