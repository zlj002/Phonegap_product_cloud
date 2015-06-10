using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;

namespace BizProcess.Interface
{
    public interface ISys_School_ExtendService : IBaseService<Sys_School_Extend>
    {
        /// <summary>
        /// 根据学校ID获取学校信息
        /// </summary>
        /// <param name="schoolID"></param>
        /// <returns></returns>
        Sys_School_Extend GetSchoolInfoBySchoolID();


        /// <summary>
        /// 更新或插入缓存数据连接字符串，有更新，没有则插入
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        Sys_School_Extend InertOrUpdateEntity(Sys_School_Extend entity);

    }
}
