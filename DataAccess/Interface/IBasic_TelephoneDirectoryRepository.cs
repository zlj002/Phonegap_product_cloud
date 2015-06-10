using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface IBasic_TelephoneDirectoryRepository : IRepository<Basic_TelephoneDirectory>
    {
        /// <summary>
        /// 根据学校ID获取学校黄页列表
        /// </summary>
        /// <returns></returns>
        List<Basic_TelephoneDirectory> GetListBySchoolID();
    }
}
