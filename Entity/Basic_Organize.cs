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
    
    public partial class Basic_Organize
    {
        public Basic_Organize()
        {
            this.Basic_OrganizeUser_Relationship = new HashSet<Basic_OrganizeUser_Relationship>();
        }
    
        public string ID { get; set; }
        public string SchoolID { get; set; }
        public string Name { get; set; }
        public string PID { get; set; }
        public int OrderIndex { get; set; }
        public string CreateUser { get; set; }
        public System.DateTime CreateTime { get; set; }
        public System.DateTime UpdateTime { get; set; }
        public string UpdateUser { get; set; }
        public bool Status { get; set; }
        public string Remark { get; set; }
    
        public virtual ICollection<Basic_OrganizeUser_Relationship> Basic_OrganizeUser_Relationship { get; set; }
    }
}
