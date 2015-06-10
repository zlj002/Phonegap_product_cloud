using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface ISys_UserRepository : IRepository<Sys_User>
    {
        /// <summary>
        /// 检查登入
        /// </summary>
        /// <returns></returns>
        Sys_User CheckLogin(string loginID, string password);

        /// <summary>
        /// 根据角色id获取用户列表，包含此用户是否属于当前角色id
        /// </summary>
        /// <param name="pageQuery"></param>
        /// <returns></returns>
        OurHelper.PageHelper<Sys_User> GetPageListAllUserRoleInfoByRoleID(OurHelper.PageHelper<Sys_User> pageQuery);
    }
}
