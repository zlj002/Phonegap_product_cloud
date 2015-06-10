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
    public class Sys_ConfigService : BaseService<Sys_Config>, ISys_ConfigService
    {
        ISys_ConfigRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Sys_ConfigService()
        {
            subRepository = new Sys_ConfigRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 默认构造
        /// </summary>
        public Sys_ConfigService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Sys_ConfigRepository(base.SchoolID);
            base.repository = subRepository;
        }

         
    }
}
