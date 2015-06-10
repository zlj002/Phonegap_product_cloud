using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using BizProcess.Interface;
using BizProcess.Base.Service;
using DataAccess.Repository;
using DataAccess.Interface;
using OurHelper;
using Entity.CustomEntity;
using Newtonsoft.Json;

namespace BizProcess.Service
{
    public class MessageService : BaseService<Message_RegisterMobile>, IMessageService
    {
        IMessage_RegisterMobileRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public MessageService()
        {
            subRepository = new Message_RegisterMobileRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 默认构造
        /// </summary>
        public MessageService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Message_RegisterMobileRepository(base.SchoolID);
            base.repository = subRepository;
        }

        /// <summary>
        /// 生成修改密码的短信验证码
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public Message_RegisterMobile GenResetPasswordMobileCode(Message_RegisterMobile entity)
        {
            //先删除此手机号下的所有验证码
            subRepository.DeleteMessageCodeByMobileNumber(entity.MobileNumber);

            entity.ID = Guid.NewGuid().ToString();
            entity.MessageType = (int)Entity.CustomEntity.ConstantEntity.MessageType.ResetPwd;
            entity.SchoolID = base.SchoolID;
            entity.MessageCode = GenerateHelper.GenerateRandomNumber(6);//随机
            entity.GenerateTime = DateTime.Now;
            entity.CreateTime = DateTime.Now;
            entity.UpdateTime = DateTime.Now;
            //调用发送短信接口 

            //获取此模块相关配置信息
            ISys_OtherSysInterfaceAddrService sys_FeatureService = new Sys_OtherSysInterfaceAddrService();
            Sys_OtherSysInterfaceAddr sys_FeatureEntity = sys_FeatureService.GetEntityByColNameAndColValue("ID", "VenusoftShortMessage");

            //数据来源
            if (sys_FeatureEntity != null)
            {
                //参数
                List<Sys_ContactUsers> mobileList = new List<Sys_ContactUsers>();


                Sys_ContactUsers mobile = new Sys_ContactUsers();
                mobile.UserName = entity.MobileNumber;
                mobile.MobilePhone = entity.MobileNumber;
                mobileList.Add(mobile);


                Dictionary<string, List<Sys_ContactUsers>> mobileUsers = new Dictionary<string, List<Sys_ContactUsers>>();
                mobileUsers.Add("List", mobileList);

                //构造参数 
                List<object> lstContent = new List<object>();
                lstContent.Add(JsonConvert.SerializeObject(mobileUsers));//手机列表

                ISys_ConfigService configService = new Sys_ConfigService(entity.SchoolID);
                Sys_Config configEntity = configService.GetEntityByColNameAndColValue("ID", ConstantEntity.ResetPasswordCodeMessageKey);
                if (configEntity != null)
                {
                    lstContent.Add(configEntity.Value.Replace(ConstantEntity.MessageKeyword, entity.MessageCode));//内容
                }
                else
                {
                    throw new Exception("修改密码短信模版未配置");
                }
                lstContent.Add(ConstantEntity.SystemSchoolID); //学校id
                Message_SchoolKeys keys = new Message_SchoolKeysService().GetEntityByColNameAndColValue("SchoolID", ConstantEntity.SystemSchoolID);
                if (keys != null)
                {
                    lstContent.Add(keys.SchoolKey); //学校密钥
                }
                else
                {
                    throw new Exception("未配置venusoft用户的短信密钥");

                }

                //开始访问

                WebServiceProxy wsd = new WebServiceProxy(sys_FeatureEntity.URL, sys_FeatureEntity.DataWebServiceMethod);
                object returnVal = wsd.ExecuteQuery(sys_FeatureEntity.DataWebServiceMethod, lstContent.ToArray());

            }
            else
            {
                throw new Exception("未配置短信发送接口");
            }

            return subRepository.Insert(entity);
        }
        public Message_RegisterMobile GenReBindMobileOldMobileCode(Message_RegisterMobile entity)
        {
            //先删除此手机号下的所有验证码
            subRepository.DeleteMessageCodeByMobileNumber(entity.MobileNumber);
            entity.ID = Guid.NewGuid().ToString();
            entity.MessageType = (int)Entity.CustomEntity.ConstantEntity.MessageType.ReBindMobile;
            entity.SchoolID = base.SchoolID;
            entity.MessageCode = GenerateHelper.GenerateRandomNumber(6);//随机
            entity.GenerateTime = DateTime.Now;
            entity.CreateTime = DateTime.Now;
            entity.UpdateTime = DateTime.Now;
            //调用发送短信接口 

            //获取此模块相关配置信息
            ISys_OtherSysInterfaceAddrService sys_FeatureService = new Sys_OtherSysInterfaceAddrService();
            Sys_OtherSysInterfaceAddr sys_FeatureEntity = sys_FeatureService.GetEntityByColNameAndColValue("ID", "VenusoftShortMessage");

            //数据来源
            if (sys_FeatureEntity != null)
            {
                //参数
                List<Sys_ContactUsers> mobileList = new List<Sys_ContactUsers>();

                Sys_ContactUsers mobile = new Sys_ContactUsers();
                mobile.UserName = entity.MobileNumber;
                mobile.MobilePhone = entity.MobileNumber;
                mobileList.Add(mobile);


                Dictionary<string, List<Sys_ContactUsers>> mobileUsers = new Dictionary<string, List<Sys_ContactUsers>>();
                mobileUsers.Add("List", mobileList);

                //构造参数 
                List<object> lstContent = new List<object>();
                lstContent.Add(JsonConvert.SerializeObject(mobileUsers));//手机列表

                ISys_ConfigService configService = new Sys_ConfigService(entity.SchoolID);
                Sys_Config configEntity = configService.GetEntityByColNameAndColValue("ID", ConstantEntity.RebindMobileOldCodeMessage);
                if (configEntity != null)
                {
                    lstContent.Add(configEntity.Value.Replace(ConstantEntity.MessageKeyword, entity.MessageCode));//内容
                }
                else
                {
                    throw new Exception("重新绑定手机原手机验证码短信模版");
                }
                lstContent.Add(ConstantEntity.SystemSchoolID); //学校id
                Message_SchoolKeys keys = new Message_SchoolKeysService().GetEntityByColNameAndColValue("SchoolID", ConstantEntity.SystemSchoolID);
                if (keys != null)
                {
                    lstContent.Add(keys.SchoolKey); //学校密钥
                }
                else
                {
                    throw new Exception("未配置venusoft用户的短信密钥");

                }

                //开始访问

                WebServiceProxy wsd = new WebServiceProxy(sys_FeatureEntity.URL, sys_FeatureEntity.DataWebServiceMethod);
                object returnVal = wsd.ExecuteQuery(sys_FeatureEntity.DataWebServiceMethod, lstContent.ToArray());

            }
            else
            {
                throw new Exception("未配置短信发送接口");
            }

            return subRepository.Insert(entity);
        }
        public Message_RegisterMobile GenReBindMobileNewMobileCode(Message_RegisterMobile entity)
        {
            //先删除此手机号下的所有验证码
            subRepository.DeleteMessageCodeByMobileNumber(entity.MobileNumber);
            entity.ID = Guid.NewGuid().ToString();
            entity.MessageType = (int)Entity.CustomEntity.ConstantEntity.MessageType.ReBindMobile;
            entity.SchoolID = base.SchoolID;
            entity.MessageCode = GenerateHelper.GenerateRandomNumber(6);//随机
            entity.GenerateTime = DateTime.Now;
            entity.CreateTime = DateTime.Now;
            entity.UpdateTime = DateTime.Now;
            //调用发送短信接口 

            //获取此模块相关配置信息
            ISys_OtherSysInterfaceAddrService sys_FeatureService = new Sys_OtherSysInterfaceAddrService();
            Sys_OtherSysInterfaceAddr sys_FeatureEntity = sys_FeatureService.GetEntityByColNameAndColValue("ID", "VenusoftShortMessage");

            //数据来源
            if (sys_FeatureEntity != null)
            {
                //参数
                List<Sys_ContactUsers> mobileList = new List<Sys_ContactUsers>();

                Sys_ContactUsers mobile = new Sys_ContactUsers();
                mobile.UserName = entity.MobileNumber;
                mobile.MobilePhone = entity.MobileNumber;
                mobileList.Add(mobile);


                Dictionary<string, List<Sys_ContactUsers>> mobileUsers = new Dictionary<string, List<Sys_ContactUsers>>();
                mobileUsers.Add("List", mobileList);

                //构造参数 
                List<object> lstContent = new List<object>();
                lstContent.Add(JsonConvert.SerializeObject(mobileUsers));//手机列表

                ISys_ConfigService configService = new Sys_ConfigService(entity.SchoolID);
                Sys_Config configEntity = configService.GetEntityByColNameAndColValue("ID", ConstantEntity.RebindMobileNewCodeMessage);
                if (configEntity != null)
                {
                    lstContent.Add(configEntity.Value.Replace(ConstantEntity.MessageKeyword, entity.MessageCode));//内容
                }
                else
                {
                    throw new Exception("重新绑定手机新手机验证码短信模版");
                }
                lstContent.Add(ConstantEntity.SystemSchoolID); //学校id
                Message_SchoolKeys keys = new Message_SchoolKeysService().GetEntityByColNameAndColValue("SchoolID", ConstantEntity.SystemSchoolID);
                if (keys != null)
                {
                    lstContent.Add(keys.SchoolKey); //学校密钥
                }
                else
                {
                    throw new Exception("未配置venusoft用户的短信密钥");

                }

                //开始访问

                WebServiceProxy wsd = new WebServiceProxy(sys_FeatureEntity.URL, sys_FeatureEntity.DataWebServiceMethod);
                object returnVal = wsd.ExecuteQuery(sys_FeatureEntity.DataWebServiceMethod, lstContent.ToArray());

            }
            else
            {
                throw new Exception("未配置短信发送接口");
            }

            return subRepository.Insert(entity);
        }
        /// <summary>
        /// 生成注册短信验证码并推送
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public Message_RegisterMobile GenerateBindMobileCode(Message_RegisterMobile entity)
        {
            //先检查此手机号是否注册过用户
            ISys_UserService userService = new Sys_UserService(entity.SchoolID);
            Sys_User userEntity = userService.GetEntityByColNameAndColValue("LoginID", entity.MobileNumber);
            if (userEntity == null)
            {
                //先删除此手机号下的所有验证码
                subRepository.DeleteMessageCodeByMobileNumber(entity.MobileNumber);

                entity.ID = Guid.NewGuid().ToString();
                entity.SchoolID = base.SchoolID;
                entity.MessageType = (int)Entity.CustomEntity.ConstantEntity.MessageType.Register;
                entity.MessageCode = GenerateHelper.GenerateRandomNumber(6);//随机
                entity.GenerateTime = DateTime.Now;
                entity.CreateTime = DateTime.Now;
                entity.UpdateTime = DateTime.Now;


                //调用发送短信接口 

                //获取此模块相关配置信息
                ISys_OtherSysInterfaceAddrService sys_FeatureService = new Sys_OtherSysInterfaceAddrService();
                Sys_OtherSysInterfaceAddr sys_FeatureEntity = sys_FeatureService.GetEntityByColNameAndColValue("ID", "VenusoftShortMessage");

                //数据来源
                if (sys_FeatureEntity != null)
                {
                    //参数
                    List<Sys_ContactUsers> mobileList = new List<Sys_ContactUsers>();


                    Sys_ContactUsers mobile = new Sys_ContactUsers();
                    mobile.UserName = entity.MobileNumber;
                    mobile.MobilePhone = entity.MobileNumber;
                    mobileList.Add(mobile);


                    Dictionary<string, List<Sys_ContactUsers>> mobileUsers = new Dictionary<string, List<Sys_ContactUsers>>();
                    mobileUsers.Add("List", mobileList);

                    //构造参数 
                    List<object> lstContent = new List<object>();
                    lstContent.Add(JsonConvert.SerializeObject(mobileUsers));//手机列表

                    ISys_ConfigService configService = new Sys_ConfigService(entity.SchoolID);
                    Sys_Config configEntity = configService.GetEntityByColNameAndColValue("ID", ConstantEntity.RegistCodeMessageKey);
                    if (configEntity != null)
                    {
                        lstContent.Add(configEntity.Value.Replace(ConstantEntity.MessageKeyword, entity.MessageCode));//内容
                    }
                    else
                    {
                        throw new Exception("注册短信模版未配置");
                    }
                    lstContent.Add(ConstantEntity.SystemRegistUserSchoolID); //学校id
                    Message_SchoolKeys keys = new Message_SchoolKeysService().GetEntityByColNameAndColValue("SchoolID", ConstantEntity.SystemRegistUserSchoolID);
                    if (keys != null)
                    {
                        lstContent.Add(keys.SchoolKey); //学校密钥
                    }
                    else
                    {
                        throw new Exception("未配置venusoftregist用户的短信密钥");

                    }

                    //开始访问

                    WebServiceProxy wsd = new WebServiceProxy(sys_FeatureEntity.URL, sys_FeatureEntity.DataWebServiceMethod);
                    object returnVal = wsd.ExecuteQuery(sys_FeatureEntity.DataWebServiceMethod, lstContent.ToArray());

                }
                else
                {
                    throw new Exception("未配置短信发送接口");
                }

                return subRepository.Insert(entity);
            }
            else
            {
                throw new Exception("此手机号已注册");
            }
        }
         
