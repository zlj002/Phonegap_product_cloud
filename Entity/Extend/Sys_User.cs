

namespace Entity
{
    using System;
    using System.Collections.Generic;

    public partial class Sys_User
    { 
        /// <summary>
        /// 缓存菜单列表使用
        /// </summary>
        public List<Sys_Menu> MenuList = new List<Sys_Menu>();
        /// <summary>
        /// 缓存菜单功能使用
        /// </summary>
        public List<Sys_RoleMenuOperation> MenuOperationList = new List<Sys_RoleMenuOperation>();
         

        /// <summary>
        ///  老师所在的实训中心ID
        /// </summary>
        [EntityMemberAttribute(EnumEntityMemberUsage.NoDBField)]
        public string TeacherTrainingCenterID { get; set; }
        /// <summary>
        /// 老师当前的头像
        /// </summary>
        [EntityMemberAttribute(EnumEntityMemberUsage.NoDBField)]
        public string TeacherPhotoUrl { get; set; }


        /// <summary>
        /// 是否属于当前角色
        /// </summary>
        [EntityMemberAttribute(EnumEntityMemberUsage.NoDBField)]
        public int UserIsBelongToRole { get; set; }

        /// <summary>
        /// 职工号
        /// </summary>
        [EntityMemberAttribute(EnumEntityMemberUsage.NoDBField)]
        public string EmployeeID { get; set; }
    }
}
