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
    public class Basic_NewsCategoryRepository : RootRepositoryBase<Basic_NewsCategory>, IBasic_NewsCategoryRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Basic_NewsCategoryRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Basic_NewsCategoryRepository(string schoolID)
        {
            SchoolID = schoolID;
        }


        /// <summary>
        /// 根据学校ID获取新闻分类列表
        /// </summary>
        /// <returns></returns>
        public List<Basic_NewsCategory> GetListBySchoolID()
        {
            PageHelper<Basic_NewsCategory> pageQuery = new PageHelper<Basic_NewsCategory>(); 
 
            pageQuery.PageSize = 1000;
            pageQuery.QueryKeyValues.Add(new KeyValue("SchoolID", base.SchoolID, KeyValueOperatorType.Equal));
            return base.GetListPageByCustomSql(pageQuery).Data;


             
        }
    }
}
