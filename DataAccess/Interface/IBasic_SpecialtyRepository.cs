using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface IBasic_SpecialtyRepository : IRepository<Basic_Specialty>
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
        /// 根据学校ID获取专业列表
        /// </summary>
        /// <returns></returns>
        List<Basic_Specialty> GetListBySchoolID(ref int totalCount, ref int pageIndex, ref int pageSize);


        /// <summary>
        /// 批量逻辑删除
        /// </summary>
        /// <param name="ids">id数组</param>
        /// <returns></returns>
        int LogicDeleteBatchByIDs(string[] ids);
    }
}
