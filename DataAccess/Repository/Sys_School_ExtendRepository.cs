using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;

namespace DataAccess.Repository
{
    public class Sys_School_ExtendRepository : RootRepositoryBase<Sys_School_Extend>, ISys_School_ExtendRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Sys_School_ExtendRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Sys_School_ExtendRepository(string schoolID)
        {
            SchoolID = schoolID;
        }
        /// <summary>
        /// 根据学校ID获取学校信息
        /// </summary>
        /// <param name="schoolID"></param>
        /// <returns></returns>

        public Sys_School_Extend GetSchoolInfoBySchoolID()
        {
            return GetEntityByColNameAndColValue("SchoolID", base.SchoolID);
            
        }
    }
}
