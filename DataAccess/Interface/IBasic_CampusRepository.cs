using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface IBasic_CampusRepository : IRepository<Basic_Campus>
    {

        /// <summary>
        /// 根据学校ID获取校区列表
        /// </summary>
        /// <param name="schoolID"></param>
        /// <returns></returns>
        //List<Basic_Campus> GetSchoolCampusBySchoolID();

        /// <summary>
        /// 批量逻辑删除
        /// </summary>
        /// <param name="ids">id数组</param>
        /// <returns></returns>
        int LogicDeleteBatchByIDs(string[] ids);
    }
}
