using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;
using System.IO;

namespace BizProcess.Interface
{
    public interface ISys_UserService : IBaseService<Sys_User>
    {
        /// <summary>
        /// 检查登入
        /// </summary>
        /// <returns></returns>
        Sys_User CheckLogin(string loginID, string password);

        /// <summary>
        /// 添加学生根据手机号，要检查是否通过验证码
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        Basic_Student RegisterStudentByMobile(Basic_Student entity);

        /// <summary>
        /// 修改密码
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        bool ResetPassword(Sys_User user);
        /// <summary>
        /// 根据手机号修改密码
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        bool ResetPasswordByMobileNumber(Sys_User user);

        /// <summary>
        ///  添加或更新
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        Sys_User InsertOrUpdate(Sys_User entity);
        /// <summary>
        /// 更新用户名密码
        /// </summary>
        /// <param name="oldPwd"></param>
        /// <param name="newPwd"></param>
        /// <returns></returns>
        bool UpdatePwd(string userID, string oldPwd, string newPwd);
        /// <summary>
        /// 根据角色id获取用户列表，包含其他信息，如此用户是否属于当前角色id
        /// </summary>
        /// <param name="pageQuery"></param>
        /// <returns></returns>

        OurHelper.PageHelper<Sys_User> GetPageListAllUserRoleInfoByRoleID(OurHelper.PageHelper<Sys_User> pageQuery);
        /// <summary>
        /// 更新头像
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="imageContent"></param>
        /// <returns></returns>
        string UpdateHeaderImage(string userID, string fileName, Stream imageContent);

        /// <summary>
        /// 更新用户信息，如果是教师用户则更新教师基本信息，如果是学生怎更新学生信息
        /// </summary>
        /// <param name="user"></param>
        /// <param name="teacher"></param>
        /// <param name="student"></param>
        /// <returns></returns>
        bool UpdateUserInfo(Sys_User user, Basic_TeacherInfo teacher, Basic_Student student);


        /// <summary>
        /// 获取二维码地址
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        string GetQRCodeUrlByUserID(string userID);

        /// <summary>
        /// 修改手机号，验证老手机验证码
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="code"></param>
        /// <returns></returns>
        bool ValidateChangePhoneNumberOldPhoneCode(string userID, string code);

        /// <summary>
        /// 修改手机号，验证新手机号验证码
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="code"></param>
        /// <returns></returns>
        bool ValidateChangePhoneNumberNewPhoneCode(string userID,string mobileNumber, string code);
    }
}
