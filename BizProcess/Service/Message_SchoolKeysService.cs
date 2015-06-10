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
    public class Message_SchoolKeysService : BaseService<Message_SchoolKeys>, IMessage_SchoolKeysService
    {
        IMessage_SchoolKeysRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Message_SchoolKeysService()
        {
            subRepository = new Message_SchoolKeysRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 默认构造
        /// </summary>
        public Message_SchoolKeysService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Message_SchoolKeysRepository(base.SchoolID);
            base.repository = subRepository;
        }

        public Message_SchoolKeys GetSchoolKeysBySchoolIDAndKey(string schoolID, string key)
        {
            return subRepository.GetSchoolKeysBySchoolIDAndKey(schoolID, key);
        }
    }
}
