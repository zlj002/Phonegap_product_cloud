using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface IBasic_StudentRepository : IRepository<Basic_Student>
    {
        /// <summary>
        /// 根据学生ID获取学生详细信息
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        Basic_Student GetStudentInfoByID(string ID);
    }
}
