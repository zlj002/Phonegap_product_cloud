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
    public class Basic_HobbyService : BaseService<Basic_Hobby>, IBasic_HobbyService
    {
        IBasic_HobbyRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_HobbyService()
        {
            subRepository = new Basic_HobbyRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_HobbyService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Basic_HobbyRepository(base.SchoolID);
            base.repository = subRepository;
        }

    }
}
