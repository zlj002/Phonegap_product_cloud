using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using BizProcess.Interface;
using BizProcess.Base.Service;
using DataAccess.Repository;
using DataAccess.Interface;
using BizProcess.Common.Validate;
using System.Transactions;
namespace BizProcess.Service
{
    public class Basic_TeacherManagerService : BaseService<Basic_TeacherInfo>, IBasic_TeacherManagerService
    {
        IBasic_TeacherInfoRepository subRepository;
        public Basic_TeacherManagerService()
        {

            subRepository = new Basic_TeachaerInfoRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 添加或更新
        /// </summary>
        /// <param name="entity">对象实例</param>
        /// <returns></returns>
        public Basic_TeacherInfo InsertOrUpdate(Basic_TeacherInfo entity)
        {
            Basic_TeacherInfo oldEntity = null;
            try
            {
                using (TransactionScope transcope = new TransactionScope())
                {
                    if (string.IsNullOrEmpty(entity.MobileNumber))
                    {
                        throw new Exception("手机号必填");
                    }

                    Basic_TeacherInfo e = repository.GetEntityByColNameAndColValue("ID", entity.ID);
                    if (e != null)
                    {


                        var validate = repository.GetEntityByColNameAndColValue("MobileNumber", entity.MobileNumber);
                        if (validate != null && validate.ID != entity.ID)
                        {
                            throw new Exception("手机号已存在请更换");
                        }
                        validate = repository.GetEntityByColNameAndColValue("EmployeeID", entity.EmployeeID);
                        if (validate != null && validate.ID != entity.ID && validate.Sys_User.SchoolID == entity.SchoolID)
                        {
                            throw new Exception("职工号已存在请更换");
                        }

                        #region 数据验证
                        string valResult = ValidateHelper.ValidateObject<Basic_TeacherInfo>(entity, false);
                        if (!string.IsNullOrEmpty(valResult))
                        {
                            throw new Exception(valResult);
                        }
                        #endregion
                        //处理需要更新的字段  
                        e.EmployeeID = entity.EmployeeID;
                        e.Name = entity.Name;
                        e.Sex = entity.Sex;
                        e.Healthy = entity.Healthy;
                        e.Telephone = entity.Telephone;
                        e.ZipCode = entity.ZipCode;
                        e.Email = entity.Email;
                        e.PostalAddress = entity.PostalAddress;
                        e.HomeAddress = entity.HomeAddress;
                        e.JobType = entity.JobType;
                        e.TeachingType = entity.TeachingType;
                        e.TeacherProperty = entity.TeacherProperty;
                        e.Education = entity.Education;
                        e.Degree = entity.Degree;
                        e.FirstLanguage = entity.FirstLanguage;
                        e.FirstExtent = entity.FirstExtent;
                        e.SecondLanguage = entity.SecondLanguage;
                        e.SecondExtent = entity.SecondExtent;
                        e.TeachSpecialty = entity.TeachSpecialty;
                        e.Discipline = entity.Discipline;
                        e.Certificate1 = entity.Certificate1;
                        e.Level1 = entity.Level1;
                        e.GetDate1 = entity.GetDate1;
                        e.Certificate2 = entity.Certificate2;
                        e.Level2 = entity.Level2;
                        e.GetDate2 = entity.GetDate2;
                        e.Certificate3 = entity.Certificate3;
                        e.Level3 = entity.Level3;
                        e.GetDate3 = entity.GetDate3;
                        e.TechnicalTitle = entity.TechnicalTitle;
                        e.TechnicalGetDate = entity.TechnicalGetDate;
                        e.WorkYears = entity.WorkYears;
                        e.ManagerYears = entity.ManagerYears;
                        e.Certificate4 = entity.Certificate4;
                        e.Level4 = entity.Level4;
                        e.GetDate4 = entity.GetDate4;
                        e.Certificate5 = entity.Certificate5;
                        e.Level5 = entity.Level5;
                        e.GetDate5 = entity.GetDate5;
                        e.Position = entity.Position;
                        e.IsManager = entity.IsManager;
                        e.Forte = entity.Forte;
                        e.Political = entity.Political;
                        e.PhotoUrl = entity.PhotoUrl;
                        e.NativePlace = entity.NativePlace;
                        e.Ethnic = entity.Ethnic;
                        e.Birthday = entity.Birthday;
                        e.Age = entity.Age;
                        e.IDCard = entity.IDCard;
                        e.MobileNumber = entity.MobileNumber;
                        e.UpdateTime = DateTime.Now;

                        //更新用户表姓名
                        Sys_User user = new Sys_User();
                        user.ID = e.ID;
                        user.UserAccount = e.EmployeeID;
                        user.LoginID = e.MobileNumber;
                        user.MobileNumber = e.MobileNumber;
                        user.UserName = e.Name;
                        user.Email = e.Email;
                        ISys_UserService userSevice = new Sys_UserService();
                        userSevice.InsertOrUpdate(user);

                        oldEntity = repository.Update(e);
                    }
                    else
                    {
                        var validate = repository.GetEntityByColNameAndColValue("MobileNumber", entity.MobileNumber);
                        if (validate != null)
                        {
                            throw new Exception("手机号已存在请更换");
                        }
                        validate = repository.GetEntityByColNameAndColValue("EmployeeID", entity.EmployeeID);
                        if (validate != null && validate.Sys_User.SchoolID == entity.SchoolID)
                        {
                            throw new Exception("职工号已存在请更换");
                        }

                        #region 数据验证
                        string valResult = ValidateHelper.ValidateObject<Basic_TeacherInfo>(entity, true);
                        if (!string.IsNullOrEmpty(valResult))
                        {
                            throw new Exception(valResult);
                        }
                        #endregion

                        entity.CreateTime = DateTime.Now;
                        entity.Status = (int)Entity.CustomEntity.ConstantEntity.DataStatus.Valid;

                        //先插入用户表
                        Sys_User user = new Sys_User();
                        user.ID = Guid.NewGuid().ToString();
                        user.UserAccount = entity.EmployeeID;
                        user.UserName = entity.Name;
                        user.LoginID = entity.MobileNumber;
                        user.SchoolID = entity.SchoolID;
                        ISys_UserService userSevice = new Sys_UserService();
                        user = userSevice.InsertOrUpdate(user);
                        entity.ID = user.ID;

                        oldEntity = repository.Insert(entity);
                    }
                    transcope.Complete();
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return oldEntity;
        }



        public bool ImportTeachers(List<Basic_TeacherInfo> list)
        {
            ISys_UserService userService = new Sys_UserService();
            foreach (var item in list)
            {
                try
                {
                    Dictionary<string, object> dic = new Dictionary<string, object>();
                    dic.Add("SchoolID", item.SchoolID);
                    dic.Add("UserAccount", item.EmployeeID);
                    dic.Add("UserType", "0");
                    var user = userService.GetEntityByColNamesAndColValues(dic);
                    if (user != null)
                    {
                        user.MobileNumber = item.MobileNumber;
                        user.LoginID = item.MobileNumber;
                        userService.Update(user);
                        var teacher = this.GetEntityByColNameAndColValue("ID", user.ID);
                        if (teacher != null)
                        {
                            teacher.MobileNumber = item.MobileNumber;
                            subRepository.Update(teacher);
                        }
                        else
                        {
                            teacher = new Basic_TeacherInfo();
                            teacher.ID = user.ID;
                            teacher.EmployeeID = item.EmployeeID;
                            teacher.Name = item.Name;
                            teacher.MobileNumber = item.MobileNumber;
                            teacher.Birthday = item.Birthday;
                            teacher.Status = 1;
                            if (teacher.Birthday == null)
                            {
                                teacher.Birthday = DateTime.Now;
                            }
                            teacher.Sex = item.Sex;
                            teacher.Age = item.Age;
                            subRepository.Insert(teacher);

                        }
                    }
                    else
                    {
                        //创建用户，创建教职工信息
                        user = new Sys_User();
                        user.SchoolID = item.SchoolID;
                        user.LoginID = item.MobileNumber;
                        user.UserName = item.Name;
                        user.UserAccount = item.EmployeeID;
                        user.Email = item.Email;
                        user.MobileNumber = item.MobileNumber;
                        user.Status = 1;
                        user = userService.InsertOrUpdate(user);
                        var teacher = new Basic_TeacherInfo();
                        teacher.ID = user.ID;
                        teacher.EmployeeID = item.EmployeeID;
                        teacher.Name = item.Name;
                        teacher.MobileNumber = item.MobileNumber;
                        teacher.Birthday = item.Birthday;
                        teacher.Status = 1;
                        if (teacher.Birthday == null)
                        {
                            teacher.Birthday = DateTime.Now;
                        }
                        teacher.Sex = item.Sex;
                        teacher.Age = item.Age;
                        subRepository.Insert(teacher);
                    }
                }
                catch
                {

                }
            }
            return true;

        }

        /// <summary>
        /// 删除教职工信息时应将用户信息同时删除
        /// </summary>
        /// <param name="list"></param>
        /// <param name="columnName"></param>
        /// <returns></returns>
        public new int LogicDeleteBatch(List<Basic_TeacherInfo> list, string columnName)
        {
            int result = 0;
            try
            {
                using (TransactionScope transcope = new TransactionScope())
                {
                    result = repository.LogicDeleteBatch(list, columnName);
                    var userList = new List<Sys_User>();
                    foreach (var item in list)
                    {
                        Sys_User user = new Sys_User();
                        user.ID = item.ID;
                        userList.Add(user);
                    }
                    if (userList.Count > 0)
                    {
                        ISys_UserService userSevice = new Sys_UserService();
                        result = userSevice.LogicDeleteBatch(userList, "ID");
                    }
                    transcope.Complete();
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return result;
        }



        public List<Basic_TeacherInfo> GetTeacherListByCenterID(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery)
        {
            return subRepository.GetTeacherListByCenterID(pageQuery);
        }


        public List<Basic_TeacherInfo> GetTeacherListByRoomID(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery)
        {
            return subRepository.GetTeacherListByRoomID(pageQuery);
        }
        /// <summary>
        /// 获取教师男女人数
        /// </summary>
        /// <param name="pageQuery"></param>
        /// <returns></returns>
        public List<Basic_TeacherInfo> GetTeacherSexInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery)
        {
            return subRepository.GetTeacherSexInfo(pageQuery);
        }
        /// <summary>
        /// 获取教师各个学历人数
        /// </summary>
        public List<Basic_TeacherInfo> GetTeacherEducationInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery)
        {
            return subRepository.GetTeacherEducationInfo(pageQuery);
        }
        /// <summary>
        /// 获取各个专业职称人数
        /// </summary>
        /// <param name="pageQuery"></param>
        /// <returns></returns>
        public List<Basic_TeacherInfo> GetTeacherTechnicalTitleInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery)
        {
            return subRepository.GetTeacherTechnicalTitleInfo(pageQuery);
        }
        /// <summary>
        /// 获取职业资格证书
        /// </summary>
        /// <param name="pageQuery"></param>
        /// <returns></returns>
        public List<Basic_TeacherInfo> GetTeacherCertificateInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery)
        {
            return subRepository.GetTeacherCertificateInfo(pageQuery);
        }
        /// <summary>
        ///  获取教师年龄段信息
        /// </summary>
        /// <param name="pageQuery"></param>
        /// <returns></returns>
        public List<Basic_TeacherInfo> GetTeacherAgeInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery)
        {
            return subRepository.GetTeacherAgeInfo(pageQuery);
        }
        /// <summary>
        /// 获取职教工作年限
        /// </summary>
        /// <param name="pageQuery"></param>
        /// <returns></returns>
        public List<Basic_TeacherInfo> GetTeacherWorkYearInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery)
        {
            return subRepository.GetTeacherWorkYearInfo(pageQuery);
        }
    }
}
