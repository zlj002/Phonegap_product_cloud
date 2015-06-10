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
    public class Basic_NewsRepository : RootRepositoryBase<Basic_News>, IBasic_NewsRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Basic_NewsRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Basic_NewsRepository(string schoolID)
        {
            SchoolID = schoolID;
        }


        /// <summary>
        /// 根据学校ID、新闻类别ID分页显示新闻列表
        /// </summary>
        /// <returns></returns>
        public List<Basic_News> GetListBySchoolIDAndCategoryID(string categoryID, int totalCount, int pageIndex, int pageSize)
        {
            PageHelper<Basic_News> pageQuery = new PageHelper<Basic_News>();
            pageQuery.PageIndex = pageIndex;
            pageQuery.PageSize = pageSize;
            pageQuery.QueryKeyValues.Add(new KeyValue("CategoryID", categoryID, KeyValueOperatorType.Equal)); pageQuery.QueryKeyValues.Add(new KeyValue("SchoolID", base.SchoolID, KeyValueOperatorType.Equal));
            pageQuery.QueryKeyValues.Add(new KeyValue("Status", "1", KeyValueOperatorType.Equal));
            var result = base.GetListPageByCustomSql(pageQuery);
            totalCount = result.TotalCount;
            return result.Data;

        }


        /// <summary>
        /// 根据学校ID获取主界面显示新闻列表
        /// </summary>
        /// <param name="displaycount"></param>
        /// <returns></returns>
        public List<Basic_News> GetMainDisplayListBySchoolID(int displaycount)
        {

            PageHelper<Basic_News> pageQuery = new PageHelper<Basic_News>();
            base.PageSqlTable = "SELECT TOP " + displaycount + " * FROM dbo.Basic_News ";
            pageQuery.OrderBy = " DisplayIndex asc,UpdateTime DESC ";
            pageQuery.PageSize = 1000;
            pageQuery.QueryKeyValues.Add(new KeyValue("SchoolID", base.SchoolID, KeyValueOperatorType.Equal));
            pageQuery.QueryKeyValues.Add(new KeyValue("IsMainDisplay", "1", KeyValueOperatorType.Equal));
            pageQuery.QueryKeyValues.Add(new KeyValue("Status", "1", KeyValueOperatorType.Equal));
            return base.GetListPageByCustomSql(pageQuery).Data;
             
        }

        /// <summary>
        /// 根据学校ID获取分类置顶新闻列表
        /// </summary>
        /// <param name="displaycount"></param>
        /// <returns></returns>
        public List<Basic_News> GetCategroupTopListBySchoolID(string categoryID, int displaycount)
        {

            PageHelper<Basic_News> pageQuery = new PageHelper<Basic_News>();
            base.PageSqlTable = " SELECT TOP " + displaycount + " * FROM dbo.Basic_News ";
            pageQuery.OrderBy = " DisplayIndex asc,UpdateTime DESC ";
            pageQuery.PageSize = 1000;
            pageQuery.QueryKeyValues.Add(new KeyValue("SchoolID", base.SchoolID, KeyValueOperatorType.Equal));
            pageQuery.QueryKeyValues.Add(new KeyValue("CategoryID", categoryID, KeyValueOperatorType.Equal));
            pageQuery.QueryKeyValues.Add(new KeyValue("Status", "1", KeyValueOperatorType.Equal));
            return base.GetListPageByCustomSql(pageQuery).Data;
             
        }
    }
}
