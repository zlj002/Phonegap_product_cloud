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
    
    public partial class Basic_TeacherInfo_Reward
    {
        public string ID { get; set; }
        public string TeacherID { get; set; }
        public string Name { get; set; }
        public string RewardLevel { get; set; }
        public string RewardType { get; set; }
        public string Role { get; set; }
        public string RewardName { get; set; }
        public string Company { get; set; }
        public System.DateTime GetDate { get; set; }
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
