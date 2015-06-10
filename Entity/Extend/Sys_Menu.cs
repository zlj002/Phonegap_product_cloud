using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entity
{
    public partial class Sys_Menu
    {
        /// <summary>
        /// 获取菜单列表时，如果有角色，显示此菜单是否属于当前角色 
        /// </summary> 
        [EntityMemberAttribute(EnumEntityMemberUsage.NoDBField)]
        public int MenuIsBelongToRole { get; set; }
        /// <summary>
        /// 获取权限信息时，区分是菜单还是按钮
        /// </summary>
        [EntityMemberAttribute(EnumEntityMemberUsage.NoDBField)]
        public string MenuType { get; set; }

    }
}