        /// <summary>
        /// 验证短信验证码
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public bool VerifyMobileCode(Message_RegisterMobile entity)
        {
            bool result = false;
            PageHelper<Message_RegisterMobile> page = new PageHelper<Message_RegisterMobile>();

            page.QueryKeyValues.Add(new KeyValue("MobileNumber", entity.MobileNumber));
            page.QueryKeyValues.Add(new KeyValue("MessageCode", entity.MessageCode));
            page.QueryKeyValues.Add(new KeyValue("SchoolID", entity.SchoolID));

            page.OrderBy = " GenerateTime desc ";
            Message_RegisterMobile resultEntity = subRepository.GetListPage(page).Data.FirstOrDefault();
            if (resultEntity != null)
            {
                TimeSpan ts = DateTime.Now - resultEntity.GenerateTime;
                if (ts.TotalMinutes <= 30)
                {
                    if (!resultEntity.IsVerify.HasValue || resultEntity.IsVerify.Value != 1)
                    {
                        resultEntity.IsVerify = 1;
                        subRepository.Update(resultEntity);
                        result = true;
                    }
                }
            }
            return result;
        }

        /// <summary>
        /// 获取最后一次的短信验证码
        /// </summary>
        /// <param name="mobileNumber"></param>
        /// <returns></returns>
        public Message_RegisterMobile GetLastMessageByMobileNumber(string mobileNumber)
        {
            PageHelper<Message_RegisterMobile> page = new PageHelper<Message_RegisterMobile>();

            page.QueryKeyValues.Add(new KeyValue("MobileNumber", mobileNumber));
            page.QueryKeyValues.Add(new KeyValue("SchoolID", base.SchoolID));

            page.OrderBy = " GenerateTime desc ";
            return subRepository.GetListPage(page).Data.FirstOrDefault();

        }


    }

}
