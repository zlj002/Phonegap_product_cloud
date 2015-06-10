<%@ WebHandler Language="C#" Class="CampusHandler" %>

using System;
using System.Web;
using OurHelper;
using BizProcess.Interface;
using BizProcess.Service;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using Entity;
public class CampusHandler : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        //获取查询参数
        var requestHelper = new  RequestHelper();
        requestHelper.GenerateSearchTerm(HttpContext.Current.Request.QueryString);
        requestHelper.GenerateSearchTerm(HttpContext.Current.Request.Form);
        object action = requestHelper["action"];
        if (action == null)
        {
            GetCampusList(context, requestHelper);
        }
        else
        {
            switch (action.ToString().ToUpper())
            {
                case "GETCAMPUSLIST":
                    GetCampusList(context, requestHelper);
                    break;
            }

        }
    }

    private void GetCampusList(HttpContext context, RequestHelper requestHelper)
    {
       IBasic_CampusService service = new  Basic_CampusService();
       PageHelper<Entity.Basic_Campus> page = new PageHelper<Basic_Campus>();
       page.PageIndex = requestHelper.PageIndex;
       page.PageSize = requestHelper.PageSize;
       page.QueryKeyValues.Add(new KeyValue("Status", "1"));
       page.QueryKeyValues.Add(new KeyValue("SchoolID", new PageBase().CurrentSchoolID));

        Dictionary<object, object> parameters = new Dictionary<object, object>();
        if (requestHelper.ContainsKey("CampusName") && !string.IsNullOrEmpty(requestHelper["CampusName"].ToString()))
        {

            page.QueryKeyValues.Add(new KeyValue("CampusName", requestHelper["CampusName"].ToString(),KeyValueOperatorType.LikeAll));
        }
        List<Basic_Campus> list = service.GetListPage(page).Data;

        var returns = new
        {
            aaData = list.Select(o => new
            {
                o.CampusID,
                o.CampusName,
                o.CampusCoords
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