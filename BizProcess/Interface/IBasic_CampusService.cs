using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;

namespace BizProcess.Interface
{
    public interface IBasic_CampusService : IBaseService<Basic_Campus>
    {
        /// <summary>
        /// 根据学校ID获取校区列表
        /// </summary>
        /// <param name="schoolID"></param>
        /// <returns></returns>
        //List<Basic_Campus> GetSchoolCampusBySchoolID();


        /// <summary>
        /// 更新或插入缓存数据连接字符串，有更新，没有则插入
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        Basic_Campus InertOrUpdateEntity(Basic_Campus entity);


        /// <summary>
        /// 批量逻辑删除
        /// </summary>
        /// <param name="ids">id数组</param>
        /// <returns></returns>
        int LogicDeleteBatchByIDs(string [] ids);
    }
}
