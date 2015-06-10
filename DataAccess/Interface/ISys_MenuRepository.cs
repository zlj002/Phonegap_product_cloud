using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface ISys_MenuRepository : IRepository<Sys_Menu> 
    {
        /// <summary>
        /// 根据角色id获取菜单列表，包含此菜单是否属于当前角色id
        /// </summary>
        /// <param name="pageQuery"></param>
        /// <returns></returns>
        OurHelper.PageHelper<Sys_Menu> GetPageListAllMenuRoleInfoByRoleID(OurHelper.PageHelper<Sys_Menu> pageQuery);

        /// <summary>
        /// 获取当前用户的菜单列表
        /// </summary>
        /// <param name="pageQuery"></param>
        /// <returns></returns>
        OurHelper.PageHelper<Sys_Menu> GetMenuListByUserID(OurHelper.PageHelper<Sys_Menu> pageQuery);
    }
}
