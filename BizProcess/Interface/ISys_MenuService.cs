using BizProcess.Base.Interface;
using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BizProcess.Interface
{
    public interface ISys_MenuService : IBaseService<Sys_Menu>
    {
        /// <summary>
        /// 根据角色id获取菜单列表，包含此菜单是否属于当前角色id
        /// </summary>
        /// <param name="pageQuery"></param>
        /// <returns></returns>
        OurHelper.PageHelper<Sys_Menu> GetPageListAllMenuRoleInfoByRoleID(OurHelper.PageHelper<Sys_Menu> pageQuery);

        /// <summary>
        /// 根据用户名获取全部菜单
        /// </summary>
        /// <param name="parameters"></param>
        /// <returns></returns>
        OurHelper.PageHelper<Sys_Menu> GetMenuListByUserID(OurHelper.PageHelper<Sys_Menu> pageQuery);

        /// <summary>
        /// 获取当前用户所有的操作功能
        /// </summary>
        /// <param name="pageQuery"></param>
        /// <returns></returns>
        OurHelper.PageHelper<Sys_RoleMenuOperation> GetOperationListByUserID(OurHelper.PageHelper<Sys_RoleMenuOperation> pageQuery);
    }
}
