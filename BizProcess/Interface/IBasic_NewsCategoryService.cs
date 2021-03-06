﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;

namespace BizProcess.Interface
{
    public interface IBasic_NewsCategoryService : IBaseService<Basic_NewsCategory>
    {
        /// <summary>
        /// 根据学校ID获取所有新闻分类
        /// </summary>
        /// <returns></returns>
        List<Basic_NewsCategory> GetListBySchoolID();
    }
}
