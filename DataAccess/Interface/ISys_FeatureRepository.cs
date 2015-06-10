using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface ISys_FeatureRepository : IRepository<Sys_Feature>
    {
        /// <summary>
        /// 获取当前用户的功能点
        /// </summary>
        /// <param name="departmentIDs"></param>
        /// <param name="groupIDs"></param>
        /// <returns></returns>
        List<Sys_Feature> GetSys_FeatureByCurrentUser(List<string> departmentIDs, List<string> groupIDs);
    }
}
