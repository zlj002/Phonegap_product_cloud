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
    public class NoticeService : BaseService<MyNoticeInfo>, INoticeService
    {

        /// <summary>
        /// 根据登录的用户，获取相关的通知公告列表并返回。
        /// </summary>
        /// <param name="UserNo"></param>
        /// <param name="Count"></param>
        /// <returns></returns>
        public MyNoticeInfo GetNoticeList(string UserNo, string UserType, string Count)
        {
            MyNoticeInfo result = new MyNoticeInfo();

            try
            {                
                //获取此模块相关配置信息
                ISys_FeatureService sys_FeatureService = new Sys_FeatureService();
                Sys_Feature sys_FeatureEntity = sys_FeatureService.GetEntityByColNameAndColValue("FeatureID", "GetNoticeList");

                if (sys_FeatureEntity.DataResourceType.HasValue && sys_FeatureEntity.DataResourceType.Value ==   (int)ConstantEntity.DataResourceType.WebService)
                {//接口模式
                    //构造参数 
                    List<String> lstContent = new List<string>();
                    lstContent.Add(UserNo);
                    lstContent.Add(UserType);
                    lstContent.Add(Count);
                    //开始访问
                    WebServiceProxy wsd = new WebServiceProxy(sys_FeatureEntity.DataWebServiceUrl, sys_FeatureEntity.DataWebServiceMethod);
                    object returnVal = wsd.ExecuteQuery(sys_FeatureEntity.DataWebServiceMethod, lstContent.ToArray());
                    if (returnVal != null)
                    {
                        result = JsonHelper.JsonDeserialize<MyNoticeInfo>(returnVal.ToString());
                    }
                     
                }
                else if (sys_FeatureEntity.DataResourceType.HasValue && sys_FeatureEntity.DataResourceType.Value ==  (int)ConstantEntity.DataResourceType.DataTable)
                {
                    
                } 
                
            }
            catch (Exception e)
            {
                result.ReturnFlag = (int)ConstantEntity.ReturnFlag.Failed;
                result.ReturnMessage = e.Message;
            }
            return result;

        }
         
        
        /// <summary>
        /// 查看通知公告的详细信息
        /// </summary>
        /// <param name="ID"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        public MyNoticeInfo GetNotice(string ID, string type)
        {
            MyNoticeInfo result = new MyNoticeInfo();

            try
            {              
                //获取此模块相关配置信息
                ISys_FeatureService sys_FeatureService = new Sys_FeatureService();
                Sys_Feature sys_FeatureEntity = sys_FeatureService.GetEntityByColNameAndColValue("FeatureID", "GetNotice");

                if (sys_FeatureEntity.DataResourceType.HasValue && sys_FeatureEntity.DataResourceType.Value == 1)
                {//接口模式
                    //构造参数 
                    List<String> lstContent = new List<string>();
                    lstContent.Add(ID);
                    lstContent.Add(type);
                    //开始访问
                    WebServiceProxy wsd = new WebServiceProxy(sys_FeatureEntity.DataWebServiceUrl, sys_FeatureEntity.DataWebServiceMethod);
                    object returnVal = wsd.ExecuteQuery(sys_FeatureEntity.DataWebServiceMethod, lstContent.ToArray());
                    if (returnVal != null)
                    {
                        result = JsonHelper.JsonDeserialize<MyNoticeInfo>(returnVal.ToString());
                    }
                     

                }
                else if (sys_FeatureEntity.DataResourceType.HasValue && sys_FeatureEntity.DataResourceType.Value == 2)
                {
                    
                }

            }
            catch (Exception e)
            {
                result.ReturnFlag = (int)ConstantEntity.ReturnFlag.Failed;
                result.ReturnMessage = e.Message;
            }
            return result;

        }
    }
}
