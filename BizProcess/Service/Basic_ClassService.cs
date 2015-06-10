using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using BizProcess.Interface;
using BizProcess.Base.Service;
using DataAccess.Repository;
using DataAccess.Interface;
using OurHelper;
using BizProcess.Common.Validate;

namespace BizProcess.Service
{
    public class Basic_ClassService : BaseService<Basic_Class>, IBasic_ClassService
    {
        IBasic_ClassRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_ClassService()
        {
            subRepository = new Basic_ClassRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_ClassService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Basic_ClassRepository(base.SchoolID);
            base.repository = subRepository;
        }

    }
}
