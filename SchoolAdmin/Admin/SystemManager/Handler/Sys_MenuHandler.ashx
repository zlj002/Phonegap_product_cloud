<%@ WebHandler Language="C#" Class="Sys_MenuHandler" %>

using System;
using System.Web;
using Entity;
using OurHelper;
using BizProcess.Interface;
using BizProcess.Service;
using System.Collections.Generic;
using System.Linq;
public class Sys_MenuHandler : IHttpHandler
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
            GetMenuList(context, requestHelper);
        }
        else
        {
            switch (action.ToString().ToUpper())
            {
                case "GETMENULIST":
                    GetMenuList(context, requestHelper);
                    break;

                case "GETMENULISTBYCURRENTUSERID":
                    GetMenuListByCurrentUserID(context, requestHelper);
                    break;
            }

        }
    }

    private void GetMenuList(HttpContext context, RequestHelper requestHelper)
    {
        ISys_MenuService service = new Sys_MenuService();
        PageHelper<Sys_Menu> page = new PageHelper<Sys_Menu>();
        page.PageIndex = requestHelper.PageIndex;
        page.PageSize = 1000;
        page.QueryKeyValues.Add(new KeyValue("Status", "1"));
        page.QueryKeyValues.Add(new KeyValue("SchoolID",new PageBase().CurrentSchoolID));
        if (requestHelper.ContainsKey("RoleID") && !string.IsNullOrEmpty(requestHelper["RoleID"].ToString()))
        {
            page.QueryKeyValues.Add(new KeyValue("RoleID", requestHelper["RoleID"].ToString()));
        }
        //获取系统菜单信息,包含操作权限信息
        List<Sys_Menu> list = service.GetPageListAllMenuRoleInfoByRoleID(page).Data;
        var returns = list.Select(ss => new
        {
            id = ss.MenuID,//id
            name = ss.MenuName,//名称
            pId = ss.ParentMenuID,//上级
            iconClass = ss.MenuIconClass,
            ss.MenuIsBelongToRole,
            ss.MenuType
        }).ToList();

        context.Response.Clear();
        context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(returns));
        context.Response.Flush();
        context.ApplicationInstance.CompleteRequest();
    }

    private void GetMenuListByCurrentUserID(HttpContext context, RequestHelper requestHelper)
    {
         
        //直接从缓存中取
        List<Sys_Menu> list = new PageBase().CurrentUser.MenuList;
        var returns = list.Select(ss => new
        {
            ss.MenuID,//id
            ss.MenuName,//名称
            ss.ParentMenuID,//上级
            ss.MenuIconClass,
            ss.MenuUrl
            ,
            ss.Depth
        }).ToList();

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