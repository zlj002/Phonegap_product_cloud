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
    public class Sys_SMSDetailLogRepository : RootRepositoryBase<Sys_SMSDetailLog>, ISys_SMSDetailLogRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Sys_SMSDetailLogRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Sys_SMSDetailLogRepository(string schoolID)
        {
            SchoolID = schoolID;
        }


        public List<Sys_SMSDetailLog> GetListBySMSlogID(ref int totalCount, ref int pageIndex, ref int pageSize, string SMSLogID, string senderUserID)
        {
            PageHelper<Sys_SMSDetailLog> pageQuery = new PageHelper<Sys_SMSDetailLog>();
            pageQuery.PageIndex = pageIndex;
            pageQuery.PageSize = pageSize;

            pageQuery.QueryKeyValues.Add(new KeyValue("SMSLogID", SMSLogID));
            pageQuery.QueryKeyValues.Add(new KeyValue("SenderUserID", senderUserID));
            pageQuery.QueryKeyValues.Add(new KeyValue("SchoolID", base.SchoolID));
            var resut = base.GetListPageByCustomSql(pageQuery);
            totalCount = resut.TotalCount;
            return resut.Data;

        }
    }
}
