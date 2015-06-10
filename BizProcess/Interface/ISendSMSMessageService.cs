using BizProcess.Base.Interface;
using Entity;
using Entity.CustomEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BizProcess.Interface
{
    public interface ISendSMSMessageService
    {
        /// <summary>
        /// 发送短信
        /// </summary>
        /// <param name="message"></param>
        /// <param name="messageContent"></param>
        /// <param name="schoolID"></param>
        /// <param name="sendMessagetoken"></param>
        /// <returns></returns>
        RtnSMSMessage SendSMSMessage(SMSMessage message, string messageContent, string schoolID, string sendMessagetoken);
    }
}
