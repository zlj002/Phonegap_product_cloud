//------------------------------------------------------------------------------
// <auto-generated>
//    此代码是根据模板生成的。
//
//    手动更改此文件可能会导致应用程序中发生异常行为。
//    如果重新生成代码，则将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace Entity
{
    using System;
    using System.Collections.Generic;
    
    public partial class Sys_RoleMenuOperation
    {
        public string RoleID { get; set; }
        public string MenuID { get; set; }
        public string OperationID { get; set; }
    
        public virtual Sys_Menu Sys_Menu { get; set; }
        public virtual Sys_Operation Sys_Operation { get; set; }
        public virtual Sys_Role Sys_Role { get; set; }
    }
}
