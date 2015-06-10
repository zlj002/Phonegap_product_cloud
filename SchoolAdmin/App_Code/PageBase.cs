using BizProcess.Interface;
using BizProcess.Service;
using Entity;
using OurHelper;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Caching;
 
    public class PageBase : System.Web.UI.Page
    {
        /// <summary>
        /// 缓存key前缀
        /// </summary>
        public static string CurrentUserInfoCacheKeyPre = "CurrentUserInfo_";
        /// <summary>
        /// 缓存依赖项后缀
        /// </summary>
        private static string CurrentUserInfoCacheKeyDependencySuff = "_dependency";

        /// <summary>
        /// 当前用户id
        /// </summary>
        public string CurrentUserID
        {
            get
            {
                return HttpContext.Current.User.Identity.Name;
            }
        }

        /// <summary>
        /// 当前用户id
        /// </summary>
        public string CurrentSchoolID
        {
            get
            {
                return CurrentUser.SchoolID;
            }
        }
        /// <summary>
        /// 当前用户信息
        /// </summary>
        public Sys_User CurrentUser
        {
            get
            {
                Sys_User userInfo = new Sys_User();
                if (HttpRuntime.Cache.Get(CurrentUserInfoCacheKeyPre + CurrentUserID) == null)
                {
                    SetUserInfoCache(CurrentUserID);
                }

                userInfo = (Sys_User)HttpRuntime.Cache.Get(CurrentUserInfoCacheKeyPre + CurrentUserID);
                return userInfo;
            }
        }

        /// <summary>
        /// 设置当前用户信息
        /// </summary>
        /// <param name="userID"></param>
        /// <param name="userInfo"></param>
        private void SetUserInfoCache(string userID)
        {
            ISys_UserService userService = new Sys_UserService();
            Sys_User userInfo = userService.GetEntityByColNameAndColValue("ID", userID);
             
            //权限菜单
            ISys_MenuService service = new Sys_MenuService();
            PageHelper<Sys_Menu> page = new PageHelper<Sys_Menu>();
            page.PageIndex = 1;
            page.PageSize = 1000;
            page.QueryKeyValues.Add(new KeyValue("m.Status", "1"));
            page.QueryKeyValues.Add(new KeyValue("ru.UserID", new PageBase().CurrentUserID));
            List<Sys_Menu> list = service.GetMenuListByUserID(page).Data;
            userInfo.MenuList = list;

            //权限按钮
            PageHelper<Sys_RoleMenuOperation> pageRoleMenuOperation = new PageHelper<Sys_RoleMenuOperation>();
            pageRoleMenuOperation.PageIndex = 1;
            pageRoleMenuOperation.PageSize = 1000;
            pageRoleMenuOperation.QueryKeyValues.Add(new KeyValue("ru.UserID", new PageBase().CurrentUserID));
            List<Sys_RoleMenuOperation> listOperations = service.GetOperationListByUserID(pageRoleMenuOperation).Data;
            userInfo.MenuOperationList = listOperations;

            //创建缓存依赖
            UpdateUserInfoCache(userID);
            CacheDependency dep = new CacheDependency(null, new string[] { CurrentUserInfoCacheKeyPre + userID + CurrentUserInfoCacheKeyDependencySuff });
            //创建缓存
            HttpRuntime.Cache.Insert(CurrentUserInfoCacheKeyPre + userID, userInfo, dep, System.Web.Caching.Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(20));
        }


        /// <summary>
        /// 更新指定用户缓存
        /// </summary>
        /// <param name="userID"></param>
        public void UpdateUserInfoCache(string userID)
        {
            HttpRuntime.Cache.Insert(CurrentUserInfoCacheKeyPre + userID + CurrentUserInfoCacheKeyDependencySuff, Guid.NewGuid().ToString(), null, System.Web.Caching.Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(20));
        }

        /// <summary>
        /// 更新所有用户缓存
        /// </summary>
        public void UpdateAllUserCache()
        {
            IDictionaryEnumerator CacheEnum = HttpRuntime.Cache.GetEnumerator();
            while (CacheEnum.MoveNext())
            {
                HttpRuntime.Cache.Remove(CacheEnum.Key.ToString());
            }
        }

    }
