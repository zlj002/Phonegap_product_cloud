using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;

namespace DataAccess.Repository
{
    public class Content_ArticleRepository : RootRepositoryBase<Content_Article>, IContent_ArticleRepository
    {
        public Content_ArticleRepository()
        {
        }
        public Content_ArticleRepository(string schoolID)
        {
            SchoolID = schoolID;
        }
        public override OurHelper.PageHelper<Content_Article> GetListPage(OurHelper.PageHelper<Content_Article> pageQuery)
        {
            base.PageSqlTable = " select *  from [dbo].[Content_Article] ";
            foreach (var item in pageQuery.QueryKeyValues)
            { 

                if (item.Key == "SchoolID")
                {
                    base.PageSqlWhere = base.PageSqlWhere + " and SchoolID ={" + base.PageParameters.Count + "} ";
                    base.PageParameters.Add(item.Value);
                }
                if (item.Key == "Status")
                {
                    base.PageSqlWhere = base.PageSqlWhere + " and Status ={" + base.PageParameters.Count + "} ";
                    base.PageParameters.Add(item.Value);
                }
                if (item.Key == "Title")
                {
                    base.PageSqlWhere = base.PageSqlWhere + " and Title  like {" + base.PageParameters.Count + "} ";
                    base.PageParameters.Add("%" + item.Value + "%");
                }
                if (item.Key == "CategoryID")
                {
                    base.PageSqlWhere = base.PageSqlWhere + " and CategoryID in  (select * from dbo.getCategorySubIDs ({" + base.PageParameters.Count + "}) ) ";
                    base.PageParameters.Add(item.Value);
                }
                if (item.Key == "RecommendType")
                {
                    base.PageSqlWhere = base.PageSqlWhere + " and RecommendType  like {" + base.PageParameters.Count + "} ";
                    base.PageParameters.Add("%" + item.Value + "%");
                }
                if (item.Key == "IsMainDisplay")
                {
                    base.PageSqlWhere = base.PageSqlWhere + " and IsMainDisplay  = {" + base.PageParameters.Count + "} ";
                    base.PageParameters.Add(item.Value);
                }



            }
            return base.GetListPageByCustomSql(pageQuery);
        }
    }
}
