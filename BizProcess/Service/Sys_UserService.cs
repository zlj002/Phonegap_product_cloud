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
using BizProcess.Common.Validate;
using Entity.CustomEntity;
using Aliyun.OpenServices.OpenStorageService;
using Newtonsoft.Json;
using ThoughtWorks.QRCode.Codec;
using System.Drawing;
using System.IO;
using BizProcess.Common.Aliyun;

namespace BizProcess.Service
{
    public class Sys_UserService : BaseService<Sys_User>, ISys_UserService
    {
        ISys_UserRepository subRepository;
        IBasic_TeacherInfoRepository teacherRepository;
        IBasic_StudentRepository studentRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Sys_UserService()
        {
            subRepository = new Sys_UserRepository();
            teacherRepository = new Basic_TeachaerInfoRepository();
            studentRepository = new Basic_StudentRepository();

            base.repository = subRepository;
        }

        /// <summary>
        /// 默认构造
        /// </summary>
        public Sys_UserService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Sys_UserRepository(base.SchoolID);
            teacherRepository = new Basic_TeachaerInfoRepository();
            studentRepository = new Basic_StudentRepository();
            base.repository = subRepository;
        }

        /// <summary>
        /// 登录
        /// </summary>
        /// <param name="loginID"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public Sys_User CheckLogin(string loginID, string password)
        {
            string psd = EncryptHelper.OurEncrypt(password);
            return subRepository.CheckLogin(loginID, psd);
        }

