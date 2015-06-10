using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;

namespace BizProcess.Interface
{
    public interface IBasic_NewsService : IBaseService<Basic_News>
    {
        /// <summary>
        /// 根据学校ID、新闻类别ID分页显示新闻列表
        /// </summary>
        /// <returns></returns>
        List<Basic_News> GetListBySchoolIDAndCategoryID(string categoryID, int totalCount, int pageIndex, int pageSize);


        /// <summary>
        /// 根据学校ID获取主界面置顶新闻列表
        /// </summary>
        /// <param name="displaycount"></param>
        /// <returns></returns>
        List<Basic_News> GetMainDisplayListBySchoolID(int displaycount);

        /// <summary>
        /// 根据学校ID获取分类置顶新闻列表
        /// </summary>
        /// <param name="displaycount"></param>
        /// <returns></returns>
        List<Basic_News> GetCategroupTopListBySchoolID(string categoryID, int displaycount);

       
        

    }
}
