<%@ WebHandler Language="C#" Class="sysuserHandler" %>

using System;
using System.Web;
using OurHelper;
using Entity;
using Newtonsoft.Json;
using System.Linq;
public class sysuserHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        //获取查询参数
        var requestHelper = new OurHelper.RequestHelper();
        requestHelper.GenerateSearchTerm(HttpContext.Current.Request.QueryString);
        requestHelper.GenerateSearchTerm(HttpContext.Current.Request.Form);
        object action = requestHelper["action"];
        if (action == null)
        {
            UpdatePwd(context, requestHelper);
        }
        else
        {
            switch (action.ToString().ToUpper())
            {
                case "UPDATEPWD":
                    UpdatePwd(context, requestHelper);
                    break;
                case "GETCURRENTUSEROPERATIONLISTBYMENUID":
                    GetCurrentUserOperationListByMenuID(context, requestHelper);
                    break;
            }


        }
    }
    public void UpdatePwd(HttpContext context, OurHelper.RequestHelper requestHelper)
    {
        OurHelper.InteractiveData data = new InteractiveData();
        try
        {

            if (requestHelper.ContainsKey("oldPassword") && !string.IsNullOrEmpty(requestHelper["oldPassword"].ToString())
                && requestHelper.ContainsKey("newPassword") && !string.IsNullOrEmpty(requestHelper["newPassword"].ToString())
                )
            {
                BizProcess.Interface.ISys_UserService service = new BizProcess.Service.Sys_UserService();
                var oldPassword = requestHelper["oldPassword"].ToString();
                var newPassword = requestHelper["newPassword"].ToString();
                var currentUser = new PageBase().CurrentUser;
                var userID = currentUser.ID;
                if (service.UpdatePwd(userID, oldPassword, newPassword))
                {
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;
                }
                var returns = new
                {
                    data.FinishFlag,
                    data.FinishMessage
                };

                context.Response.Clear();
                context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(returns));
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

    public void GetCurrentUserOperationListByMenuID(HttpContext context, OurHelper.RequestHelper requestHelper)
    {
        OurHelper.InteractiveData data = new InteractiveData();
        try
        {
            object menuID = requestHelper["MenuID"];

            if (menuID != null && !string.IsNullOrEmpty(menuID.ToString()))
            {
                System.Collections.Generic.List<Sys_RoleMenuOperation> list = new PageBase().CurrentUser.MenuOperationList.Where(ss => ss.MenuID == requestHelper["MenuID"].ToString()).ToList();
                data.FinishFlag = 1;
                data.FinishMessage = "";
                var returns = new
                {
                    data.FinishFlag,
                    data.FinishMessage,
                    List = list.Select(ss => new
                    {
                        ss.MenuID,
                        ss.OperationID,
                        ss.RoleID
                    })
                };
                context.Response.Clear();
                context.Response.Write(JsonConvert.SerializeObject(returns));
                context.Response.Flush();
                context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                data.FinishFlag = 0;
                data.FinishMessage = "缺少参数";
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