        /// <summary>
        /// 使用验证码新用户注册
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public Basic_Student RegisterStudentByMobile(Basic_Student entity)
        {
            try
            {
                //检验此用户的短信验证码是否通过
                IMessageService mService = new MessageService(entity.SchoolID);
                Message_RegisterMobile message = mService.GetLastMessageByMobileNumber(entity.MobileNumber);
                if (message != null && message.IsVerify == 1 && message.MessageType.HasValue && message.MessageType.Value == (int)Entity.CustomEntity.ConstantEntity.MessageType.Register)
                {
                    //检查用户名是否已存在 
                    Sys_User e = repository.GetEntityByColNameAndColValue("MobileNumber", entity.LoginID);
                    if (e != null)
                    {
                        throw new Exception("手机号已存在");
                    }
                    else
                    {
                        Sys_User user = new Sys_User();
                        user.ID = Guid.NewGuid().ToString();
                        user.LoginID = entity.LoginID;
                        //学生注册时，学生的手机号为登录id
                        user.MobileNumber = entity.LoginID;
                        //学生注册时学生的邮箱默认为ID,避免重复
                        user.Email = user.ID;
                        user.SchoolID = entity.SchoolID;
                        user.UserName = string.Empty;
                        user.PassWord = EncryptHelper.OurEncrypt(entity.PassWord);
                        user.UserType = 1;
                        user.CreateTime = DateTime.Now;
                        user.Status = 1;
                        //创建用户
                        Sys_User rtnUser = subRepository.Insert(user);
                        //创建学生信息
                        entity.ID = rtnUser.ID;
                        entity.SchoolID = base.SchoolID;
                        entity.CreateTime = DateTime.Now;
                        entity.Status = 1;
                        entity = new Basic_StudentService().Insert(entity);
                    }
                }
                else
                {
                    throw new Exception("请通过短信验证码进行注册");
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return entity;
        }

        /// <summary>
        /// 使用短信验证码修改密码
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public bool ResetPassword(Sys_User user)
        {
            bool result = false;
            try
            {
                var userEntity = this.GetEntityByColNameAndColValue("ID", user.ID);
                if (userEntity != null)
                {
                    //默认为手机号为登录名
                    string mobileNumber = userEntity.MobileNumber;


                    //检验此用户的短信验证码是否通过
                    IMessageService mService = new MessageService(userEntity.SchoolID);
                    Message_RegisterMobile message = mService.GetLastMessageByMobileNumber(mobileNumber);
                    if (message != null && message.IsVerify == 1 && message.MessageType.Value == (int)Entity.CustomEntity.ConstantEntity.MessageType.ResetPwd)
                    {
                        userEntity.PassWord = EncryptHelper.OurEncrypt(user.PassWord);
                        userEntity = subRepository.Update(userEntity);
                        result = true;
                    }
                    else
                    {
                        throw new Exception("请通过短信验证码进行修改密码");
                    }
                }
                else
                {
                    throw new Exception("用户不存在");
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return result;
        }

        public bool ResetPasswordByMobileNumber(Sys_User user)
        {
            bool result = false;
            try
            {
                var userEntity = this.GetEntityByColNameAndColValue("LoginID", user.MobileNumber);
                if (userEntity != null)
                {
                    //默认为手机号为登录名
                    string mobileNumber = userEntity.LoginID;

                    //检验此用户的短信验证码是否通过
                    IMessageService mService = new MessageService(userEntity.SchoolID);
                    Message_RegisterMobile message = mService.GetLastMessageByMobileNumber(mobileNumber);
                    if (message != null && message.IsVerify == 1 && message.MessageType.Value == (int)Entity.CustomEntity.ConstantEntity.MessageType.ResetPwd)
                    {
                        userEntity.PassWord = EncryptHelper.OurEncrypt(user.PassWord);
                        userEntity = subRepository.Update(userEntity);
                        result = true;
                    }
                    else
                    {
                        throw new Exception("请通过短信验证码进行修改密码");
                    }
                }
                else
                {
                    throw new Exception("用户不存在");
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return result;
        }


        public bool UpdatePwd(string userID, string oldPwd, string newPwd)
        {
            bool result = false;
            try
            {
                Sys_User e = repository.GetEntityByColNameAndColValue("ID", userID);
                if (e != null)
                {
                    var oldEnPwd = OurHelper.EncryptHelper.OurEncrypt(oldPwd);
                    if (oldEnPwd == e.PassWord)
                    {
                        e.PassWord = OurHelper.EncryptHelper.OurEncrypt(newPwd);
                        repository.Update(e);
                        result = true;
                    }
                    else
                    {
                        throw new Exception("旧密码错误");
                    }
                }
                else
                {
                    throw new Exception("此用户不存在");
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return result;
        }


        public PageHelper<Sys_User> GetPageListAllUserRoleInfoByRoleID(PageHelper<Sys_User> pageQuery)
        {
            return subRepository.GetPageListAllUserRoleInfoByRoleID(pageQuery);
        }

        public Sys_User InsertOrUpdate(Sys_User entity)
        {
            Sys_User result = null;
            try
            {
                Sys_User e = repository.GetEntityByColNameAndColValue("ID", entity.ID);
                if (e != null)
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Sys_User>(entity, false);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion



                    ///三种登录默认值
                    if (string.IsNullOrEmpty(e.Email))
                    {
                        e.Email = e.ID;
                    }
                    if (string.IsNullOrEmpty(e.MobileNumber))
                    {
                        e.MobileNumber = e.ID;
                    }
                    if (string.IsNullOrEmpty(e.UserAccount))
                    {
                        e.UserAccount = e.ID;
                    }

                    //只更新用户姓名,用户帐号其他信息更新需要另写方法
                    e.UserName = entity.UserName;
                    result = repository.Update(e);
                }
                else
                {
                    entity.ID = Guid.NewGuid().ToString();

                    ///三种登录默认值
                    if (string.IsNullOrEmpty(entity.Email))
                    {
                        entity.Email = entity.ID;
                    }
                    if (string.IsNullOrEmpty(entity.MobileNumber))
                    {
                        entity.MobileNumber = entity.ID;
                    }
                    if (string.IsNullOrEmpty(entity.UserAccount))
                    {
                        entity.UserAccount = entity.ID;
                    }
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Sys_User>(entity, true);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion

                    //默认密码
                    if (string.IsNullOrEmpty(entity.PassWord))
                    {
                        entity.PassWord = OurHelper.EncryptHelper.OurEncrypt(ConstantEntity.TeacherDefaultPWD);
                    }
                    else
                    {
                        entity.PassWord = OurHelper.EncryptHelper.OurEncrypt(entity.PassWord);
                    }
                    //如果未指定用户类型，默认添加老师用户
                    if (!entity.UserType.HasValue)
                    {
                        entity.UserType = (int)ConstantEntity.UserType.Teacher;
                    }
                    entity.CreateTime = DateTime.Now;
                    entity.Status = 1;
                    result = repository.Insert(entity);
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return result;
        }


        public string UpdateHeaderImage(string userID, string fileName, System.IO.Stream imageContent)
        {
            try
            {
                ObjectMetadata meta = new ObjectMetadata();
                meta.ContentType = "image/jpeg";
                string key = "MobileCloud/" + userID + "/HeaderImage/header.jpg";
                var random = Guid.NewGuid().ToString();
                var headerImageUrl = OssHelper.FileToOss(key, imageContent, meta) + "?random=" + random;
                Sys_User e = repository.GetEntityByColNameAndColValue("ID", userID);
                if (e != null)
                {
                    e.HeaderImage = headerImageUrl;
                    repository.Update(e);
                }
                else
                {
                    throw new Exception("此用户不存在");
                }
                return headerImageUrl;
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        public bool UpdateUserInfo(Sys_User user, Basic_TeacherInfo teacher, Basic_Student student)
        {
            var oldUser = subRepository.GetEntityByColNameAndColValue("ID", user.ID);
            if (oldUser != null)
            {
                //用户可更新的字段
                //昵称
                oldUser.UserName = user.UserName;
                this.subRepository.Update(oldUser);
                //老师可以更新字段
                if (oldUser.UserType == (int)ConstantEntity.UserType.Teacher)
                {
                    var oldTeacher = teacherRepository.GetEntityByColNameAndColValue("ID", user.ID);
                    oldTeacher.Name = teacher.Name;
                    oldTeacher.Sex = teacher.Sex;
                    oldTeacher.Birthday = teacher.Birthday;
                    oldTeacher.NativePlace = teacher.NativePlace;
                    oldTeacher.RecentActivities = teacher.RecentActivities;
                    oldTeacher.ILike = teacher.ILike;
                    oldTeacher.PersonalSign = teacher.PersonalSign;
                    teacherRepository.Update(oldTeacher);
                }
                else if (oldUser.UserType == (int)ConstantEntity.UserType.Student)
                {
                    var oldStudent = studentRepository.GetEntityByColNameAndColValue("ID", user.ID);
                    oldStudent.Name = student.Name;
                    oldStudent.Sex = student.Sex;
                    oldStudent.Birthday = student.Birthday;
                    oldStudent.NativePlace = student.NativePlace;
                    oldStudent.RecentActivities = student.RecentActivities;
                    oldStudent.ILike = student.ILike;
                    oldStudent.PersonalSign = student.PersonalSign;

                    //学历
                    oldStudent.Education = student.Education;
                    //专业
                    oldStudent.SpecialtyID = student.SpecialtyID;
                    //入学年份
                    oldStudent.StartYear = student.StartYear;
                    //班级
                    oldStudent.ClassID = student.ClassID;
                    //宿舍
                    oldStudent.Dormitory = student.Dormitory;
                    studentRepository.Update(student);
                }
                return true;
            }
            else
            {
                throw new Exception("没有此用户");
            }
        }


        public string GetQRCodeUrlByUserID(string userID)
        {
            var resultUrl = string.Empty;
            Sys_User e = repository.GetEntityByColNameAndColValue("ID", userID);
            if (e != null)
            {
                resultUrl = e.QRCode;
                //如果用户没有二维码
                if (string.IsNullOrEmpty(resultUrl))
                {
                    //logo url 
                    var logoUrl = "/publicModule/images/logo.png";

                    string dir = "/Upload/Attachment/QRCode";
                    string relativePath = dir + "/QR_" + userID + ".png";
                    //如果二维码文件在当前服务器不存在，先生成然后上传至阿里云
                    if (!File.Exists(System.Web.HttpContext.Current.Server.MapPath(relativePath)))
                    {
                        //上传至阿里云
                        var temp = new
                        {
                            userID
                        };

                        string content = JsonConvert.SerializeObject(temp);

                        QRCodeEncoder qrCodeEncoder = new QRCodeEncoder();
                        qrCodeEncoder.QRCodeEncodeMode = QRCodeEncoder.ENCODE_MODE.BYTE;
                        qrCodeEncoder.QRCodeScale = 4;
                        qrCodeEncoder.QRCodeVersion = 8;
                        qrCodeEncoder.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.M;
                        Bitmap image = qrCodeEncoder.Encode(content);
                        System.IO.MemoryStream MStream = new System.IO.MemoryStream();
                        image.Save(MStream, System.Drawing.Imaging.ImageFormat.Png);

                        System.IO.MemoryStream MStream1 = new System.IO.MemoryStream();
                        ImageHelper.CombinImage(image, System.Web.HttpContext.Current.Server.MapPath(logoUrl)).Save(MStream1, System.Drawing.Imaging.ImageFormat.Png);
                        FileStream fsForWrite = new FileStream(System.Web.HttpContext.Current.Server.MapPath(relativePath), FileMode.CreateNew);
                        try
                        {
                            byte[] b = MStream1.GetBuffer();
                            //写入一个字节 
                            fsForWrite.Write(b, 0, b.Length);
                        }
                        catch (Exception ex)
                        {

                        }
                        finally
                        {
                            //关闭文件        
                            fsForWrite.Close();
                            //image.Dispose();
                            MStream.Dispose();
                            MStream1.Dispose();
                        }
                    }
                    //上传至阿里云
                    try
                    {

                        ObjectMetadata meta = new ObjectMetadata();
                        meta.ContentType = "image/jpeg";
                        string key = "MobileCloud/" + userID + "/QRCode/qrcode.jpg";
                        // 打开文件 
                        FileStream fileStream = new FileStream(System.Web.HttpContext.Current.Server.MapPath(relativePath), FileMode.Open, FileAccess.Read, FileShare.Read);
                        // 读取文件的 byte[] 
                        byte[] bytes = new byte[fileStream.Length];
                        fileStream.Read(bytes, 0, bytes.Length);
                        fileStream.Close();
                        // 把 byte[] 转换成 Stream 
                        Stream imageContent = new MemoryStream(bytes);
                        var random = Guid.NewGuid().ToString();
                        e.QRCode = OssHelper.FileToOss(key, imageContent, meta) + "?random=" + random;
                        repository.Update(e);
                        resultUrl = e.QRCode;
                    }
                    catch (Exception ex)
                    {
                        throw new Exception(ex.Message);
                    }

                }
            }
            else
            {
                throw new Exception("此用户不存在");
            }
            return resultUrl;
        }


        public bool ValidateChangePhoneNumberOldPhoneCode(string userID, string code)
        {
            var result = false;
            try
            {
                Sys_User e = repository.GetEntityByColNameAndColValue("ID", userID);
                if (e != null)
                {
                    //检验此用户的短信验证码是否通过
                    IMessageService mService = new MessageService(e.SchoolID);
                    Message_RegisterMobile message = mService.GetLastMessageByMobileNumber(e.MobileNumber);
                    if (message != null && message.MessageType.HasValue && message.MessageType.Value == (int)Entity.CustomEntity.ConstantEntity.MessageType.ReBindMobile)
                    {
                        message.IsVerify = 1;
                        mService.Update(message);
                        result = true;
                    }
                }
                else
                {
                    throw new Exception("此用户不存在");
                }

            }
            catch (Exception ee)
            {
                throw new Exception(ee.Message);
            }
            return result;
        }


        public bool ValidateChangePhoneNumberNewPhoneCode(string userID, string mobileNumber, string code)
        {
            var result = false;
            try
            {
                Sys_User e = repository.GetEntityByColNameAndColValue("ID", userID);
                if (e != null)
                {
                    //检验此用户的短信验证码是否通过
                    IMessageService mService = new MessageService(e.SchoolID);
                    Message_RegisterMobile message = mService.GetLastMessageByMobileNumber(mobileNumber);
                    if (message != null && message.MessageType.HasValue && message.MessageType.Value == (int)Entity.CustomEntity.ConstantEntity.MessageType.ReBindMobile)
                    {
                        //检查新号码是否被其他人占用
                        Sys_User checkUser = repository.GetEntityByColNameAndColValue("MobileNumber", mobileNumber);
                        if (checkUser != null)
                        {
                            throw new Exception("此手机号已被注册请更换");
                        }

                        e.LoginID = mobileNumber;
                        e.MobileNumber = mobileNumber;
                        subRepository.Update(e);
                        //如果是老师，则更新老师详细资料中的手机号
                        //如果是学生，则更新学生详细资料中的手机号
                        if (e.UserType == (int)ConstantEntity.UserType.Teacher)
                        {
                            IBasic_TeacherManagerService tService = new Basic_TeacherManagerService();
                            var teacher = tService.GetEntityByColNameAndColValue("ID", userID);
                            if (teacher != null)
                            {
                                teacher.MobileNumber = mobileNumber;
                                tService.Update(teacher);
                            }
                        }
                        else if (e.UserType == (int)ConstantEntity.UserType.Student)
                        {
                            IBasic_StudentService sService = new Basic_StudentService();
                            var student = sService.GetEntityByColNameAndColValue("ID", userID);
                            if (student != null)
                            {
                                student.MobileNumber = mobileNumber;
                                sService.Update(student);
                            }
                        }
                        result = true;
                    }
                }
                else
                {
                    throw new Exception("此用户不存在");
                }
            }
            catch (Exception ee)
            {
                throw new Exception(ee.Message);
            }
            return result;

        }

    }
}
