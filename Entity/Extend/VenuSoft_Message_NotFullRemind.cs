using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entity
{
    public partial class VenuSoft_Message_NotFullRemind
    {
        //姓名
        [EntityMemberAttribute(EnumEntityMemberUsage.NoDBField)]
        public string UserName { get; set; }

        //手机号码
        [EntityMemberAttribute(EnumEntityMemberUsage.NoDBField)]
        public string MobilePhone { get; set; }

    }
}
