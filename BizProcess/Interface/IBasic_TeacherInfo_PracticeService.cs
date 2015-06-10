using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;

namespace BizProcess.Interface
{
    public interface IBasic_TeacherInfo_PracticeService : IBaseService<Basic_TeacherInfo_Practice>
    {
        /// <summary>
        ///  添加或更新
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        Basic_TeacherInfo_Practice InsertOrUpdate(Basic_TeacherInfo_Practice entity); 

    }
}
