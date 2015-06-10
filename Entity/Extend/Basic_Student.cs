using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entity
{
    public partial class Basic_Student
    {
        //学校ID
        [EntityMemberAttribute(EnumEntityMemberUsage.NoDBField)]
        public string SchoolID { get; set; }

        //登入名
        [EntityMemberAttribute(EnumEntityMemberUsage.NoDBField)]
        public string LoginID { get; set; }

        //密码
        [EntityMemberAttribute(EnumEntityMemberUsage.NoDBField)]
        public string PassWord { get; set; }

        //班级名称
        [EntityMemberAttribute(EnumEntityMemberUsage.NoDBField)]
        public string ClassName { get; set; }

        //专业名称
        [EntityMemberAttribute(EnumEntityMemberUsage.NoDBField)]
        public string SpecialtyName { get; set; }

        /// <summary>
        /// 注册时短信验证码
        /// </summary>
        [EntityMemberAttribute(EnumEntityMemberUsage.NoDBField)]
        public string RegistMessageCode { get; set; }
    }
}
