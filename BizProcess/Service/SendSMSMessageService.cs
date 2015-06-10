using BizProcess.Base.Service;
using BizProcess.Common;
using BizProcess.Interface;
using DataAccess.Repository;
using Entity;
using Entity.CustomEntity;
using Newtonsoft.Json;
using OurHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BizProcess.Service
{

    public class SendSMSMessageService : ISendSMSMessageService
    {
        int successCount = 0;
        /// <summary>
        /// 发送短信通用方法
        /// </summary>
        /// <param name="message"></param>
        /// <param name="messageContent"></param>
        /// <param name="schoolID"></param>
        /// <param name="sendMessagetoken"></param>
        /// <returns></returns>
        public RtnSMSMessage SendSMSMessage(SMSMessage message, string messageContent, string schoolID, string sendMessagetoken)
        {
            RtnSMSMessage rtnMessage = new RtnSMSMessage();
            Message_SchoolKeys keys = new Message_SchoolKeysService().GetSchoolKeysBySchoolIDAndKey(schoolID, sendMessagetoken);
            if (keys == null)
            {
                rtnMessage.ReturnFlag = 0;
                rtnMessage.ReturnMessage = "未能获得有效发送短信凭证";

                return rtnMessage;
            }
            string result = "";
            string failMessage = string.Empty;
            DESECBPKCS5Encrypt pt = new DESECBPKCS5Encrypt();
            if (message != null && message.List.Count > 0)
            {
                List<string> mobiles = new List<string>();
                Sys_SMSDetailLogService smsDetailService = new Sys_SMSDetailLogService();
                Sys_SMSDetailLog smsDetalEntity = null;
                for (int i = 0; i < message.List.Count; i++)
                {
                    mobiles.Clear();
                    mobiles.Add(pt.Encrypt(message.List[i].MobilePhone, "C9eLew12"));

                    result = new SMSService().SendSMSMessage(pt.Encrypt("12401", "C9eLew12"), pt.Encrypt("scnDDZ", "C9eLew12"), mobiles.ToArray(), pt.Encrypt(messageContent, "C9eLew12"), "", "");

                    if (!string.IsNullOrEmpty(result))
                    {

                        string[] strResult = result.Split(',');
                        if (strResult.Length > 0)
                        {

                            string rtn = respstatus(strResult[1]);

                            if (!string.IsNullOrEmpty(rtn))
                            {
                                if (string.IsNullOrEmpty(failMessage))
                                {
                                    failMessage = "以下成员未能发送成功：[" + message.List[i].UserName + "," + message.List[i].MobilePhone + "]";
                                }
                                else
                                {
                                    failMessage += "、[" + message.List[i].UserName + "," + message.List[i].MobilePhone + "]";
                                }
                                //写入发送日志
                                smsDetalEntity = new Sys_SMSDetailLog()
                                {
                                    SenderUserID = message.SendUserID,
                                    ReceiveUserName = message.List[i].UserName,
                                    ReceiveUserMobile = message.List[i].MobilePhone,
                                    ReturnMessage = rtn,
                                    SchoolID = schoolID,
                                    SMSLogID = string.IsNullOrEmpty(message.SMSLogID) ? 0 : int.Parse(message.SMSLogID),
                                    SendTime = DateTime.Now,
                                    Status = false,
                                    MessageContent = messageContent
                                };
                                smsDetailService.Insert(smsDetalEntity);
                            }
                            else
                            {
                                //写入发送日志
                                smsDetalEntity = new Sys_SMSDetailLog()
                                {
                                    SenderUserID = message.SendUserID,
                                    ReceiveUserName = message.List[i].UserName,
                                    ReceiveUserMobile = message.List[i].MobilePhone,
                                    ReturnMessage = "发送成功",
                                    SchoolID = schoolID,
                                    SMSLogID = string.IsNullOrEmpty(message.SMSLogID) ? 0 : int.Parse(message.SMSLogID),
                                    SendTime = DateTime.Now,
                                    Status = true,
                                    MessageContent = messageContent
                                };
                                smsDetailService.Insert(smsDetalEntity);
                            }
                        }
                    }

                }
            }

            if (successCount > 0)
            {
                if (string.IsNullOrEmpty(failMessage))
                {
                    rtnMessage.ReturnFlag = 1;
                    rtnMessage.ReturnMessage = "信息已全部发送成功";
                    return rtnMessage;
                }
                else
                {
                    rtnMessage.ReturnFlag = 1;
                    rtnMessage.ReturnMessage = "信息已发送，但有部分未能发送成功。" + failMessage + "。如需查看详情，请查看消息发送记录。";
                    return rtnMessage;
                }
            }

            rtnMessage.ReturnFlag = 0;
            rtnMessage.ReturnMessage = "发送失败，具体请查看消息发送记录";

            return rtnMessage;
        }

        /// <summary>
        /// 查询短信剩余量
        /// </summary>
        /// <returns></returns>
        public RtnSMSMessage GetRemainderSmsCount()
        {
            DESECBPKCS5Encrypt pt = new DESECBPKCS5Encrypt();

            string result = new SMSService().GetRemainderSmsCount(pt.Encrypt("12401", "C9eLew12"), pt.Encrypt("scnDDZ", "C9eLew12"));
            RtnSMSMessage rtn = GetRemainderSmsStatus(result);
            return rtn;
        }

        /// <summary>
        /// 短信余量不足时提醒
        /// </summary>
        public void RedminRemainderSmsCountNotFull()
        {
            RtnSMSMessage rtn = GetRemainderSmsCount();
            string messagecontent = rtn.ReturnMessage;

            IVenuSoft_Message_NotFullRemindService remindUsersService = new VenuSoft_Message_NotFullRemindService();
            PageHelper<VenuSoft_Message_NotFullRemind> help = new PageHelper<VenuSoft_Message_NotFullRemind>();
            help.PageIndex = 1;
            help.PageSize = 10000;
            //查询短信不足提醒人列表
            List<VenuSoft_Message_NotFullRemind> list = remindUsersService.GetListPage(help).Data;
            if (list != null && list.Count > 0)
            {
                SMSMessage smsmessage = new SMSMessage();
                foreach (VenuSoft_Message_NotFullRemind item in list)
                {
                    smsmessage.List.Add(new Sys_ContactUsers { UserName = item.UserName, MobilePhone = item.MobilePhone });
                }
                ISys_ConfigService configService = new Sys_ConfigService();
                Sys_Config configEntity = configService.GetEntityByColNameAndColValue("ID", "SMSWaringCount");
                if (configEntity != null)
                {
                    int configCount = int.Parse(configEntity.Value);
                    if (rtn.SmsRemainderCount <= configCount)
                    {
                        messagecontent += "当前设置为小于等于"+configCount+"时提醒！";
                        RtnSMSMessage rtnMessage = SendSMSMessage(smsmessage, messagecontent, "venusoft", "51F9CF83778E6712E0A4561D504FC264");
                    }

                }

            }

        }
        /// <summary>
        /// 处理电信返回值
        /// </summary>
        /// <param name="status"></param>
        /// <returns></returns>
        private string respstatus(string status)
        {
            string result = "";
            switch (status)
            {
                case "0":
                    successCount += 1;
                    result = "";
                    break;
                case "101":
                    result = "101-无此用户";
                    break;
                case "102":
                    result = "102-账号或密码错";
                    break;
                case "103":
                    result = "103-余额不足";
                    break;
                case "104":
                    result = "104-系统忙";
                    break;
                case "105":
                    result = "105-敏感短信";
                    break;
                case "106":
                    result = "106-消息长度错（>500或<=0）";
                    break;
                case "107":
                    result = "107-包含错误的手机号码";
                    break;
                case "108":
                    result = "108-一次发送的手机号不要超过1000";
                    break;
                case "109":
                    result = "109-短信内容没有签名";
                    break;
                case "110":
                    result = "110-该账号没有对应的模板号";
                    break;
                case "111":
                    result = "111-该模板参数不符合规定";
                    break;
                default:
                    result = "未知异常";
                    break;
            }
            return result;
        }


        /// <summary>
        /// 处理查询短信余量返回值
        /// </summary>
        /// <param name="status"></param>
        /// <returns></returns>
        private RtnSMSMessage GetRemainderSmsStatus(string status)
        {
            RtnSMSMessage rtn = new RtnSMSMessage();
            if (string.IsNullOrEmpty(status))
            {
                rtn.ReturnFlag = 0;
                rtn.ReturnMessage = "查询发生异常";
            }
            else
            {
                int len = status.IndexOf(';');
                if (len > 0)
                {
                    string[] strSplit = status.Split(';');
                    rtn.ReturnFlag = 1;
                    rtn.ReturnMessage = "短信还剩余：" + strSplit[1] + "条。";
                    rtn.SmsRemainderCount = int.Parse(strSplit[1]);
                }
                else
                {
                    switch (status)
                    {
                        case "101":
                            rtn.ReturnFlag = 0;
                            rtn.ReturnMessage = "101-无此用户";
                            break;
                        case "102":
                            rtn.ReturnFlag = 0;
                            rtn.ReturnMessage = "102-密码错";
                            break;
                        case "104":
                            rtn.ReturnFlag = 0;
                            rtn.ReturnMessage = "104-系统忙（因平台侧原因，暂时无法处理请求）";
                            break;
                        default:
                            rtn.ReturnFlag = 0;
                            rtn.ReturnMessage = "调用返回状态异常";
                            break;
                    }
                }
            }
            return rtn;
        }
    }
}
