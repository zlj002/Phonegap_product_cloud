using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;

namespace BizProcess.Interface
{
    public interface ISys_PushMessageService : IBaseService<Sys_PushMessage>
    {
        /// <summary>
        /// 推送到系统帐号（这里指我们系统的可以对外开放的系统id）,将推送两个平台 android 和ios
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        int PushToAccount(Sys_PushMessage message);

        /// <summary>
        /// 推送到所有设备
        /// </summary>
        /// <param name="message"></param>
        /// <returns></returns>
        int PushToAll(Sys_PushMessage message);

        /// <summary>
        /// 获取badge 数 个人
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        List<Sys_PushMessage> GetBadgeCountByUserID(string userID);
        /// <summary>
        /// 删除指定的人和featureid的badge
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="featureID"></param>
        /// <returns></returns>
        int DeleteBadgeByUserIDAndFeatureID(string userID, string featureID);
    }
}
