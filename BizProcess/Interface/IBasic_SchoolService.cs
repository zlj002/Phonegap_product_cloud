using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;

namespace BizProcess.Interface
{
    public interface IBasic_SchoolService : IBaseService<Basic_School>
    {
        /// <summary>
        /// 根据名称获取前
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        List<Basic_School> GetTopSchoolByName(string name, int topNumber);
    }
}
