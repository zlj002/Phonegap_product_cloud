<%@ WebHandler Language="C#" Class="jsglHandler" %>

using System;
using System.Web;
using OurHelper;
using Entity;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
public class jsglHandler : IHttpHandler
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
                case "INSERTORUPDATE":
                    InsertOrUpdate(context, requestHelper);
                    break;
                case "DELETE":
                    Delete(context, requestHelper);
                    break;
                case "GETENTITY":
                    GetEntity(context, requestHelper);
                    break;
                case "DELETEOTHERINFO":
                    DeleteOtherInfo(context, requestHelper);
                    break;
                case "GETOTHERINFODETAIL":
                    GetOtherInfoDetail(context, requestHelper);
                    break;
                case "INSERTORUPDATEOTHERINFODETAIL":
                    InsertOrUpdateOtherInfoDetail(context, requestHelper);
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
         

                //科研
                List<TeacherOtherInfo> fruitList = new List<TeacherOtherInfo>();
                //培训
                List<TeacherOtherInfo> trainningList = new List<TeacherOtherInfo>();
                //奖励
                List<TeacherOtherInfo> rewardList = new List<TeacherOtherInfo>();
                //学历
                List<TeacherOtherInfo> educationList = new List<TeacherOtherInfo>();
                //实践
                List<TeacherOtherInfo> practiceList = new List<TeacherOtherInfo>();
                //经历
                List<TeacherOtherInfo> experienceList = new List<TeacherOtherInfo>();
                try
                {
                    foreach (var item in entity.Basic_TeacherInfo_Fruit)
                    {
                        var year = item.GetDate.Year.ToString();
                        //如果没有新增年份
                        if (!fruitList.Select(o => o.Year).Contains(year))
                        {
                            var otherInfo = new TeacherOtherInfo();
                            otherInfo.Year = year;
                            otherInfo.Data.Add(new
                            {
                                item.ID,
                                item.Name,
                                item.Role,
                                Month = item.GetDate.ToString("MM月"),
                                GetDate = item.GetDate.ToString("yyyy-MM-dd"),
                                item.Remark,
                            });
                            fruitList.Add(otherInfo);
                        }
                        else
                        {
                            fruitList.Where(o => o.Year == year).FirstOrDefault().Data.Add(new
                            {
                                item.ID,
                                item.Name,
                                item.Role,
                                Month = item.GetDate.ToString("MM月"),
                                GetDate = item.GetDate.ToString("yyyy-MM-dd"),
                                item.Remark,
                            });
                        }

                    }

                    foreach (var item in entity.Basic_TeacherInfo_Training)
                    {
                        var year = item.BeginDate.Year.ToString();
                        //如果没有新增年份
                        if (!trainningList.Select(o => o.Year).Contains(year))
                        {
                            var otherInfo = new TeacherOtherInfo();
                            otherInfo.Year = year;
                            otherInfo.Data.Add(new
                            {
                                item.ID,
                                item.Name,
                                Month = item.BeginDate.ToString("MM月"),
                                GetDate = item.BeginDate.ToString("yyyy-MM-dd"),
                                item.Remark,
                            });
                            trainningList.Add(otherInfo);
                        }
                        else
                        {
                            trainningList.Where(o => o.Year == year).FirstOrDefault().Data.Add(new
                            {
                                item.ID,
                                item.Name,
                                Month = item.BeginDate.ToString("MM月"),
                                GetDate = item.BeginDate.ToString("yyyy-MM-dd"),
                                item.Remark,
                            });
                        }

                    }
                    foreach (var item in entity.Basic_TeacherInfo_Reward)
                    {
                        var year = item.GetDate.Year.ToString();
                        //如果没有新增年份
                        if (!rewardList.Select(o => o.Year).Contains(year))
                        {
                            var otherInfo = new TeacherOtherInfo();
                            otherInfo.Year = year;
                            otherInfo.Data.Add(new
                            {
                                item.ID,
                                item.Name,
                                item.Role,
                                Month = item.GetDate.ToString("MM月"),
                                GetDate = item.GetDate.ToString("yyyy-MM-dd"),
                                item.Remark,
                            });
                            rewardList.Add(otherInfo);
                        }
                        else
                        {
                            rewardList.Where(o => o.Year == year).FirstOrDefault().Data.Add(new
                            {
                                item.ID,
                                item.Name,
                                item.Role,
                                Month = item.GetDate.ToString("MM月"),
                                GetDate = item.GetDate.ToString("yyyy-MM-dd"),
                                item.Remark,
                            });
                        }

                    }
                    foreach (var item in entity.Basic_TeacherInfo_Education)
                    {
                        var year = item.BeginDate.Year.ToString();
                        //如果没有新增年份
                        if (!educationList.Select(o => o.Year).Contains(year))
                        {
                            var otherInfo = new TeacherOtherInfo();
                            otherInfo.Year = year;
                            otherInfo.Data.Add(new
                            {
                                item.ID,
                                item.Name,
                                item.SchoolName,
                                Month = item.BeginDate.ToString("MM月"),
                                GetDate = item.BeginDate.ToString("yyyy-MM-dd"),
                                item.Remark,
                            });
                            educationList.Add(otherInfo);
                        }
                        else
                        {
                            educationList.Where(o => o.Year == year).FirstOrDefault().Data.Add(new
                            {
                                item.ID,
                                item.Name,
                                item.SchoolName,
                                Month = item.BeginDate.ToString("MM月"),
                                GetDate = item.BeginDate.ToString("yyyy-MM-dd"),
                                item.Remark,
                            });
                        }

                    }
                    foreach (var item in entity.Basic_TeacherInfo_Practice)
                    {
                        var year = item.BeginDate.Year.ToString();
                        //如果没有新增年份
                        if (!practiceList.Select(o => o.Year).Contains(year))
                        {
                            var otherInfo = new TeacherOtherInfo();
                            otherInfo.Year = year;
                            otherInfo.Data.Add(new
                            {
                                item.ID,
                                item.CompanyName,

                                Month = item.BeginDate.ToString("MM月"),
                                GetDate = item.BeginDate.ToString("yyyy-MM-dd"),
                                item.Remark,
                            });
                            practiceList.Add(otherInfo);
                        }
                        else
                        {
                            practiceList.Where(o => o.Year == year).FirstOrDefault().Data.Add(new
                            {
                                item.ID,
                                item.CompanyName,
                                Month = item.BeginDate.ToString("MM月"),
                                GetDate = item.BeginDate.ToString("yyyy-MM-dd"),
                                item.Remark,
                            });
                        }

                    }
                    foreach (var item in entity.Basic_TeacherInfo_Experience)
                    {
                        var year = item.BeginDate.Year.ToString();
                        //如果没有新增年份
                        if (!experienceList.Select(o => o.Year).Contains(year))
                        {
                            var otherInfo = new TeacherOtherInfo();
                            otherInfo.Year = year;
                            otherInfo.Data.Add(new
                            {
                                item.ID,
                                item.CompanyName,
                                Month = item.BeginDate.ToString("MM月"),
                                GetDate = item.BeginDate.ToString("yyyy-MM-dd"),
                                item.Remark,
                            });
                            experienceList.Add(otherInfo);
                        }
                        else
                        {
                            experienceList.Where(o => o.Year == year).FirstOrDefault().Data.Add(new
                            {
                                item.ID,
                                item.CompanyName,
                                Month = item.BeginDate.ToString("MM月"),
                                GetDate = item.BeginDate.ToString("yyyy-MM-dd"),
                                item.Remark,
                            });
                        }

                    }
                }
                catch
                {

                }

                data.FinishFlag = 1;
                data.FinishMessage = string.Empty;
                var returns = new
                {
                    data.FinishFlag,
                    data.FinishMessage,
                    Entity = new
                    {
                        FruitList = fruitList.OrderByDescending(o => o.Year),
                        TrainingList = trainningList.OrderByDescending(o => o.Year),
                        RewardList = rewardList.OrderByDescending(o => o.Year),
                        EducationList = educationList.OrderByDescending(o => o.Year),
                        PracticeList = practiceList.OrderByDescending(o => o.Year),
                        ExperienceList = experienceList.OrderByDescending(o => o.Year),
                        entity.ID, 
                        entity.EmployeeID,
                        entity.MobileNumber,
                        entity.Name,
                        Sex = entity.Sex ? 1 : 0,
                        entity.Healthy,
                        entity.Telephone,
                        entity.ZipCode,
                        entity.Email,
                        entity.PostalAddress,
                        entity.HomeAddress,
                        entity.JobType,
                        entity.TeachingType,
                        entity.TeacherProperty,
                        entity.Education,
                        entity.Degree,
                        entity.FirstLanguage,
                        entity.FirstExtent,
                        entity.SecondLanguage,
                        entity.SecondExtent,
                        entity.TeachSpecialty,
                        entity.Discipline,
                        entity.Certificate1,
                        entity.Level1,
                        GetDate1 = entity.GetDate1.HasValue ? entity.GetDate1.Value.ToString("yyyy-MM-dd") : "",
                        entity.Certificate2,
                        entity.Level2,
                        GetDate2 = entity.GetDate2.HasValue ? entity.GetDate2.Value.ToString("yyyy-MM-dd") : "",
                        entity.Certificate3,
                        entity.Level3,
                        GetDate3 = entity.GetDate3.HasValue ? entity.GetDate3.Value.ToString("yyyy-MM-dd") : "",
                        entity.TechnicalTitle,
                        TechnicalGetDate = entity.TechnicalGetDate.HasValue ? entity.TechnicalGetDate.Value.ToString("yyyy-MM-dd") : "",
                        entity.WorkYears,
                        entity.ManagerYears,
                        entity.Certificate4,
                        entity.Level4,
                        GetDate4 = entity.GetDate4.HasValue ? entity.GetDate4.Value.ToString("yyyy-MM-dd") : "",
                        entity.Certificate5,
                        entity.Level5,
                        GetDate5 = entity.GetDate5.HasValue ? entity.GetDate5.Value.ToString("yyyy-MM-dd") : "",
                        entity.Position,
                        IsManager = entity.IsManager.HasValue ? (entity.IsManager.Value ? 1 : 0) : 0,
                        entity.Forte,

                        entity.Political,
                        entity.PhotoUrl,
                        entity.NativePlace,
                        entity.Ethnic,
                        Birthday = entity.Birthday.HasValue?entity.Birthday.Value.ToString("yyyy-MM-dd"):"",
                        entity.Age,
                        entity.IDCard 
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

    private void InsertOrUpdateOtherInfoDetail(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            if (requestHelper.ContainsKey("entity") && !string.IsNullOrEmpty(requestHelper["entity"].ToString())
                && requestHelper.ContainsKey("dataType") && !string.IsNullOrEmpty(requestHelper["dataType"].ToString())
                )
            {
                var dataType = requestHelper["dataType"].ToString();

                if (dataType.ToUpper() == "FRUIT")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_FruitService service = new BizProcess.Service.Basic_TeacherInfo_FruitService();
                    Basic_TeacherInfo_Fruit entity = JsonConvert.DeserializeObject<Basic_TeacherInfo_Fruit>(requestHelper["entity"].ToString());
                    service.InsertOrUpdate(entity);
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;
                }
                else if (dataType.ToUpper() == "TRAINING")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_TrainingService service = new BizProcess.Service.Basic_TeacherInfo_TrainingService();
                    Basic_TeacherInfo_Training entity = JsonConvert.DeserializeObject<Basic_TeacherInfo_Training>(requestHelper["entity"].ToString());
                    service.InsertOrUpdate(entity);
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;
                }
                else if (dataType.ToUpper() == "REWARD")
                {

                    BizProcess.Interface.IBasic_TeacherInfo_RewardService service = new BizProcess.Service.Basic_TeacherInfo_RewardService();
                    Basic_TeacherInfo_Reward entity = JsonConvert.DeserializeObject<Basic_TeacherInfo_Reward>(requestHelper["entity"].ToString());
                    service.InsertOrUpdate(entity);
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;
                }
                else if (dataType.ToUpper() == "EDUCATION")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_EducationService service = new BizProcess.Service.Basic_TeacherInfo_EducationService();
                    Basic_TeacherInfo_Education entity = JsonConvert.DeserializeObject<Basic_TeacherInfo_Education>(requestHelper["entity"].ToString());
                    service.InsertOrUpdate(entity);
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;
                }
                else if (dataType.ToUpper() == "PRACTICE")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_PracticeService service = new BizProcess.Service.Basic_TeacherInfo_PracticeService();
                    Basic_TeacherInfo_Practice entity = JsonConvert.DeserializeObject<Basic_TeacherInfo_Practice>(requestHelper["entity"].ToString());
                    service.InsertOrUpdate(entity);
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;
                }
                else if (dataType.ToUpper() == "EXPERIENCE")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_ExperienceService service = new BizProcess.Service.Basic_TeacherInfo_ExperienceService();
                    Basic_TeacherInfo_Experience entity = JsonConvert.DeserializeObject<Basic_TeacherInfo_Experience>(requestHelper["entity"].ToString());
                    service.InsertOrUpdate(entity);
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;
                }
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
    private void InsertOrUpdate(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            BizProcess.Interface.IBasic_TeacherManagerService service = new BizProcess.Service.Basic_TeacherManagerService();

            if (requestHelper.ContainsKey("entity") && !string.IsNullOrEmpty(requestHelper["entity"].ToString()))
            {
                Basic_TeacherInfo entity = JsonConvert.DeserializeObject<Basic_TeacherInfo>(requestHelper["entity"].ToString());
                entity.SchoolID = new PageBase().CurrentSchoolID;
                service.InsertOrUpdate(entity);
                data.FinishFlag = 1;
                data.FinishMessage = string.Empty;
                //更新此用户缓存信息
                if (!string.IsNullOrEmpty(entity.ID))
                {
                    new PageBase().UpdateUserInfoCache(entity.ID);
                }
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

    private void GetList(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {


            BizProcess.Interface.IBasic_TeacherManagerService service = new BizProcess.Service.Basic_TeacherManagerService();
            PageHelper<Entity.Basic_TeacherInfo> page = new PageHelper<Basic_TeacherInfo>();
            page.PageIndex = requestHelper.PageIndex;
            page.PageSize = requestHelper.PageSize;
            page.QueryKeyValues.Add(new KeyValue("t.Status", "1"));
            page.QueryKeyValues.Add(new KeyValue("SchoolID",new PageBase().CurrentSchoolID));
            //查询条件 
            if (requestHelper.ContainsKey("LoginID") && !string.IsNullOrEmpty(requestHelper["LoginID"].ToString()))
            {
                List<KeyValue> queryKeyValues = new List<KeyValue>();
                queryKeyValues.Add((new KeyValue("LoginID", requestHelper["LoginID"].ToString(), KeyValueWhereType.Or, KeyValueOperatorType.LikeAll)));
                queryKeyValues.Add(new KeyValue("Name", requestHelper["LoginID"].ToString(), KeyValueWhereType.Or, KeyValueOperatorType.LikeAll));
                queryKeyValues.Add(new KeyValue("EmployeeID", requestHelper["LoginID"].ToString(), KeyValueWhereType.Or, KeyValueOperatorType.LikeAll));
                page.ComplexKeyValues.Add(new ComplexKeyValue(KeyValueWhereType.And, queryKeyValues));
            } 
            List<Basic_TeacherInfo> list = service.GetListPage(page).Data;
            data.FinishFlag = 1;
            data.FinishMessage = string.Empty;
            var returns = new
            {
                data.FinishFlag,
                data.FinishMessage,
                List = list.Select(o => new
                {
                    o.ID,
                    o.EmployeeID,
                    o.Name,
                    o.Telephone,
                    o.JobType,
                    o.TeacherProperty,
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
    public void DeleteOtherInfo(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {

            if (requestHelper.ContainsKey("id") && !string.IsNullOrEmpty(requestHelper["id"].ToString())
                && requestHelper.ContainsKey("dataType") && !string.IsNullOrEmpty(requestHelper["dataType"].ToString())
                )
            {
                var id = requestHelper["id"].ToString();
                var dataType = requestHelper["dataType"].ToString();
                //科研
                //培训
                //奖励
                //学历
                //实践
                //经历
                if (dataType.ToUpper() == "FRUIT")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_FruitService service = new BizProcess.Service.Basic_TeacherInfo_FruitService();
                    List<Basic_TeacherInfo_Fruit> list = new List<Basic_TeacherInfo_Fruit>();
                    Basic_TeacherInfo_Fruit entity = new Basic_TeacherInfo_Fruit();
                    entity.ID = id;
                    list.Add(entity);
                    service.DeleteBatch(list, "ID");
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;
                }
                else if (dataType.ToUpper() == "TRAINING")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_TrainingService service = new BizProcess.Service.Basic_TeacherInfo_TrainingService();
                    List<Basic_TeacherInfo_Training> list = new List<Basic_TeacherInfo_Training>();
                    Basic_TeacherInfo_Training entity = new Basic_TeacherInfo_Training();
                    entity.ID = id;
                    list.Add(entity);
                    service.DeleteBatch(list, "ID");
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;

                }
                else if (dataType.ToUpper() == "REWARD")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_RewardService service = new BizProcess.Service.Basic_TeacherInfo_RewardService();
                    List<Basic_TeacherInfo_Reward> list = new List<Basic_TeacherInfo_Reward>();
                    Basic_TeacherInfo_Reward entity = new Basic_TeacherInfo_Reward();
                    entity.ID = id;
                    list.Add(entity);
                    service.DeleteBatch(list, "ID");
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;
                }
                else if (dataType.ToUpper() == "EDUCATION")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_EducationService service = new BizProcess.Service.Basic_TeacherInfo_EducationService();
                    List<Basic_TeacherInfo_Education> list = new List<Basic_TeacherInfo_Education>();
                    Basic_TeacherInfo_Education entity = new Basic_TeacherInfo_Education();
                    entity.ID = id;
                    list.Add(entity);
                    service.DeleteBatch(list, "ID");
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;

                }
                else if (dataType.ToUpper() == "PRACTICE")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_PracticeService service = new BizProcess.Service.Basic_TeacherInfo_PracticeService();
                    List<Basic_TeacherInfo_Practice> list = new List<Basic_TeacherInfo_Practice>();
                    Basic_TeacherInfo_Practice entity = new Basic_TeacherInfo_Practice();
                    entity.ID = id;
                    list.Add(entity);
                    service.DeleteBatch(list, "ID");
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;

                }
                else if (dataType.ToUpper() == "EXPERIENCE")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_ExperienceService service = new BizProcess.Service.Basic_TeacherInfo_ExperienceService();
                    List<Basic_TeacherInfo_Experience> list = new List<Basic_TeacherInfo_Experience>();
                    Basic_TeacherInfo_Experience entity = new Basic_TeacherInfo_Experience();
                    entity.ID = id;
                    list.Add(entity);
                    service.DeleteBatch(list, "ID");
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;
                }
                else
                {
                    data.FinishFlag = 0;
                    data.FinishMessage = "dataType参数不正确";
                }
            }
            else
            {
                data.FinishFlag = 0;
                data.FinishMessage = "参数不正确";
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
    public void GetOtherInfoDetail(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {

            if (requestHelper.ContainsKey("id") && !string.IsNullOrEmpty(requestHelper["id"].ToString())
                && requestHelper.ContainsKey("dataType") && !string.IsNullOrEmpty(requestHelper["dataType"].ToString())
                )
            {
                var id = requestHelper["id"].ToString();
                var dataType = requestHelper["dataType"].ToString();
                //科研
                //培训
                //奖励
                //学历
                //实践
                //经历
                if (dataType.ToUpper() == "FRUIT")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_FruitService service = new BizProcess.Service.Basic_TeacherInfo_FruitService();
                    var entity = service.GetEntityByColNameAndColValue("ID", id);
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;
                    var returns = new
                    {
                        data.FinishFlag,
                        data.FinishMessage,
                        EntityFruit = new
                        {
                            entity.ID,
                            entity.Name,
                            entity.TeacherID,
                            entity.Role,
                            entity.FruitLevel,
                            GetDate = entity.GetDate.ToString("yyyy-MM-dd"),
                            entity.Remark,
                        }
                    };
                    context.Response.Clear();
                    context.Response.Write(JsonConvert.SerializeObject(returns));
                    context.Response.Flush();
                    context.ApplicationInstance.CompleteRequest();
                }
                else if (dataType.ToUpper() == "TRAINING")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_TrainingService service = new BizProcess.Service.Basic_TeacherInfo_TrainingService();
                    var entity = service.GetEntityByColNameAndColValue("ID", id);
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;
                    var returns = new
                    {
                        data.FinishFlag,
                        data.FinishMessage,
                        EntityTraining = new
                        {
                            entity.ID,
                            entity.Name,
                            entity.TeacherID,
                            entity.Organization,
                            entity.TrainingType,
                            BeginDate = entity.BeginDate.ToString("yyyy-MM-dd"),
                            EndDate = entity.EndDate.ToString("yyyy-MM-dd"),
                            entity.Remark
                        }
                    };
                    context.Response.Clear();
                    context.Response.Write(JsonConvert.SerializeObject(returns));
                    context.Response.Flush();
                    context.ApplicationInstance.CompleteRequest();

                }
                else if (dataType.ToUpper() == "REWARD")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_RewardService service = new BizProcess.Service.Basic_TeacherInfo_RewardService();
                    var entity = service.GetEntityByColNameAndColValue("ID", id);
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;
                    var returns = new
                    {
                        data.FinishFlag,
                        data.FinishMessage,
                        EntityReward = new
                        {
                            entity.ID,
                            entity.Name,
                            entity.TeacherID,
                            entity.RewardLevel,
                            entity.RewardType,
                            entity.Role,
                            entity.RewardName,
                            entity.Company,
                            GetDate = entity.GetDate.ToString("yyyy-MM-dd"),
                            entity.Remark
                        }
                    };
                    context.Response.Clear();
                    context.Response.Write(JsonConvert.SerializeObject(returns));
                    context.Response.Flush();
                    context.ApplicationInstance.CompleteRequest();
                }
                else if (dataType.ToUpper() == "EDUCATION")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_EducationService service = new BizProcess.Service.Basic_TeacherInfo_EducationService();
                    var entity = service.GetEntityByColNameAndColValue("ID", id);
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;
                    var returns = new
                    {
                        data.FinishFlag,
                        data.FinishMessage,
                        EntityEducation = new
                        {
                            entity.ID,
                            entity.Name,
                            entity.TeacherID,
                            BeginDate = entity.BeginDate.ToString("yyyy-MM-dd"),
                            EndDate = entity.EndDate.HasValue ? entity.EndDate.Value.ToString("yyyy-MM-dd") : "",
                            entity.SchoolName,
                            entity.SpecialtyName,
                            entity.Remark
                        }
                    };
                    context.Response.Clear();
                    context.Response.Write(JsonConvert.SerializeObject(returns));
                    context.Response.Flush();
                    context.ApplicationInstance.CompleteRequest();

                }
                else if (dataType.ToUpper() == "PRACTICE")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_PracticeService service = new BizProcess.Service.Basic_TeacherInfo_PracticeService();
                    var entity = service.GetEntityByColNameAndColValue("ID", id);
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;
                    var returns = new
                    {
                        data.FinishFlag,
                        data.FinishMessage,
                        EntityPractice = new
                        {
                            entity.ID,
                            entity.CompanyName,
                            entity.TeacherID,
                            BeginDate = entity.BeginDate.ToString("yyyy-MM-dd"),
                            EndDate = entity.EndDate.ToString("yyyy-MM-dd"),
                            entity.WorkingDays,
                            entity.NotWorkingDays,
                            entity.PracticeContent,
                            entity.Achievement,
                            entity.Remark
                        }
                    };
                    context.Response.Clear();
                    context.Response.Write(JsonConvert.SerializeObject(returns));
                    context.Response.Flush();
                    context.ApplicationInstance.CompleteRequest();

                }
                else if (dataType.ToUpper() == "EXPERIENCE")
                {
                    BizProcess.Interface.IBasic_TeacherInfo_ExperienceService service = new BizProcess.Service.Basic_TeacherInfo_ExperienceService();
                    var entity = service.GetEntityByColNameAndColValue("ID", id);
                    data.FinishFlag = 1;
                    data.FinishMessage = string.Empty;
                    var returns = new
                    {
                        data.FinishFlag,
                        data.FinishMessage,
                        EntityExperience = new
                        {
                            entity.ID,
                            entity.WorkType,
                            entity.TeacherID,
                            BeginDate = entity.BeginDate.ToString("yyyy-MM-dd"),
                            EndDate = entity.EndDate.ToString("yyyy-MM-dd"),
                            entity.CompanyName,
                            entity.Industry,
                            entity.Remark
                        }
                    };
                    context.Response.Clear();
                    context.Response.Write(JsonConvert.SerializeObject(returns));
                    context.Response.Flush();
                    context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    data.FinishFlag = 0;
                    data.FinishMessage = "dataType参数不正确";
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
            else
            {
                data.FinishFlag = 0;
                data.FinishMessage = "参数不正确";
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


    public void Delete(HttpContext context, RequestHelper requestHelper)
    {
        InteractiveData data = new InteractiveData();
        try
        {
            BizProcess.Interface.IBasic_TeacherManagerService service = new BizProcess.Service.Basic_TeacherManagerService();
            if (requestHelper.ContainsKey("teachers") && !string.IsNullOrEmpty(requestHelper["teachers"].ToString()))
            {
                List<Basic_TeacherInfo> list = JsonConvert.DeserializeObject<List<Basic_TeacherInfo>>(requestHelper["teachers"].ToString());

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
class TeacherOtherInfo
{
    public string Year;
    public List<object> Data = new List<object>();
}