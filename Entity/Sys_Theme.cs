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
    
    public partial class Sys_Theme
    {
        public Sys_Theme()
        {
            this.Sys_School = new HashSet<Sys_School>();
        }
    
        public string ThemeID { get; set; }
        public string ThemeName { get; set; }
        public string PreViewImage { get; set; }
        public string CssUrl { get; set; }
        public Nullable<System.DateTime> CreateTime { get; set; }
        public string CreateUser { get; set; }
        public Nullable<System.DateTime> UpdateTime { get; set; }
        public string UpdateUser { get; set; }
        public Nullable<int> Status { get; set; }
        public string Remark { get; set; }
        public Nullable<int> DisplayIndex { get; set; }
    
        public virtual ICollection<Sys_School> Sys_School { get; set; }
    }
}
