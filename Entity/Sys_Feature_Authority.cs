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
    
    public partial class Sys_Feature_Authority
    {
        public string SchoolID { get; set; }
        public string FeatureID { get; set; }
        public string TargetID { get; set; }
        public int TargetType { get; set; }
    
        public virtual Sys_Feature Sys_Feature { get; set; }
        public virtual Sys_School Sys_School { get; set; }
    }
}
