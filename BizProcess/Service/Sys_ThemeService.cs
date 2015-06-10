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
    public class Sys_ThemeService : BaseService<Sys_Theme>, ISys_ThemeService
    {
        ISys_ThemeRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Sys_ThemeService()
        {
            subRepository = new Sys_ThemeRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 默认构造
        /// </summary>
        public Sys_ThemeService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Sys_ThemeRepository(base.SchoolID);
            base.repository = subRepository;
        }

         
    }
}
