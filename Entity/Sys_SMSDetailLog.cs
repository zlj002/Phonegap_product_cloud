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
    
    public partial class Sys_SMSDetailLog
    {
        public int ID { get; set; }
        public string SchoolID { get; set; }
        public Nullable<int> SMSLogID { get; set; }
        public string ReceiveUserName { get; set; }
        public string ReturnMessage { get; set; }
        public bool Status { get; set; }
        public Nullable<System.DateTime> SendTime { get; set; }
        public string SenderUserID { get; set; }
        public string ReceiveUserMobile { get; set; }
        public string MessageContent { get; set; }
    }
}