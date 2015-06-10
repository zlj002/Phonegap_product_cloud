<%@ WebHandler Language="C#" Class="contentHandler" %>

using System;
using System.Web;
using OurHelper;
using Entity;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;

public class contentHandler : IHttpHandler
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
            GetCategoryList(context, requestHelper);
        }
        else
        {
            switch (action.ToString().ToUpper())
            {

                case "UPDATERECOMMENDTYPESTATUS":
                    UpdateRecommendTypeStatus(context, requestHelper);
                    break;
                case "INSERTORUPDATEARTICLE":
                    InsertOrUpdateArticle(context, requestHelper);
                    break;
                case "GETLIST":
                    GetList(context, requestHelper);
                    break;
                case "GETCATEGORYLIST":
                    GetCategoryList(context, requestHelper);
                    break;
                case "INSERTORUPDATE":
                    InsertOrUpdate(context, requestHelper);
                    break;
                case "GETENTITY":
                    GetEntity(context, requestHelper);
                    break;
                case "GETENTITYARTICLE":
                    GetEntityArticle(context, requestHelper);
                    break;
                case "DELETE":
                    Delete(context, requestHelper);
                    break;
                case "DELETEARTICLE":
                    DeleteArticle(context, requestHelper);
                    break;
            }

        }
    }

    public void DeleteArticle(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            BizProcess.Interface.IContent_ArticleService service = new BizProcess.Service.Content_ArticleService();
            if (requestHelper.ContainsKey("list") && !string.IsNullOrEmpty(requestHelper["list"].ToString()))
            {
                List<Content_Article> list = JsonConvert.DeserializeObject<List<Content_Article>>(requestHelper["list"].ToString());

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
    public void UpdateRecommendTypeStatus(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            BizProcess.Interface.IContent_ArticleService service = new BizProcess.Service.Content_ArticleService();
            if (requestHelper.ContainsKey("id") && !string.IsNullOrEmpty(requestHelper["id"].ToString())
                && requestHelper.ContainsKey("recommendType") && !string.IsNullOrEmpty(requestHelper["recommendType"].ToString())
                )
            {
                service.UpdateRecommendTypeStatus(requestHelper["id"].ToString(), requestHelper["recommendType"].ToString());
                data.FinishFlag = 1;
                data.FinishMessage = string.Empty;
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
    public void GetEntityArticle(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            BizProcess.Interface.IContent_ArticleService service = new BizProcess.Service.Content_ArticleService();
            if (requestHelper.ContainsKey("id") && !string.IsNullOrEmpty(requestHelper["id"].ToString()))
            {
                Content_Article entity = service.GetEntityByColNameAndColValue("id", requestHelper["id"].ToString());

                data.FinishFlag = 1;
                data.FinishMessage = string.Empty;
                var returns = new
                {
                    data.FinishFlag,
                    data.FinishMessage,
                    Entity = new
                    {
                        entity.ID,
                        entity.Title,
                        entity.CategoryID,
                        entity.RecommendType,
                        entity.CoverImage,
                        entity.BrowseCount,
                        entity.Digest,
                        PublishTime = entity.PublishTime.HasValue ? entity.PublishTime.Value.ToString("yyyy-MM-dd") : "",
                        entity.SourceUrl,
                        entity.ArticleContent,
                        entity.CreateTime,
                        entity.CreateUser,
                        entity.UpdateTime,
                        entity.UpdateUser,
                        entity.Status,
                        entity.Remark,
                        entity.DisplayIndex,
                        Content_ArticleSlide = entity.Content_ArticleSlide.Select(o => new
                        {
                            o.SlideID,
                            o.SlideFileName,
                            o.ArticleID,
                            o.SlideImageUrl,
                            o.SlideTitle,
                            o.SlideFileSize
                        })
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
            BizProcess.Interface.IContent_ArticleService service = new BizProcess.Service.Content_ArticleService();
            PageHelper<Entity.Content_Article> page = new PageHelper<Content_Article>();
            page.PageIndex = requestHelper.PageIndex;
            page.PageSize = requestHelper.PageSize;
            page.QueryKeyValues.Add(new KeyValue("Status", "1"));
            page.QueryKeyValues.Add(new KeyValue("SchoolID", new PageBase().CurrentSchoolID));

            //查询条件 
            if (requestHelper.ContainsKey("CategoryID") && !string.IsNullOrEmpty(requestHelper["CategoryID"].ToString()))
            {
                page.QueryKeyValues.Add(new KeyValue("CategoryID", requestHelper["CategoryID"].ToString(), KeyValueOperatorType.LikeAll));
            }

            if (requestHelper.ContainsKey("Title") && !string.IsNullOrEmpty(requestHelper["Title"].ToString()))
            {
                page.QueryKeyValues.Add(new KeyValue("Title", requestHelper["Title"].ToString(), KeyValueOperatorType.LikeAll));
            }
            page.OrderBy = " DisplayIndex asc ,CreateTime desc,PublishTime desc ";
            List<Content_Article> list = service.GetListPage(page).Data;
            data.FinishFlag = 1;
            data.FinishMessage = string.Empty;
            var returns = new
            {
                data.FinishFlag,
                data.FinishMessage,
                List = list.Select(o => new
                {
                    o.ID,
                    o.Title,
                    o.CategoryID,
                    o.RecommendType,
                    o.CoverImage,
                    o.BrowseCount,
                    o.Digest,
                    o.SourceUrl,
                    PublishTime = o.PublishTime.HasValue ? o.PublishTime.Value.ToString("yyyy-MM-dd") : "",
                    isTop = string.IsNullOrEmpty(o.RecommendType) ? false : (o.RecommendType.IndexOf("1") > -1),
                    isRecommend = string.IsNullOrEmpty(o.RecommendType) ? false : (o.RecommendType.IndexOf("2") > -1),
                    isHot = string.IsNullOrEmpty(o.RecommendType) ? false : (o.RecommendType.IndexOf("3") > -1),
                    isSlide = string.IsNullOrEmpty(o.RecommendType) ? false : (o.RecommendType.IndexOf("4") > -1),

                }),
                iTotalRecords = page.TotalCount,
                iTotalDisplayRecords = page.TotalCount,
                pageCount = (page.TotalCount + page.PageSize - 1) / page.PageSize
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
            BizProcess.Interface.IContent_CategoryService service = new BizProcess.Service.Content_CategoryService();
            if (requestHelper.ContainsKey("list") && !string.IsNullOrEmpty(requestHelper["list"].ToString()))
            {
                List<Content_Category> list = JsonConvert.DeserializeObject<List<Content_Category>>(requestHelper["list"].ToString());

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
    public void GetEntity(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            BizProcess.Interface.IContent_CategoryService service = new BizProcess.Service.Content_CategoryService();
            if (requestHelper.ContainsKey("id") && !string.IsNullOrEmpty(requestHelper["id"].ToString()))
            {
                Content_Category entity = service.GetEntityByColNameAndColValue("id", requestHelper["id"].ToString());

                data.FinishFlag = 1;
                data.FinishMessage = string.Empty;
                var returns = new
                {
                    data.FinishFlag,
                    data.FinishMessage,
                    Entity = new
                    {
                        entity.ID,//id
                        entity.Name,//名称
                        entity.ParentID,//上级 
                        entity.ContentPath,//url
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

    private void InsertOrUpdateArticle(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            BizProcess.Interface.IContent_ArticleService service = new BizProcess.Service.Content_ArticleService();

            if (requestHelper.ContainsKey("entity") && !string.IsNullOrEmpty(requestHelper["entity"].ToString()))
            {
                Content_Article entity = JsonConvert.DeserializeObject<Content_Article>(requestHelper["entity"].ToString());
                entity.SchoolID = new PageBase().CurrentSchoolID;
                entity = service.InsertOrUpdate(entity);

                data.FinishFlag = 1;
                data.FinishMessage = string.Empty;

                var result = new
                {
                    data.FinishFlag,
                    data.FinishMessage,
                    Entity = new
                    {
                        entity.ID,
                        entity.Title,
                        entity.CategoryID,
                        entity.RecommendType,
                        entity.CoverImage,
                        entity.BrowseCount,
                        entity.Digest,
                        entity.PublishTime,
                        entity.SourceUrl,
                        entity.ArticleContent,
                        entity.CreateTime,
                        entity.CreateUser,
                        entity.UpdateTime,
                        entity.UpdateUser,
                        entity.Status,
                        entity.Remark,
                        entity.DisplayIndex,
                    }
                };

                context.Response.Clear();
                context.Response.Write(JsonConvert.SerializeObject(result));
                context.Response.Flush();
                context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                data.FinishFlag = 0;
                data.FinishMessage = "请传递entity参数";

                var returns = new
                {
                    data.FinishFlag,
                    data.FinishMessage,
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
            BizProcess.Interface.IContent_CategoryService service = new BizProcess.Service.Content_CategoryService();

            if (requestHelper.ContainsKey("entity") && !string.IsNullOrEmpty(requestHelper["entity"].ToString()))
            {
                Content_Category entity = JsonConvert.DeserializeObject<Content_Category>(requestHelper["entity"].ToString());
                entity.SchoolID = new PageBase().CurrentSchoolID;
                entity = service.InsertOrUpdate(entity);

                data.FinishFlag = 1;
                data.FinishMessage = string.Empty;

                var result = new
                {
                    data.FinishFlag,
                    data.FinishMessage,
                    Entity = new
                    {
                        id = entity.ID,//id
                        name = entity.Name,//名称
                        pId = entity.ParentID,//上级   
                    }
                };

                context.Response.Clear();
                context.Response.Write(JsonConvert.SerializeObject(result));
                context.Response.Flush();
                context.ApplicationInstance.CompleteRequest();
            }
            else
            {
                data.FinishFlag = 0;
                data.FinishMessage = "请传递entity参数";

                var returns = new
                {
                    data.FinishFlag,
                    data.FinishMessage,
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
    private void GetCategoryList(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            BizProcess.Interface.IContent_CategoryService service = new BizProcess.Service.Content_CategoryService();
            PageHelper<Entity.Content_Category> page = new PageHelper<Content_Category>();
            page.PageIndex = requestHelper.PageIndex;
            page.PageSize = 10000;
            page.QueryKeyValues.Add(new KeyValue("Status", "1"));
            page.QueryKeyValues.Add(new KeyValue("SchoolID", new PageBase().CurrentSchoolID));
            page.OrderBy = " DisplayIndex asc ";
            //查询条件  
            List<Content_Category> list = service.GetListPage(page).Data;
            Content_Category root = new Content_Category();
            root.Name = "学校";
            list.Add(root);

            data.FinishFlag = 1;
            data.FinishMessage = string.Empty;
            var returns = new
            {
                data.FinishFlag,
                data.FinishMessage,
                List = list.Select(o => new
                {
                    id = o.ID,//id
                    name = o.Name,//名称
                    pId = o.ParentID,//上级  
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