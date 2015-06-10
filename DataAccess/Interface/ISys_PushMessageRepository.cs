using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface ISys_PushMessageRepository : IRepository<Sys_PushMessage>
    {
        /// <summary>
        /// 获取badge 数 个人
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        List<Sys_PushMessage> GetBadgeCountByUserID(string userID);
         
    }
}
