<%@ WebHandler Language="C#" Class="dicHandler" %>

using System;
using System.Web;
using OurHelper;
using Entity;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using BizProcess.Interface;
using BizProcess.Service;
public class dicHandler : IHttpHandler
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
        InteractiveData data = new InteractiveData();
        try
        {

            IBasic_DictCodeService service = new Basic_DictCodeService();
            PageHelper<Basic_DictCode> page = new PageHelper<Basic_DictCode>();
            page.PageSize = 10000;
            if (requestHelper.ContainsKey("DictCodeType") && !string.IsNullOrEmpty(requestHelper["DictCodeType"].ToString()))
            {
                page.QueryKeyValues.Add(new KeyValue("t.DictCodeType", requestHelper["DictCodeType"].ToString()));

            }
            else
            {
                throw new Exception("请传递DictCodeType参数");
            }
            //查询条件
            List<Basic_DictCode> list = service.GetListPage(page).Data;
            data.FinishFlag = 1;
            data.FinishMessage = string.Empty;
            var returns = new
            {
                data.FinishFlag,
                data.FinishMessage,
                List = list.Select(o => new
                {
                    o.DictCode,
                    o.DictCodeName
                }),
                iTotalRecords = page.TotalCount,
                iTotalDisplayRecords = page.TotalCount
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
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}