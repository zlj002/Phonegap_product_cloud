using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using BizProcess.Service;
using Entity.CustomEntity;
using OurHelper;
using Newtonsoft.Json;
using BizProcess.Interface;
using Entity;
/// <summary>
/// SMSService 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
[System.Web.Script.Services.ScriptService]
public class SMSService : System.Web.Services.WebService
{

    /// <summary>
    /// 发送消息
    /// </summary>
    /// <param name="senUserjsonStr">形如：{"List":[{"UserName":"张三","MobilePhone":"2333333"},{"UserName":"李四","MobilePhone":"2333333"}]}</param>
    /// <param name="messageContent">形如：</param>
    /// <param name="schoolID">形如：</param>
    /// <returns></returns>
    [WebMethod]
    public string SendMessageByJsonStr(string senUserjsonStr, string messageContent, string schoolID, string sendMessagetoken)
    {
        try
        {

            SMSMessage message = JsonConvert.DeserializeObject<SMSMessage>(senUserjsonStr);
            RtnSMSMessage rtn = new SendSMSMessageService().SendSMSMessage(message, messageContent, schoolID, sendMessagetoken);
            var result = new
            {
                rtn.ReturnFlag,
                rtn.ReturnMessage
            };
            return JsonConvert.SerializeObject(result);
        }
        catch (Exception)
        {
            var result = new
            {
                ReturnFlag = 0,
                ReturnMessage = "发送短信出现未知错误，请联系管理员！"
            };
            return JsonConvert.SerializeObject(result);
        }


    }

    /// <summary>
    /// 查看发送短信详细记录
    /// </summary>
    /// <returns></returns>
    [WebMethod]
    public string GetSMSLogDetail(int pageIndex, int pageSize, string logID, string schoolID, string senderUserID)
    {
        try
        {
            ISys_SMSDetailLogService service = new Sys_SMSDetailLogService(schoolID);
            int totalCount = 0;
            List<Sys_SMSDetailLog> list = service.GetListBySMSlogID(ref totalCount, ref pageIndex, ref pageSize, logID, senderUserID);
            if (list != null)
            {
                var result = new
               {
                   ReturnFlag = 1,
                   ReturnMessage = "",
                   TotalCount = totalCount,
                   PageCount = Math.Ceiling((double)totalCount / pageSize),
                   List = list.Select(ss => new
                   {
                       ss.ReceiveUserName,
                       ss.ReceiveUserMobile,
                       ss.SendContent,
                       ss.SendRange,
                       ss.SendUserName,
                       Status = ss.Status,
                       ss.ReturnMessage,
                       SendTime = ss.SendTime.HasValue ? ss.SendTime.Value.ToString("yyyy-MM-dd HH:mm:ss") : "",
                       ss.MessageContent
                   })
               };
                return JsonConvert.SerializeObject(result);
            }
            else
            {
                var result = new
                {
                    ReturnFlag = 0,
                    ReturnMessage = "调用目标发生异常",
                    TotalCount = 0,
                    PageCount = 0
                };
                return JsonConvert.SerializeObject(result);
            }
        }
        catch (Exception)
        {
            var result = new
            {
                ReturnFlag = 0,
                ReturnMessage = "发生未知错误",
                TotalCount = 0,
                PageCount = 0
            };
            return JsonConvert.SerializeObject(result);
        }


    }

    /// <summary>
    /// 查询短信剩余量
    /// </summary>
    /// <returns></returns>
    [WebMethod]
    public string GetRemainderSmsCount()
    {
        try
        {
            RtnSMSMessage rtn = new SendSMSMessageService().GetRemainderSmsCount();
            var result = new
            {
                rtn.ReturnFlag,
                rtn.ReturnMessage
            };
            return JsonConvert.SerializeObject(result);
        }
        catch (Exception)
        {
            var result = new
            {
                ReturnFlag=0,
                ReturnMessage="调用目标发生异常"
            };
            return JsonConvert.SerializeObject(result);
        }
    
    }

}
