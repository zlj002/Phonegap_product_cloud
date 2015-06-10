<%@ WebHandler Language="C#" Class="Sys_UserHandler" %>

using System;
using System.Web;
using OurHelper;
using BizProcess.Interface;
using BizProcess.Service;
using System.Collections.Generic;
using Entity;
using System.Linq;
public class Sys_UserHandler : IHttpHandler
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
            GetUserList(context, requestHelper);
        }
        else
        {
            switch (action.ToString().ToUpper())
            {
                case "GETUSERLIST":
                    GetUserList(context, requestHelper);
                    break;
                case "GETCURRENTUSERINFO":
                    GetCurrentUserInfo(context, requestHelper);
                    break;
                case "UPDATEPWD":
                    UpdatePwd(context, requestHelper);
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
                context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(returns));
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
            context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(returns));
            context.Response.Flush();
            context.ApplicationInstance.CompleteRequest();
        }
    }

    private void GetCurrentUserInfo(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            Sys_User user = new PageBase().CurrentUser;
            data.FinishFlag = 1;
            var returns = new
            {
                data.FinishFlag,
                data.FinishMessage,
                Entity = new
                {
                    user.ID,
                    user.UserName,
                    user.TeacherPhotoUrl
                },
                MenuList = new PageBase().CurrentUser.MenuList.Select(ss => new {
                    ss.MenuID,//id
                    ss.MenuName,//名称
                    ss.ParentMenuID,//上级
                    ss.MenuIconClass,
                    ss.MenuUrl,
                    ss.Depth
                })
            };
            context.Response.Clear();
            context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(returns));
            context.Response.Flush();
            context.ApplicationInstance.CompleteRequest();
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
            context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(returns));
            context.Response.Flush();
            context.ApplicationInstance.CompleteRequest();
        }
    }
    private void GetUserList(HttpContext context, RequestHelper requestHelper)
    {
        ISys_UserService service = new Sys_UserService();

        PageHelper<Entity.Sys_User> page = new PageHelper<Sys_User>();
        page.PageIndex = requestHelper.PageIndex;
        page.PageSize = requestHelper.PageSize;
        page.QueryKeyValues.Add(new KeyValue("Status", "1"));
        page.QueryKeyValues.Add(new KeyValue("SchoolID", new PageBase().CurrentSchoolID));

        if (requestHelper.ContainsKey("UserName") && !string.IsNullOrEmpty(requestHelper["UserName"].ToString()))
        {
            page.QueryKeyValues.Add(new KeyValue("UserName", requestHelper["UserName"].ToString()));
        }
        if (requestHelper.ContainsKey("RoleID") && !string.IsNullOrEmpty(requestHelper["RoleID"].ToString()))
        {
            page.QueryKeyValues.Add(new KeyValue("RoleID", requestHelper["RoleID"].ToString()));
        }
        List<Sys_User> list = service.GetPageListAllUserRoleInfoByRoleID(page).Data;

        var returns = new
        {
            List = list.Select(o => new
            {
                o.ID,
                o.LoginID,

                o.UserName,
                o.UserType,
                o.UserIsBelongToRole
                ,
                o.EmployeeID
            }),
            iTotalRecords = page.TotalCount,
            iTotalDisplayRecords = page.TotalCount
        };
        context.Response.Clear();
        context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(returns));
        context.Response.Flush();
        context.ApplicationInstance.CompleteRequest();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}