using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using BizProcess.Interface;
using BizProcess.Base.Service;
using DataAccess.Repository;
using DataAccess.Interface;

namespace BizProcess.Service
{
    public class Sys_SchoolService : BaseService<Sys_School>, ISys_SchoolService
    {
        ISys_SchoolRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Sys_SchoolService()
        {
            subRepository = new Sys_SchoolRepository();
            base.repository = subRepository;
        }  
    }
}
