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
    
    public partial class Sys_Operation
    {
        public Sys_Operation()
        {
            this.Sys_RoleMenuOperation = new HashSet<Sys_RoleMenuOperation>();
            this.Sys_Menu = new HashSet<Sys_Menu>();
        }
    
        public string OperationID { get; set; }
        public string OperationName { get; set; }
        public string OperationClass { get; set; }
        public string OperationImageUrl { get; set; }
        public Nullable<System.DateTime> CreateTime { get; set; }
        public string CreateUser { get; set; }
        public Nullable<System.DateTime> UpdateTime { get; set; }
        public string UpdateUser { get; set; }
        public Nullable<int> Status { get; set; }
        public string Remark { get; set; }
        public Nullable<int> DisplayIndex { get; set; }
    
        public virtual ICollection<Sys_RoleMenuOperation> Sys_RoleMenuOperation { get; set; }
        public virtual ICollection<Sys_Menu> Sys_Menu { get; set; }
    }
}
