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
    public class Basic_TelephoneDirectoryRepository : RootRepositoryBase<Basic_TelephoneDirectory>, IBasic_TelephoneDirectoryRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Basic_TelephoneDirectoryRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Basic_TelephoneDirectoryRepository(string schoolID)
        {
            SchoolID = schoolID;
        }
        /// <summary>
        /// 根据学校ID获取学校黄页列表
        /// </summary>
        /// <param name="schoolID"></param>
        /// <returns></returns>


        public List<Basic_TelephoneDirectory> GetListBySchoolID()
        {
            PageHelper<Basic_TelephoneDirectory> pageQuery = new PageHelper<Basic_TelephoneDirectory>();  
            pageQuery.PageSize = 10000;
            pageQuery.QueryKeyValues.Add(new KeyValue("SchoolID", base.SchoolID, KeyValueOperatorType.Equal));
            pageQuery.QueryKeyValues.Add(new KeyValue("Status", "1", KeyValueOperatorType.Equal));
            return base.GetListPageByCustomSql(pageQuery).Data; 
        }
    }
}
