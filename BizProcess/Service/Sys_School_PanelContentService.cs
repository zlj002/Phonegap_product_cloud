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
    public class Sys_School_PanelContentService : BaseService<Sys_School_PanelContent>, ISys_School_PanelContentService
    {
        ISys_School_PanelContentRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Sys_School_PanelContentService()
        {
            subRepository = new Sys_School_PanelContentRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 默认构造
        /// </summary>
        public Sys_School_PanelContentService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Sys_School_PanelContentRepository(base.SchoolID);
            base.repository = subRepository;
        }

        
    }
}
