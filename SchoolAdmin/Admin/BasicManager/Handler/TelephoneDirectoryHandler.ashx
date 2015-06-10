<%@ WebHandler Language="C#" Class="TelephoneDirectoryHandler" %>
using BizProcess.Interface;
using BizProcess.Service;
using Entity;
using OurHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;
using Entity;

public class TelephoneDirectoryHandler : IHttpHandler
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
            GetList(context, requestHelper);
        }
        else
        {
            switch (action.ToString())
            {
                case "GetTelephoneDirectoryList":
                    GetList(context, requestHelper);
                    break;
            }

        }
    }

    private void GetList(HttpContext context, RequestHelper requestHelper)
    {
        IBasic_TelephoneDirectoryService service = new Basic_TelephoneDirectoryService();
        PageHelper<Entity.Basic_TelephoneDirectory> page = new PageHelper<Basic_TelephoneDirectory>();
        page.PageIndex = requestHelper.PageIndex;
        page.PageSize = requestHelper.PageSize;
        page.QueryKeyValues.Add(new KeyValue("Status", "1"));
        page.QueryKeyValues.Add(new KeyValue("SchoolID", new PageBase().CurrentSchoolID));


        Dictionary<object, object> parameters = new Dictionary<object, object>();
        if (requestHelper.ContainsKey("Name") && !string.IsNullOrEmpty(requestHelper["Name"].ToString()))
        {
            page.QueryKeyValues.Add(new KeyValue("Name", requestHelper["Name"].ToString(), KeyValueOperatorType.LikeAll));
             
        }
        List<Basic_TelephoneDirectory> list = service.GetListPage(page).Data;


        var returns = new
        {
            aaData = list.Select(o => new
            {
                o.ID,
                o.Name,
                o.Telephone,
                o.ExtNumber
            }),
            iTotalRecords = page.TotalCount,
            iTotalDisplayRecords = page.TotalCount
        };
        context.Response.Clear();
        context.Response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(returns));
        context.Response.Flush();
        context.Response.End();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}