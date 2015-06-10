using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;

namespace BizProcess.Interface
{
    public interface IMessageService : IBaseService<Message_RegisterMobile>
    {
        /// <summary>
        /// 生成随机的短信验证码并保存到数据库中
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        Message_RegisterMobile GenerateBindMobileCode(Message_RegisterMobile entity);

        /// <summary>
        /// 验证短信验证码是否通过
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        bool VerifyMobileCode(Message_RegisterMobile entity);

        /// <summary>
        /// 根据手机号，获取最后一次注册短信内容，以在注册时检查是否正常验证通过
        /// </summary>
        /// <param name="mobileNumber"></param>
        /// <returns></returns>
        Message_RegisterMobile GetLastMessageByMobileNumber(string mobileNumber);

        /// <summary>
        /// 修改密码时生成随机验证码
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        Message_RegisterMobile GenResetPasswordMobileCode(Message_RegisterMobile entity);


        /// <summary>
        /// 重新绑定手机号生成原手机号验证码
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        Message_RegisterMobile GenReBindMobileOldMobileCode(Message_RegisterMobile entity);


        /// <summary>
        /// 重新绑定手机号生成新手机号验证码
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        Message_RegisterMobile GenReBindMobileNewMobileCode(Message_RegisterMobile entity);
    }
}
