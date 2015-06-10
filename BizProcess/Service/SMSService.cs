using BizProcess.Base.Service;
using BizProcess.Interface;
using DataAccess.Repository;
using Entity;
using Entity.CustomEntity;
using OurHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BizProcess.Service
{
    public class SMSService : ISMSService
    {



        public string SendSMSMessage(string userString, string passwordString, string[] mobiles, string content, string planTime, string filename)
        {
            string result = "";
            try
            {
                //获取此模块相关配置信息
                ISys_OtherSysInterfaceAddrService sys_FeatureService = new Sys_OtherSysInterfaceAddrService();
                Sys_OtherSysInterfaceAddr sys_FeatureEntity = sys_FeatureService.GetEntityByColNameAndColValue("ID", "CarrieroperatorInterface");

                //数据来源
                if (sys_FeatureEntity != null)
                {

                    //构造参数 
                    List<object> lstContent = new List<object>();
                    lstContent.Add(userString);
                    lstContent.Add(passwordString);
                    lstContent.Add(mobiles);
                    lstContent.Add(content);
                    lstContent.Add(planTime);
                    lstContent.Add(filename);
                    //开始访问

                    WebServiceProxy wsd = new WebServiceProxy(sys_FeatureEntity.URL, sys_FeatureEntity.DataWebServiceMethod);
                    object returnVal = wsd.ExecuteQuery(sys_FeatureEntity.DataWebServiceMethod, lstContent.ToArray());
                    if (returnVal != null)
                    {
                        result = returnVal.ToString();
                    }
                }
                else
                {

                }
            }
            catch (Exception e)
            {

            }
            return result;
        }

        public string GetRemainderSmsCount(string userName, string password)
        {
            string result = "";
            try
            {
                //获取此模块相关配置信息
                ISys_OtherSysInterfaceAddrService sys_FeatureService = new Sys_OtherSysInterfaceAddrService();
                Sys_OtherSysInterfaceAddr sys_FeatureEntity = sys_FeatureService.GetEntityByColNameAndColValue("ID", "GetRemainderSmsCount");

                //数据来源
                if (sys_FeatureEntity != null)
                {

                    //构造参数 
                    List<object> lstContent = new List<object>();
                    lstContent.Add(userName);
                    lstContent.Add(password);
                    //开始访问

                    WebServiceProxy wsd = new WebServiceProxy(sys_FeatureEntity.URL, sys_FeatureEntity.DataWebServiceMethod);
                    object returnVal = wsd.ExecuteQuery(sys_FeatureEntity.DataWebServiceMethod, lstContent.ToArray());
                    if (returnVal != null)
                    {
                        result = returnVal.ToString();
                    }
                }
                else
                {

                }
            }
            catch (Exception e)
            {

            }
            return result;
        }
    }
}
