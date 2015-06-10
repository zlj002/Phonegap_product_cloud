<%@ WebHandler Language="C#" Class="studentHandler" %>

using System;
using System.Web;
using OurHelper;
using Entity;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
public class studentHandler : IHttpHandler
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
                case "GETENTITY":
                    GetEntity(context, requestHelper);
                    break;
                case "DELETE":
                    Delete(context, requestHelper);
                    break;
            }


        }
    }


    public void GetEntity(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            BizProcess.Interface.IBasic_TeacherManagerService service = new BizProcess.Service.Basic_TeacherManagerService();
            if (requestHelper.ContainsKey("id") && !string.IsNullOrEmpty(requestHelper["id"].ToString()))
            {
                Basic_TeacherInfo entity = service.GetEntityByColNameAndColValue("id", requestHelper["id"].ToString());




                data.FinishFlag = 1;
                data.FinishMessage = string.Empty;
                var returns = new
                {
                    data.FinishFlag,
                    data.FinishMessage,
                    Entity = new
                    {

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



    private void GetList(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {


            BizProcess.Interface.IBasic_StudentService service = new BizProcess.Service.Basic_StudentService();
            PageHelper<Entity.Basic_Student> page = new PageHelper<Basic_Student>();
            page.PageIndex = requestHelper.PageIndex;
            page.PageSize = requestHelper.PageSize;
            page.QueryKeyValues.Add(new KeyValue("t.Status", "1")); 
            page.QueryKeyValues.Add(new KeyValue("SchoolID", new PageBase().CurrentSchoolID));
            if (requestHelper.ContainsKey("LoginID") && !string.IsNullOrEmpty(requestHelper["LoginID"].ToString()))
            {
                List<KeyValue> queryKeyValues = new List<KeyValue>();
                queryKeyValues.Add((new KeyValue("LoginID", requestHelper["LoginID"].ToString(), KeyValueWhereType.Or, KeyValueOperatorType.LikeAll)));
                queryKeyValues.Add(new KeyValue("Name", requestHelper["LoginID"].ToString(), KeyValueWhereType.Or, KeyValueOperatorType.LikeAll));
                queryKeyValues.Add(new KeyValue("XH", requestHelper["LoginID"].ToString(), KeyValueWhereType.Or, KeyValueOperatorType.LikeAll));
                page.ComplexKeyValues.Add(new ComplexKeyValue(KeyValueWhereType.And, queryKeyValues));
            } 
            
            
            List<Basic_Student> list = service.GetListPage(page).Data;
            data.FinishFlag = 1;
            data.FinishMessage = string.Empty;
            var returns = new
            {
                data.FinishFlag,
                data.FinishMessage,
                List = list.Select(o => new
                {
                    o.ID ,
                    o.Name,
                    o.XH,
                    o.MobileNumber,
                    o.LoginID
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



    public void Delete(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            BizProcess.Interface.IBasic_StudentService service = new BizProcess.Service.Basic_StudentService();
            if (requestHelper.ContainsKey("students") && !string.IsNullOrEmpty(requestHelper["students"].ToString()))
            {
                List<Basic_Student> list = JsonConvert.DeserializeObject<List<Basic_Student>>(requestHelper["students"].ToString());

                service.LogicDeleteBatch(list, "ID");
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



    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}