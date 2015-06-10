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
using XinGePushSDK.NET;
using Entity.CustomEntity;

namespace BizProcess.Service
{
    public class Sys_PushMessageService : BaseService<Sys_PushMessage>, ISys_PushMessageService
    {
        ISys_PushMessageRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Sys_PushMessageService()
        {
            subRepository = new Sys_PushMessageRepository();
            base.repository = subRepository;
        }
        private XingeApp InitAndroidXG()
        {
            string androidAccessID = string.Empty;
            ISys_ConfigService configService = new Sys_ConfigService();
            Sys_Config configEntity = configService.GetEntityByColNameAndColValue("ID", ConstantEntity.XGApp.xgAndroidAccessId.ToString());
            if (configEntity != null)
            {
                androidAccessID = configEntity.Value;

            }
            else
            {
                throw new Exception("信鸽android版AccessID未配置");
            }

            string androidSecretKey = string.Empty;
            configEntity = configService.GetEntityByColNameAndColValue("ID", ConstantEntity.XGApp.xgAndroidSecretKey.ToString());
            if (configEntity != null)
            {
                androidSecretKey = configEntity.Value;

            }
            else
            {
                throw new Exception("信鸽android版密钥未配置");
            }
            return new XingeApp(androidAccessID, androidSecretKey);
        }
        private XingeApp InitIOSXG()
        {
            string iosAccessID = string.Empty;
            ISys_ConfigService configService = new Sys_ConfigService();
            Sys_Config configEntity = configService.GetEntityByColNameAndColValue("ID", ConstantEntity.XGApp.xgIOSAccessId.ToString());
            if (configEntity != null)
            {
                iosAccessID = configEntity.Value;

            }
            else
            {
                throw new Exception("信鸽IOS版密钥未配置");
            }

            string iosSecretKey = string.Empty;
            configEntity = configService.GetEntityByColNameAndColValue("ID", ConstantEntity.XGApp.xgIOSSecretKey.ToString());
            if (configEntity != null)
            {
                iosSecretKey = configEntity.Value;

            }
            else
            {
                throw new Exception("信鸽IOS版密钥未配置");
            }
            return new XingeApp(iosAccessID, iosSecretKey);
        }

        public int PushToAccount(Sys_PushMessage message)
        {
            int result = 0;
            try
            {
                Dictionary<string, object> customContext = new Dictionary<string, object>();
                if (!string.IsNullOrEmpty(message.FeatureID))
                {
                    customContext.Add("FeatureID", message.FeatureID);
                }
                if (!string.IsNullOrEmpty(message.Url))
                {
                    customContext.Add("Url", message.Url);
                }
                if (!string.IsNullOrEmpty(message.Title))
                {
                    customContext.Add("Title", message.Title);
                }

                //信鸽android
                XingeApp androidPush = InitAndroidXG();
                Msg_Android mandroid = new Msg_Android_Info(message.Title, XinGeConfig.message_type_info)
                {
                    content = message.Content,
                    custom_content = customContext
                };
                //Push消息（包括通知和透传消息）给单个账户或别名
                XinGePushSDK.NET.Res.Ret ret = androidPush.PushToAccount(message.UserID, mandroid);
                result = ret.ret_code;
                message.PushID = Guid.NewGuid().ToString();
                base.Insert(message);
                //apple apns 
                Payload pl = new Payload(message.Title) { 
                    alert = message.Title,
                    badge = 1,
                    sound = "default"
                }; 
                XingeApp iosPush = InitIOSXG();
                Msg_IOS mios = new Msg_IOS(pl)
                { 
                    custom_content = customContext, 
                    
                };

                iosPush.PushToAccount(message.UserID, mios, XinGeConfig.IOSENV_DEV);
            }
            catch (Exception e)
            {
                throw e;
            }
            return result;
        }


        public int PushToAll(Sys_PushMessage message)
        {
            int result = 0;
            try
            {
                Dictionary<string, object> customContext = new Dictionary<string, object>();
                if (!string.IsNullOrEmpty(message.FeatureID))
                {
                    customContext.Add("FeatureID", message.FeatureID);
                }
                if (!string.IsNullOrEmpty(message.Url))
                {
                    customContext.Add("Url", message.Url);
                }
                //信鸽android
                XingeApp androidPush = InitAndroidXG();
                Msg_Android mandroid = new Msg_Android_Info(message.Title, XinGeConfig.message_type_info)
                {
                    content = message.Content,
                    custom_content = customContext
                };

                //Push消息（包括通知和透传消息）给全部
                XinGePushSDK.NET.Res.Ret ret = androidPush.PushAllDevice(mandroid);

                result = ret.ret_code;
                //Payload pl = new Payload("这是一个简单的alert");
                //Msg_IOS mios = new Msg_IOS(pl); 

                //xinge.PushToAccount("account", mios, XinGeConfig.IOSENV_DEV);
            }
            catch (Exception e)
            {
                throw e;
            }
            return result;
        }


        public List<Sys_PushMessage> GetBadgeCountByUserID(string userID)
        {
            return subRepository.GetBadgeCountByUserID(userID);
        }

        public int DeleteBadgeByUserIDAndFeatureID(string userID, string featureID)
        {
            Dictionary<string, object> dic = new Dictionary<string, object>();
            dic.Add("UserID", userID);
            dic.Add("FeatureID", featureID);
            return subRepository.DelEntityByColNamesAndColValues(dic);
        }
    }
}
