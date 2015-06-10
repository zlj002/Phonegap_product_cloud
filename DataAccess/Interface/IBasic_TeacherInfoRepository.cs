using DataAccess.Base.Interface;
using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Interface
{
    /// <summary>
    /// 师资管理接口
    /// </summary>
    public interface IBasic_TeacherInfoRepository : IRepository<Basic_TeacherInfo>
    {
        //根据实训中心ID获取教师列表
        List<Basic_TeacherInfo> GetTeacherListByCenterID(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery);

        //根据实训室ID获取教师列表
        List<Basic_TeacherInfo> GetTeacherListByRoomID(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery);
        //获取教师男女人数
        List<Basic_TeacherInfo> GetTeacherSexInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery);
        //获取教师各个学历人数
        List<Basic_TeacherInfo> GetTeacherEducationInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery);
        //获取各个专业职称人数
        List<Basic_TeacherInfo> GetTeacherTechnicalTitleInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery);
        //获取职业资格证书
        List<Basic_TeacherInfo> GetTeacherCertificateInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery);
        // 获取教师年龄段信息
        List<Basic_TeacherInfo> GetTeacherAgeInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery);
        //获取职教工作年限
        List<Basic_TeacherInfo> GetTeacherWorkYearInfo(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery);

         
    }
}
