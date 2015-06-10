using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface IMessage_RegisterMobileRepository : IRepository<Message_RegisterMobile>
    {
        /// <summary>
        /// 根据手机号删除该手机号收到的短信息
        /// </summary>
        /// <param name="mobileNumber"></param>
        void DeleteMessageCodeByMobileNumber(string mobileNumber);
    }
}
