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
    public class VenuSoft_Message_NotFullRemindService : BaseService<VenuSoft_Message_NotFullRemind>, IVenuSoft_Message_NotFullRemindService
    {
        IVenuSoft_Message_NotFullRemindRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public VenuSoft_Message_NotFullRemindService()
        {
            subRepository = new VenuSoft_Message_NotFullRemindRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 默认构造
        /// </summary>
        public VenuSoft_Message_NotFullRemindService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new VenuSoft_Message_NotFullRemindRepository(base.SchoolID);
            base.repository = subRepository;
        }

         
    }
}
