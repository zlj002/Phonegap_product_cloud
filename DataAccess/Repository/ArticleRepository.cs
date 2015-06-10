using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Interface;
using DataAccess.Base.Repository;
using DataAccess.Interface;
using Entity;

namespace DataAccess.Repository
{
    public class ArticleRepository : RepositoryBase<Article>, IArticleRepository
    { 
        public Article GetArticleByID(Int64 articleID)
        {
            List<object> list = new List<object>();
            string sql = " select top 13 * from dbo.Article where ArticleID= {" + list.Count + "}  order by UpdateTime desc ";
            list.Add(articleID);
            Article result = this.SqlQueryForListByCustomSql(sql, list.ToArray()).FirstOrDefault();
            return result;
        } 
        public Article GetTuijianToday()
        {
            string sql = " select top 1 * from dbo.Article where IsTop=1 order by UpdateTime desc ";
            Article article = this.SqlQueryForListByCustomSql(sql).FirstOrDefault();
            return article;
        } 
        public List<Article> GetLastUpdate(string typeID)
        {
            List<object> list = new List<object>();
            string sql = " select top 13 * from dbo.Article where TypeID= {" + list.Count + "}  order by UpdateTime desc ";
            list.Add(typeID);
            List<Article> result = this.SqlQueryForListByCustomSql(sql, list.ToArray());
            return result;
        }


    }
}
