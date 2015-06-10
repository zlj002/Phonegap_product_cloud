using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entity
{
    public partial class Basic_TeacherInfo
    {

        /// <summary>
        /// 登录名
        /// </summary>
        [EntityMemberAttribute(EnumEntityMemberUsage.NoDBField)]
        public string LoginID { get; set; }
        /// <summary>
        /// 学校id
        /// </summary>
        [EntityMemberAttribute(EnumEntityMemberUsage.NoDBField)]
        public string SchoolID { get; set; }
        
    }
}
