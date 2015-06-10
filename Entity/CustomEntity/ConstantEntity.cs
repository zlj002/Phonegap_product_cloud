using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;

namespace Entity.CustomEntity
{
    public class ConstantEntity
    {
        /// <summary>
        /// 数据来源
        /// </summary>
        public enum DataResourceType
        {
            [Description("WebService接口")]
            WebService = 1,
            [Description("中间表")]
            DataTable = 2
        }
        /// <summary>
        /// 访问结果标志
        /// </summary>
        public enum ReturnFlag
        {
            [Description("成功")]
            Success = 1,
            [Description("失败")]
            Failed = 0
        }

        /// <summary>
        /// 功能点可选配置固定值
        /// </summary>
        public enum FeatureConfig
        {
            [Description("密码加密")]
            PasswordEncrypt
        }

        /// <summary>
        /// 加密方法名称
        /// </summary>
        public enum EncryptMethod
        {
            [Description("MD5")]
            MD5
        }

        /// <summary>
        /// 操作结果
        /// </summary>
        public enum OperationStatus
        {
            [Description("成功")]
            Success = 1,
            [Description("失败")]
            Failed = 0
        }

        /// <summary>
        /// 数据状态
        /// </summary>
        public enum DataStatus
        {
            [Description("有效")]
            Valid = 1,
            [Description("已删除")]
            Deleted = 0,
            [Description("已锁定")]
            Locked = 2,
        }

        /// <summary>
        /// 用户类型
        /// </summary>
        public enum UserType
        {
            [Description("教师")]
            Teacher = 0,
            [Description("学生")]
            Student = 1,
            [Description("家长")]
            Guardian = 2,
            [Description("企业")]
            EnterpriseUser = 3,
        }


        /// <summary>
        /// 应用id
        /// </summary>
        public enum FeatureIDs
        {
            awardList,//奖励列表
            awardDetail,//奖励明细
            semesterList2,//
        }

        /// <summary>
        /// 系统内置用户
        /// </summary>
        public enum VenusoftUsers
        {
            [Description("系统内置帐号用于消息推送")]
            SystemUserNO
        }

        /// <summary>
        /// 软件信息
        /// </summary>
        public enum SoftInfo
        {
            [Description("系统内置默认学校标识")]
            DefaultSchoolID
        }

        /// <summary>
        /// 老师默认密码
        /// </summary>
        public static string TeacherDefaultPWD = "123";

        /// <summary>
        /// 学生默认密码
        /// </summary>
        public static string StudentDefaultPWD = "8888";

        /// <summary>
        /// 注册用户短消息配置的key值
        /// </summary>
        public static string RegistCodeMessageKey = "registCodeMessage";
        public static string ResetPasswordCodeMessageKey = "resetPasswordCodeMessage";
        public static string RebindMobileOldCodeMessage = "rebindMobileOldCodeMessage";
        public static string RebindMobileNewCodeMessage = "rebindMobileNewCodeMessage";

        
        /// <summary>
        /// 注册用户短消息模版中的关键字
        /// </summary>
        public static string MessageKeyword = "[code]";

        /// <summary>
        /// 系统学校id专门为短信发送，或者其他默认学校业务时建立的学校信息
        /// </summary>
        public static string SystemSchoolID = "venusoft";

        /// <summary>
        /// 专门为注册时短信发送使用的schoolid建立了一个学校信息
        /// </summary>
        public static string SystemRegistUserSchoolID = "venusoftregist";

        /// <summary>
        /// 短信类型
        /// </summary>
        public enum MessageType
        {
            [Description("注册短信通知")]
            Register = 0,
            [Description("重置密码短信通知")]
            ResetPwd = 1,
            [Description("更换手机号")]
            ReBindMobile = 2,
        }
        /// <summary>
        /// 二维码类型
        /// </summary>
        public enum VenuSoftCodeType
        {
            [Description("用户信息ID")]
            User
        }
        /// <summary>
        /// 信鸽相关配置
        /// </summary>
        public enum XGApp
        {
            [Description("信鸽android应用ID")]
            xgAndroidAccessId,
            [Description("信鸽android应用密钥")]
            xgAndroidSecretKey,
            [Description("信鸽IOS应用ID")]
            xgIOSAccessId,
            [Description("信鸽IOS应用密钥")]
            xgIOSSecretKey
        }
        /// <summary>
        /// 信鸽相关配置
        /// </summary>
        public enum Aliyun
        {
            [Description("阿里云keyID")]
            aliyunkeyid,
            [Description("阿里云key secret")]
            aliyunkeysecret ,
            [Description("阿里云bucketname")]
            bucketname,
            [Description("图片域地址")]
            imageDomain,
        }
    }
}
