using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;

namespace BizProcess.Interface
{
    public interface IContent_ArticleService : IBaseService<Content_Article>
    {
        /// <summary>
        ///  添加或更新
        /// </summary>
        /// <param name="entity">对象实例</param>
        /// <returns></returns>
        Content_Article InsertOrUpdate(Content_Article entity);

        /// <summary>
        /// 只更新推荐类型
        /// </summary>
        /// <param name="id"></param>
        /// <param name="remmendType"></param>
        /// <returns></returns>
        Content_Article UpdateRecommendTypeStatus(string id,string remmendType);

        /// <summary>
        /// 根据学校id，key插入新闻提供给第三方使用
        /// </summary>
        /// <param name="news"></param>
        /// <param name="schoolID"></param>
        /// <param name="schoolKey"></param>
        /// <returns></returns>
        Content_Article AddArticleBySchoolIDAndSchoolKey(Content_Article article, string schoolID, string schoolKey);
    }
}
