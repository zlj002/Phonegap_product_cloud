using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;

namespace DataAccess.Repository
{
    public class Sys_School_PanelContentRepository : RootRepositoryBase<Sys_School_PanelContent>, ISys_School_PanelContentRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Sys_School_PanelContentRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Sys_School_PanelContentRepository(string schoolID)
        {
            SchoolID = schoolID;
        }
        
    }
}
