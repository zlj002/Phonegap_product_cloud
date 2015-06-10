using BizProcess.Base.Interface;
using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BizProcess.Interface
{
    public interface ISys_RoleService : IBaseService<Sys_Role>
    {


        /// <summary>
        /// 更新或插入缓存数据连接字符串，有更新，没有则插入
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        Sys_Role InsertOrUpdate(Sys_Role entity);

     
        /// <summary>
        /// 给角色分配用户，一次分配多个用户
        /// </summary>
        /// <param name="roleID"></param>
        /// <param name="userIDs"></param>
        /// <param name="isAdd"></param>
        /// <returns></returns>
        bool SetUsersForRoleID(string roleID, string[] userIDs, bool isAdd);

        /// <summary>
        /// 给角色分配菜单，一次分配多个菜单
        /// </summary>
        /// <param name="roleID"></param>
        /// <param name="menuIDs"></param>
        /// <param name="isAdd"></param>
        /// <returns></returns>
        bool SetMenusForRoleID(string roleID, string[] menuIDs, bool isAdd);

        /// <summary>
        /// 给角色分配菜单功能，一次分配多个菜单功能
        /// </summary>
        /// <param name="roleID"></param>
        /// <param name="menuOperationIDs"></param>
        /// <param name="isAdd"></param>
        /// <returns></returns>
        bool SetMenuOperationsForRoleID(string roleID, string[] menuOperationIDs, bool isAdd);

        /// <summary>
        /// 修改锁定状态
        /// </summary>
        /// <param name="roleID"></param>
        /// <param name="isLock"></param>
        /// <returns></returns>
        bool ChangeLockStatus(string roleID,string isLock);
    }
}
