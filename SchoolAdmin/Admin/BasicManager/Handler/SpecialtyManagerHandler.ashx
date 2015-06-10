<%@ WebHandler Language="C#" Class="SpecialtyManagerHandler" %>

using System;
using System.Web;
using BizProcess.Interface;
using BizProcess.Service;
using Entity;
using OurHelper;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
public class SpecialtyManagerHandler : IHttpHandler
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
            switch (action.ToString().ToUpper())
            {
                case "GETLIST":
                    GetList(context, requestHelper);
                    break;
            }

        }
    }

    private void GetList(HttpContext context, RequestHelper requestHelper)
    {
        IBasic_SpecialtyService service = new Basic_SpecialtyService();
        PageHelper<Entity.Basic_Specialty> page = new PageHelper<Basic_Specialty>();
        page.PageIndex = requestHelper.PageIndex;
        page.PageSize = requestHelper.PageSize;
        page.QueryKeyValues.Add(new KeyValue("Status", "1"));
        page.QueryKeyValues.Add(new KeyValue("SchoolID", new PageBase().CurrentSchoolID)); 
        if (requestHelper.ContainsKey("Name") && !string.IsNullOrEmpty(requestHelper["Name"].ToString()))
        { 
            page.QueryKeyValues.Add(new KeyValue("Name", requestHelper["Name"].ToString(),KeyValueOperatorType.LikeAll));
        }
        List<Basic_Specialty> list = service.GetListPage(page).Data;
        var returns = new
        {
            aaData = list.Select(o => new
            {
                o.ID,
                o.Name,
                o.Description
            }),
            iTotalRecords = page.TotalCount,
            iTotalDisplayRecords = page.TotalCount
        };
        context.Response.Clear();
        context.Response.Write(JsonConvert.SerializeObject(returns));
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