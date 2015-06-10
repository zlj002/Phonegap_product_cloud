using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BizProcess.Base.Interface;
using Entity;
namespace BizProcess.Interface
{
    public interface IBasic_TeacherManagerService : IBaseService<Basic_TeacherInfo>
    {

        /// <summary>
        ///  添加或更新
        /// </summary>
        /// <param name="entity">对象实例</param>
        /// <returns></returns>
        Basic_TeacherInfo InsertOrUpdate(Basic_TeacherInfo entity);


        
        /// <summary>
        ///   //根据实训中心ID获取教师列表
        /// </summary>
        /// <param name="centerID"></param>
        /// <returns></returns>
        List<Basic_TeacherInfo> GetTeacherListByCenterID(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery);


        //根据实训室ID获取教师列表
        List<Basic_TeacherInfo> GetTeacherListByRoomID(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery);
        // <summary>
        /// 获取教师男女人数
        /// </summary>
        List<Basic_TeacherInfo> GetTeacherSexInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery);
        /// <summary>
        /// 获取教师各个学历人数
        /// </summary>
        /// <param name="pageQuery"></param>
        /// <returns></returns>
        List<Basic_TeacherInfo> GetTeacherEducationInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery);
        /// <summary>
        /// 获取各个专业职称人数
        /// </summary>
        List<Basic_TeacherInfo> GetTeacherTechnicalTitleInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery);
        /// <summary>
        /// 获取职业资格证书
        /// </summary>
        List<Basic_TeacherInfo> GetTeacherCertificateInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery);
        /// <summary>
        /// 获取教师年龄段信息
        /// </summary>
        /// <param name="pageQuery"></param>
        /// <returns></returns>
        List<Basic_TeacherInfo> GetTeacherAgeInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery);
        /// <summary>
        /// 获取职教工作年限
        /// </summary>
        /// <param name="pageQuery"></param>
        /// <returns></returns>
        List<Basic_TeacherInfo> GetTeacherWorkYearInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery);

        bool ImportTeachers(List<Basic_TeacherInfo> list);
    }
}
