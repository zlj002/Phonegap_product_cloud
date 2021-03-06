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
    
    public partial class Basic_TeacherInfo
    {
        public Basic_TeacherInfo()
        {
            this.Basic_TeacherInfo_Education = new HashSet<Basic_TeacherInfo_Education>();
            this.Basic_TeacherInfo_Experience = new HashSet<Basic_TeacherInfo_Experience>();
            this.Basic_TeacherInfo_Fruit = new HashSet<Basic_TeacherInfo_Fruit>();
            this.Basic_TeacherInfo_Practice = new HashSet<Basic_TeacherInfo_Practice>();
            this.Basic_TeacherInfo_Reward = new HashSet<Basic_TeacherInfo_Reward>();
            this.Basic_TeacherInfo_Training = new HashSet<Basic_TeacherInfo_Training>();
            this.Basic_Department = new HashSet<Basic_Department>();
        }
    
        public string ID { get; set; }
        public string EmployeeID { get; set; }
        public string Name { get; set; }
        public bool Sex { get; set; }
        public string PhotoUrl { get; set; }
        public Nullable<System.DateTime> Birthday { get; set; }
        public int Age { get; set; }
        public string Ethnic { get; set; }
        public string NativePlace { get; set; }
        public string Political { get; set; }
        public string IDCard { get; set; }
        public string Healthy { get; set; }
        public string Telephone { get; set; }
        public string ZipCode { get; set; }
        public string Email { get; set; }
        public string PostalAddress { get; set; }
        public string HomeAddress { get; set; }
        public string SchoolName { get; set; }
        public string JobType { get; set; }
        public string TeachingType { get; set; }
        public string TeacherProperty { get; set; }
        public string Education { get; set; }
        public string Degree { get; set; }
        public string FirstLanguage { get; set; }
        public string FirstExtent { get; set; }
        public string SecondLanguage { get; set; }
        public string SecondExtent { get; set; }
        public string TeachSpecialty { get; set; }
        public string Discipline { get; set; }
        public string Certificate1 { get; set; }
        public string Level1 { get; set; }
        public Nullable<System.DateTime> GetDate1 { get; set; }
        public string Certificate2 { get; set; }
        public string Level2 { get; set; }
        public Nullable<System.DateTime> GetDate2 { get; set; }
        public string Certificate3 { get; set; }
        public string Level3 { get; set; }
        public Nullable<System.DateTime> GetDate3 { get; set; }
        public string TechnicalTitle { get; set; }
        public Nullable<System.DateTime> TechnicalGetDate { get; set; }
        public Nullable<int> WorkYears { get; set; }
        public Nullable<int> ManagerYears { get; set; }
        public string Certificate4 { get; set; }
        public string Level4 { get; set; }
        public Nullable<System.DateTime> GetDate4 { get; set; }
        public string Certificate5 { get; set; }
        public string Level5 { get; set; }
        public Nullable<System.DateTime> GetDate5 { get; set; }
        public string Position { get; set; }
        public Nullable<bool> IsManager { get; set; }
        public string Forte { get; set; }
        public Nullable<System.DateTime> CreateTime { get; set; }
        public string CreateUser { get; set; }
        public Nullable<System.DateTime> UpdateTime { get; set; }
        public string UpdateUser { get; set; }
        public Nullable<int> Status { get; set; }
        public string Remark { get; set; }
        public Nullable<int> DisplayIndex { get; set; }
        public string MobileNumber { get; set; }
        public string RecentActivities { get; set; }
        public string ILike { get; set; }
        public string PersonalSign { get; set; }
    
        public virtual ICollection<Basic_TeacherInfo_Education> Basic_TeacherInfo_Education { get; set; }
        public virtual ICollection<Basic_TeacherInfo_Experience> Basic_TeacherInfo_Experience { get; set; }
        public virtual ICollection<Basic_TeacherInfo_Fruit> Basic_TeacherInfo_Fruit { get; set; }
        public virtual ICollection<Basic_TeacherInfo_Practice> Basic_TeacherInfo_Practice { get; set; }
        public virtual ICollection<Basic_TeacherInfo_Reward> Basic_TeacherInfo_Reward { get; set; }
        public virtual Sys_User Sys_User { get; set; }
        public virtual ICollection<Basic_TeacherInfo_Training> Basic_TeacherInfo_Training { get; set; }
        public virtual ICollection<Basic_Department> Basic_Department { get; set; }
    }
}
