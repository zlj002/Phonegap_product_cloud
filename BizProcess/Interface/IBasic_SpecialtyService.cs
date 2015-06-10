﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;

namespace BizProcess.Interface
{
    public interface IBasic_SpecialtyService : IBaseService<Basic_Specialty>
    {
        /// <summary>
        /// 根据学校ID专业列表
        /// </summary>
        /// <param name="schoolID"></param>
        /// <returns></returns>
        List<Basic_Specialty> GetSpecialtyListBySchoolID();

        /// <summary>
        /// 根据专业ID获取专业
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        Basic_Specialty GetSepecialtyByID(string ID);



        /// <summary>
        /// 批量逻辑删除
        /// </summary>
        /// <param name="ids">id数组</param>
        /// <returns></returns>
        int LogicDeleteBatchByIDs(string[] ids);


        /// <summary>
        /// 更新或插入缓存数据连接字符串，有更新，没有则插入
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        Basic_Specialty InertOrUpdateEntity(Basic_Specialty entity);

    }
}
