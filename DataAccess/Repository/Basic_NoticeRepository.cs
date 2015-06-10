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
    public class Basic_NoticeRepository : RootRepositoryBase<Basic_Notice>, IBasic_NoticeRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Basic_NoticeRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Basic_NoticeRepository(string schoolID)
        {
            SchoolID = schoolID;
        }


        public List<Basic_Notice> GetListByReceiveUserID(string receiveUserID, ref int totalCount, ref int pageIndex, ref int pageSize)
        {
            PageHelper<Basic_Notice> pageQuery = new PageHelper<Basic_Notice>();
            base.PageSqlTable = "  SELECT n.*,u1.UserName AS SenderUserName,u2.UserName AS ReceiveUserName FROM [dbo].[Basic_Notice] n INNER JOIN  [dbo].[Basic_NoticeUser_Relationship]r  ON r.NoticeID=n.ID LEFT JOIN dbo.Sys_User u1 ON u1.ID=n.SendUserID LEFT JOIN dbo.Sys_User u2 ON r.UserID=u2.ID ";
            pageQuery.PageIndex = pageIndex;
            pageQuery.PageSize = pageSize;
            pageQuery.QueryKeyValues.Add(new KeyValue("r.UserID", receiveUserID, KeyValueOperatorType.Equal)); pageQuery.QueryKeyValues.Add(new KeyValue("n.SchoolID", base.SchoolID, KeyValueOperatorType.Equal));
            var result  = base.GetListPageByCustomSql(pageQuery);
            totalCount = result.TotalCount;
            return result.Data;

             
        }


        public Basic_Notice GetNoticeByID(string ID)
        {
            return this.GetEntityByColNameAndColValue("ID", ID);
        }
    }
}
