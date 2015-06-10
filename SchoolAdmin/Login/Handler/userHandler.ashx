<%@ WebHandler Language="C#" Class="userHandler" %>

using System;
using System.Web;
using OurHelper;
using Entity;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
public class userHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        //获取查询参数
        var requestHelper = new RequestHelper();
        requestHelper.GenerateSearchTerm(HttpContext.Current.Request.QueryString);
        requestHelper.GenerateSearchTerm(HttpContext.Current.Request.Form);
        object action = requestHelper["action"];
        if (action == null)
        {
            Login(context, requestHelper);
        }
        else
        {
            switch (action.ToString().ToUpper())
            {
                case "LOGIN":
                    Login(context, requestHelper);
                    break;


            }


        }
    }


    public void Login(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {

            if (requestHelper.ContainsKey("LoginID") && !string.IsNullOrEmpty(requestHelper["LoginID"].ToString())
                && requestHelper.ContainsKey("PassWord") && !string.IsNullOrEmpty(requestHelper["PassWord"].ToString())
                )
            {
                BizProcess.Interface.ISys_UserService service = new BizProcess.Service.Sys_UserService();
                var LoginID = requestHelper["LoginID"].ToString();
                var PassWord = requestHelper["PassWord"].ToString();
                Sys_User entity = service.GetEntityByColNameAndColValue("LoginID", LoginID);
                if (entity != null)
                {
                    //密码验证
                    if (entity.PassWord == OurHelper.EncryptHelper.OurEncrypt(PassWord))
                    {
                        //状态正常
                        if (entity.Status.HasValue && (entity.Status.Value == (int)Entity.CustomEntity.ConstantEntity.DataStatus.Valid))
                        {
                            //所属角色有一个未被锁定即可登录
                           var unLockRole =  entity.Sys_Role.Where(o => o.IsLockUser != "1").FirstOrDefault();
                           if (unLockRole != null)
                           {
                               data.FinishFlag = 1;
                               data.FinishMessage = string.Empty; System.Web.Security.FormsAuthentication.SetAuthCookie(entity.ID, false);
                           }
                           else
                           {
                               data.FinishFlag = 0;
                               data.FinishMessage = "用户已被禁止登录";
                           } 
                        }
                        else
                        {
                            data.FinishFlag = 0;
                            data.FinishMessage = "用户已被禁止登录";
                        }
                    }
                    else
                    {
                        data.FinishFlag = 0;
                        data.FinishMessage = "用户名或密码错误";
                    }
                }
                else
                {
                    data.FinishFlag = 0;
                    data.FinishMessage = "用户名或密码错误";
                }

                var returns = new
                {
                    data.FinishFlag,
                    data.FinishMessage
                };

                context.Response.Clear();
                context.Response.Write(JsonConvert.SerializeObject(returns));
                context.Response.Flush();
                context.ApplicationInstance.CompleteRequest();

            }
            else
            {
                data.FinishFlag = 0;
                data.FinishMessage = "请输入用户名和密码";
                var returns = new
                {
                    data.FinishFlag,
                    data.FinishMessage
                };
                context.Response.Clear();
                context.Response.Write(JsonConvert.SerializeObject(returns));
                context.Response.Flush();
                context.ApplicationInstance.CompleteRequest();
            }

        }
        catch (Exception e)
        {
            data.FinishFlag = 0;
            data.FinishMessage = e.Message;
            var returns = new
            {
                data.FinishFlag,
                data.FinishMessage
            };
            context.Response.Clear();
            context.Response.Write(JsonConvert.SerializeObject(returns));
            context.Response.Flush();
            context.ApplicationInstance.CompleteRequest();
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


}
 