using BizProcess.Interface;
using BizProcess.Service;
using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// PushService 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
[System.Web.Script.Services.ScriptService]
public class PushService : System.Web.Services.WebService
{

    public PushService()
    {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    [WebMethod]
    public int PushToAll(Sys_PushMessage message)
    {
        ISys_PushMessageService pushService = new Sys_PushMessageService();
        return pushService.PushToAll(message);

    }
    /// <summary>
    /// 推送到指定帐号
    /// </summary>
    /// <param name="userID">账户</param>
    /// <param name="title">标题</param>
    /// <param name="content"></param>
    /// <param name="featureID"></param>
    /// <param name="url"></param>
    /// <returns></returns>
    [WebMethod]
    public int PushToAccount(string userID, string title, string content, string featureID, string url)
    {
        /*信鸽推送*/
        Sys_PushMessage message = new Sys_PushMessage();
        ISys_PushMessageService pushService = new Sys_PushMessageService();
        //最多14个汉字
        message.Title = title.Length > 14 ? title.Substring(0, 14) : title;
        message.Content = content;
        message.UserID = userID;
        message.FeatureID = featureID;
        message.Url = url;
        return pushService.PushToAccount(message);

    }
}
