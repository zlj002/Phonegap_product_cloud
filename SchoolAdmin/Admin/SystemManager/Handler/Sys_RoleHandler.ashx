<%@ WebHandler Language="C#" Class="Sys_RoleHandler" %>

using System;
using System.Web;
using OurHelper;
using BizProcess.Interface;
using BizProcess.Service;
using System.Collections.Generic;
using Entity;
using System.Linq;
using Newtonsoft.Json;
public class Sys_RoleHandler : IHttpHandler
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
            GetRoleList(context, requestHelper);
        }
        else
        {
            switch (action.ToString().ToUpper())
            {
                case "GETROLELIST":
                    GetRoleList(context, requestHelper);
                    break;
                case "INSERTORUPDATE":
                    InsertOrUpdate(context, requestHelper);
                    break;
                case "GETENTITY":
                    GetEntity(context, requestHelper);
                    break;
                case "DELETE":
                    Delete(context, requestHelper);
                    break;
                case "SETUSERSFORROLEID":
                    SetUsersForRoleID(context, requestHelper);
                    break;
                case "SETMENUSFORROLEID":
                    SetMenusForRoleID(context, requestHelper);
                    break;
                case "CHANGELOCKSTATUS":
                    ChangeLockStatus(context, requestHelper);
                    break;
                case "SETMENUOPERATIONSFORROLEID":
                    SetMenuOperationsForRoleID(context, requestHelper);
                    break;
                    

            }

        }
    }
    public void SetMenuOperationsForRoleID(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            if (requestHelper.ContainsKey("roleID") && !string.IsNullOrEmpty(requestHelper["roleID"].ToString()) && requestHelper.ContainsKey("menuOperationIDs") && !string.IsNullOrEmpty(requestHelper["menuOperationIDs"].ToString()) && requestHelper.ContainsKey("isAdd") && !string.IsNullOrEmpty(requestHelper["isAdd"].ToString()))
            {
                string roleID = requestHelper["roleID"].ToString();
                string[] menuIDs = JsonConvert.DeserializeObject<string[]>(requestHelper["menuOperationIDs"].ToString());
                bool isAdd;
                bool.TryParse(requestHelper["isAdd"].ToString(), out isAdd);
                ISys_RoleService service = new Sys_RoleService();
                service.SetMenuOperationsForRoleID(roleID, menuIDs, isAdd);
                data.FinishFlag = 1;
                data.FinishMessage = string.Empty;
                //更新所有用户缓存
                new PageBase().UpdateAllUserCache();
            }
            else
            {
                data.FinishFlag = 0;
                data.FinishMessage = "操作失败";
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
    public void ChangeLockStatus(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            if (requestHelper.ContainsKey("roleID") && !string.IsNullOrEmpty(requestHelper["roleID"].ToString()) && requestHelper.ContainsKey("isLock") && !string.IsNullOrEmpty(requestHelper["isLock"].ToString()))
            {
                string roleID = requestHelper["roleID"].ToString();

                string isLock = requestHelper["isLock"].ToString();

                ISys_RoleService service = new Sys_RoleService();
                service.ChangeLockStatus(roleID, isLock);
                data.FinishFlag = 1;
                data.FinishMessage = string.Empty; 
            }
            else
            {
                data.FinishFlag = 0;
                data.FinishMessage = "操作失败";
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
    public void SetUsersForRoleID(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            if (requestHelper.ContainsKey("roleID") && !string.IsNullOrEmpty(requestHelper["roleID"].ToString()) && requestHelper.ContainsKey("userIDs") && !string.IsNullOrEmpty(requestHelper["userIDs"].ToString()) && requestHelper.ContainsKey("isAdd") && !string.IsNullOrEmpty(requestHelper["isAdd"].ToString()))
            {
                string roleID = requestHelper["roleID"].ToString();
                string[] userIDs = JsonConvert.DeserializeObject<string[]>(requestHelper["userIDs"].ToString());
                bool isAdd;
                bool.TryParse(requestHelper["isAdd"].ToString(), out isAdd);
                ISys_RoleService service = new Sys_RoleService();
                service.SetUsersForRoleID(roleID, userIDs, isAdd);
                data.FinishFlag = 1;
                data.FinishMessage = string.Empty;

                //更新此用户缓存信息
                foreach (var userID in userIDs)
                {
                    new PageBase().UpdateUserInfoCache(userID);
                }
            }
            else
            {
                data.FinishFlag = 0;
                data.FinishMessage = "操作失败";
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
    public void SetMenusForRoleID(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            if (requestHelper.ContainsKey("roleID") && !string.IsNullOrEmpty(requestHelper["roleID"].ToString()) && requestHelper.ContainsKey("menuIDs") && !string.IsNullOrEmpty(requestHelper["menuIDs"].ToString()) && requestHelper.ContainsKey("isAdd") && !string.IsNullOrEmpty(requestHelper["isAdd"].ToString()))
            {
                string roleID = requestHelper["roleID"].ToString();
                string[] menuIDs = JsonConvert.DeserializeObject<string[]>(requestHelper["menuIDs"].ToString());
                bool isAdd;
                bool.TryParse(requestHelper["isAdd"].ToString(), out isAdd);
                ISys_RoleService service = new Sys_RoleService();
                service.SetMenusForRoleID(roleID, menuIDs, isAdd);
                data.FinishFlag = 1;
                data.FinishMessage = string.Empty;
                //更新所有用户缓存
                new PageBase().UpdateAllUserCache();
            }
            else
            {
                data.FinishFlag = 0;
                data.FinishMessage = "操作失败";
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


    public void Delete(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            BizProcess.Interface.ISys_RoleService service = new BizProcess.Service.Sys_RoleService();
            if (requestHelper.ContainsKey("list") && !string.IsNullOrEmpty(requestHelper["list"].ToString()))
            {
                List<Sys_Role> list = JsonConvert.DeserializeObject<List<Sys_Role>>(requestHelper["list"].ToString());

                service.LogicDeleteBatch(list, "RoleID");
                data.FinishFlag = 1;
                data.FinishMessage = string.Empty;
            }
            else
            {
                data.FinishFlag = 0;
                data.FinishMessage = "删除失败";
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
    private void GetEntity(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            BizProcess.Interface.ISys_RoleService service = new BizProcess.Service.Sys_RoleService();
            if (requestHelper.ContainsKey("id") && !string.IsNullOrEmpty(requestHelper["id"].ToString()))
            {
                Sys_Role entity = service.GetEntityByColNameAndColValue("RoleID", requestHelper["id"].ToString());
                data.FinishFlag = 1;
                data.FinishMessage = string.Empty;
                var returns = new
                {
                    data.FinishFlag,
                    data.FinishMessage,
                    Entity = new
                    {
                        entity.RoleID,
                        entity.RoleName
                    }
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
    private void InsertOrUpdate(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            BizProcess.Interface.ISys_RoleService service = new BizProcess.Service.Sys_RoleService();

            if (requestHelper.ContainsKey("entity") && !string.IsNullOrEmpty(requestHelper["entity"].ToString()))
            {
                Sys_Role entity = JsonConvert.DeserializeObject<Sys_Role>(requestHelper["entity"].ToString());
                entity.SchoolID = new PageBase().CurrentSchoolID;
                service.InsertOrUpdate(entity);
                data.FinishFlag = 1;
                data.FinishMessage = string.Empty;
            }
            else
            {
                data.FinishFlag = 0;
                data.FinishMessage = "请传递entity参数";
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
    private void GetRoleList(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        ISys_RoleService service = new Sys_RoleService();
        OurHelper.PageHelper<Sys_Role> page = new PageHelper<Sys_Role>();
        page.PageIndex = requestHelper.PageIndex;
        page.PageSize = requestHelper.PageSize;
        page.QueryKeyValues.Add(new KeyValue("Status", "1"));
        page.QueryKeyValues.Add(new KeyValue("SchoolID",new PageBase().CurrentSchoolID));
        if (requestHelper.ContainsKey("RoleName") && !string.IsNullOrEmpty(requestHelper["RoleName"].ToString()))
        {
            page.QueryKeyValues.Add(new KeyValue("RoleName", requestHelper["RoleName"].ToString(), KeyValueOperatorType.LikeAll));
        }
        if (requestHelper.ContainsKey("UserID") && !string.IsNullOrEmpty(requestHelper["UserID"].ToString()))
        {
            page.QueryKeyValues.Add(new KeyValue("UserID", requestHelper["UserID"].ToString()));
        }

        List<Sys_Role> list = service.GetListPage(page).Data;
        data.FinishFlag = 1;
        data.FinishMessage = string.Empty;
        var returns = new
        {
            data.FinishFlag,
            data.FinishMessage,
            List = list.Select(o => new
            {
                o.RoleID,
                o.RoleName,
                o.IsLockUser
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