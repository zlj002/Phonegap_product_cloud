using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;

namespace DataAccess.Repository
{
    public class Sys_ThemeRepository : RootRepositoryBase<Sys_Theme>, ISys_ThemeRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Sys_ThemeRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Sys_ThemeRepository(string schoolID)
        {
            SchoolID = schoolID;
        }
       
         
    }
}
