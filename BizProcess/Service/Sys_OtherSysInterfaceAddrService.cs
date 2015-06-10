using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using BizProcess.Interface;
using BizProcess.Base.Service;
using DataAccess.Repository;
using DataAccess.Interface;
using BizProcess.Common.Validate;

namespace BizProcess.Service
{
    public class Sys_OtherSysInterfaceAddrService : BaseService<Sys_OtherSysInterfaceAddr>, ISys_OtherSysInterfaceAddrService
    {
        ISys_OtherSysInterfaceAddrRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Sys_OtherSysInterfaceAddrService()
        {
            subRepository = new Sys_OtherSysInterfaceAddrRepository();
            base.repository = subRepository;
        }

    }
}
