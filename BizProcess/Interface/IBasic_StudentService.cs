using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;

namespace BizProcess.Interface
{
    public interface IBasic_StudentService : IBaseService<Basic_Student>
    {
        /// <summary>
        /// 根据学生ID获取学生详细信息
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        Basic_Student GetStudentInfoByID(string ID);
    }
}
