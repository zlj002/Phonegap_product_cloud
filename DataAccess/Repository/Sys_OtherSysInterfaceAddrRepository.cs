using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;

namespace DataAccess.Repository
{
    public class Sys_OtherSysInterfaceAddrRepository : RootRepositoryBase<Sys_OtherSysInterfaceAddr>, ISys_OtherSysInterfaceAddrRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Sys_OtherSysInterfaceAddrRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Sys_OtherSysInterfaceAddrRepository(string schoolID)
        {
            SchoolID = schoolID;
        }

    }
}
