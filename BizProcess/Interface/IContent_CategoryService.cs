using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;

namespace BizProcess.Interface
{
    public interface IContent_CategoryService : IBaseService<Content_Category>
    {

        /// <summary>
        ///  添加或更新
        /// </summary>
        /// <param name="entity">对象实例</param>
        /// <returns></returns>
        Content_Category InsertOrUpdate(Content_Category entity);

    }
}
