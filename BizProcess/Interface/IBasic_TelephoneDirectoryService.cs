using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;

namespace BizProcess.Interface
{
    public interface IBasic_TelephoneDirectoryService : IBaseService<Basic_TelephoneDirectory>
    {
        /// <summary>
        /// 根据学校ID获取学校黄页列表
        /// </summary>
        /// <returns></returns>
        List<Basic_TelephoneDirectory> GetListBySchoolID();

        Basic_TelephoneDirectory InertOrUpdateEntity(Basic_TelephoneDirectory entity);
    }
}
