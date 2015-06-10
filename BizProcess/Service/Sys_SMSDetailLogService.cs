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
    public class Sys_SMSDetailLogService : BaseService<Sys_SMSDetailLog>, ISys_SMSDetailLogService
    {
        ISys_SMSDetailLogRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Sys_SMSDetailLogService()
        {
            subRepository = new Sys_SMSDetailLogRepository();
            base.repository = subRepository;
        }

        /// <summary>
        /// 默认构造
        /// </summary>
        public Sys_SMSDetailLogService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Sys_SMSDetailLogRepository(base.SchoolID);
            base.repository = subRepository;
        }

        public List<Sys_SMSDetailLog> GetListBySMSlogID(ref int totalCount, ref int pageIndex, ref int pageSize, string SMSLogID, string senderUserID)
        {
            return subRepository.GetListBySMSlogID(ref totalCount, ref pageIndex, ref pageSize, SMSLogID, senderUserID);
        }
    }
}
