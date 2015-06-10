using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;

namespace BizProcess.Interface
{
    public interface ISys_FeatureService : IBaseService<Sys_Feature>
    {
        /// <summary>
        /// 根据当前用户的所在的部门，组，获取当前用户的功能
        /// </summary> 
        /// <returns></returns>
        List<Sys_Feature> GetSys_FeatureByCurrentUser();

        /// <summary>
        /// 获取当前人的组织架构
        /// </summary>
        /// <returns></returns>
        List<Basic_Organize> GetOrganizeByCurrentUser();

        /// <summary>
        /// 获取当前人的组
        /// </summary>
        /// <returns></returns>
        List<Basic_Group> GetGroupByCurrentUser();
    }
}
