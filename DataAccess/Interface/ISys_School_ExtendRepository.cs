using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface ISys_School_ExtendRepository : IRepository<Sys_School_Extend>
    {

        /// <summary>
        /// 根据学校ID获取学校信息
        /// </summary>
        /// <param name="schoolID"></param>
        /// <returns></returns>
        Sys_School_Extend GetSchoolInfoBySchoolID();
    }
}
