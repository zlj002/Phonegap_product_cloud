using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface IBasic_NewsCategoryRepository : IRepository<Basic_NewsCategory>
    {
        /// <summary>
        /// 根据学校ID获取所有新闻分类
        /// </summary>
        /// <returns></returns>
        List<Basic_NewsCategory> GetListBySchoolID();
    }
}
