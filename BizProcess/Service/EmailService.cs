using BizProcess.Base.Service;
using BizProcess.Interface;
using Entity;
using Entity.CustomEntity;
using OurHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BizProcess.Service
{
    public class EmailService : BaseService<MyEmailInfo>, IEmailService
    {
        /// <summary>
        /// 根据登录的用户，获取相关的邮件列表并返回。
        /// </summary>
        /// <param name="UserNo"></param>
        /// <param name="Count"></param>
        /// <returns></returns>
        public MyEmailInfo GetEmailList(string UserNo, string Count)
        {
            MyEmailInfo result = new MyEmailInfo();
            try
            {
               
                //获取此模块相关配置信息
                ISys_FeatureService sys_FeatureService = new Sys_FeatureService();
                Sys_Feature sys_FeatureEntity = sys_FeatureService.GetEntityByColNameAndColValue("FeatureID", "GetEmailList");

                if (sys_FeatureEntity.DataResourceType.HasValue && sys_FeatureEntity.DataResourceType.Value == (int)ConstantEntity.DataResourceType.WebService)
                {
                    //接口模式
                    //构造参数 
                    List<String> lstContent = new List<string>();
                    lstContent.Add(UserNo);
                    lstContent.Add(Count);
                    //开始访问
                    WebServiceProxy wsd = new WebServiceProxy(sys_FeatureEntity.DataWebServiceUrl, sys_FeatureEntity.DataWebServiceMethod);
                    object returnVal = wsd.ExecuteQuery(sys_FeatureEntity.DataWebServiceMethod, lstContent.ToArray());
                    if (returnVal != null)
                    {
                        result = JsonHelper.JsonDeserialize<MyEmailInfo>(returnVal.ToString());
                    }           
                     
                }
                else if (sys_FeatureEntity.DataResourceType.HasValue && sys_FeatureEntity.DataResourceType.Value == (int)ConstantEntity.DataResourceType.DataTable)
                {
                     
                }

            }
            catch (Exception ex)
            { 
                result.ReturnFlag = (int)ConstantEntity.ReturnFlag.Failed;
                result.ReturnMessage = ex.Message;           
            }

            return result;
        }


        /// <summary>
        /// 根据登录的用户和邮件ID，显示具体邮件的详细界面
        /// </summary>
        /// <param name="UserNo"></param>
        /// <param name="ID"></param>
        /// <returns></returns>
        public MyEmailInfo GetEmail(string UserNo, string ID)
        {
            MyEmailInfo result = new MyEmailInfo();

            try
            { 
                //获取此模块相关配置信息
                ISys_FeatureService sys_FeatureService = new Sys_FeatureService();
                Sys_Feature sys_FeatureEntity = sys_FeatureService.GetEntityByColNameAndColValue("FeatureID", "GetEmail");

                if (sys_FeatureEntity.DataResourceType.HasValue && sys_FeatureEntity.DataResourceType.Value == 1)
                {//接口模式
                    //构造参数 
                    List<String> lstContent = new List<string>();
                    lstContent.Add(UserNo);
                    lstContent.Add(ID);
                    //开始访问
                    WebServiceProxy wsd = new WebServiceProxy(sys_FeatureEntity.DataWebServiceUrl, sys_FeatureEntity.DataWebServiceMethod);
                    object returnVal = wsd.ExecuteQuery(sys_FeatureEntity.DataWebServiceMethod, lstContent.ToArray());
                    if (returnVal != null)
                    {
                        result = JsonHelper.JsonDeserialize<MyEmailInfo>(returnVal.ToString());
                    }
                         

                }
                else if (sys_FeatureEntity.DataResourceType.HasValue && sys_FeatureEntity.DataResourceType.Value == 2)
                {
                 
                }

          
            }
            catch (Exception ex)
            {
                result.ReturnFlag = (int)ConstantEntity.ReturnFlag.Failed;
                result.ReturnMessage = ex.Message;
                 
            }
            return result;
        }


        /// <summary>
        /// 创建新的邮件或回复邮件，并提供给第三方。
        /// </summary>
        /// <param name="UserNo"></param>
        /// <param name="ID"></param>
        /// <returns></returns>
        public MyEmailInfo SubmitEmail(string UserNo, string email)
        {
            MyEmailInfo result = new MyEmailInfo();

            try
            {                
                //获取此模块相关配置信息
                ISys_FeatureService sys_FeatureService = new Sys_FeatureService();
                Sys_Feature sys_FeatureEntity = sys_FeatureService.GetEntityByColNameAndColValue("FeatureID", "SubmitEmail");

                if (sys_FeatureEntity.DataResourceType.HasValue && sys_FeatureEntity.DataResourceType.Value == 1)
                {//接口模式
                    //构造参数 
                    List<String> lstContent = new List<string>();
                    lstContent.Add(UserNo);
                    lstContent.Add(email);//序列号json
                    //开始访问
                    WebServiceProxy wsd = new WebServiceProxy(sys_FeatureEntity.DataWebServiceUrl, sys_FeatureEntity.DataWebServiceMethod);
                    object returnVal = wsd.ExecuteQuery(sys_FeatureEntity.DataWebServiceMethod, lstContent.ToArray());
                    if (returnVal != null)
                    {
                        result = JsonHelper.JsonDeserialize<MyEmailInfo>(returnVal.ToString());
                    }


                }
                else if (sys_FeatureEntity.DataResourceType.HasValue && sys_FeatureEntity.DataResourceType.Value == 2)
                {
                   
                }

               
            }
            catch (Exception ex)
            {
                result.ReturnFlag = (int)ConstantEntity.ReturnFlag.Failed;
                result.ReturnMessage = ex.Message;

            }
            return result;

        }

    }
}
