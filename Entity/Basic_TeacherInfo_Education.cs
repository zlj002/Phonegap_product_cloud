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
    
    public partial class Basic_TeacherInfo_Education
    {
        public string ID { get; set; }
        public string TeacherID { get; set; }
        public string Name { get; set; }
        public System.DateTime BeginDate { get; set; }
        public Nullable<System.DateTime> EndDate { get; set; }
        public string SchoolName { get; set; }
        public string SpecialtyName { get; set; }
        public Nullable<System.DateTime> CreateTime { get; set; }
        public string CreateUser { get; set; }
        public Nullable<System.DateTime> UpdateTime { get; set; }
        public string UpdateUser { get; set; }
        public Nullable<int> Status { get; set; }
        public string Remark { get; set; }
        public Nullable<int> DisplayIndex { get; set; }
    
        public virtual Basic_TeacherInfo Basic_TeacherInfo { get; set; }
    }
}
