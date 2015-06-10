<%@ WebHandler Language="C#" Class="Basic_SpecialtyHandler" %>

using System;
using System.Web;
using OurHelper;
using System.Linq;
using Entity;
using BizProcess.Service;
using BizProcess.Interface;
using System.Collections.Generic;

public class Basic_SpecialtyHandler : IHttpHandler
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
                case "GetBasic_SpecialtyList":
                    GetList(context, requestHelper);
                    break;
            }

        }
    }

    private void GetList(HttpContext context, RequestHelper requestHelper)
    {
        string schoolID = new PageBase().CurrentSchoolID;
        IBasic_SpecialtyService service = new Basic_SpecialtyService();


        Dictionary<object, object> parameters = new Dictionary<object, object>();
        if (requestHelper.ContainsKey("Name") && !string.IsNullOrEmpty(requestHelper["Name"].ToString()))
        {

            parameters.Add("Name", requestHelper["Name"]);
        }
        //List<Basic_Specialty> list = service.QueryForListByCustomSql(ref pageIndex, ref pageSize, ref totalCount, parameters);
        PageHelper<Basic_Specialty> page = new PageHelper<Basic_Specialty>();
        page.QueryKeyValues.Add(new KeyValue("SchoolID",schoolID));
        page.QueryKeyValues.Add(new KeyValue("Status","1"));
        page.PageIndex = requestHelper.PageIndex;
        page.PageSize = requestHelper.PageSize;

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