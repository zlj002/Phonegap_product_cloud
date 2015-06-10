using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Entity
{
    public partial class Channel
    {
        [EntityMember(EnumEntityMemberUsage.NoDBField)]
        public int TotalCount { get; set; }
    }
}
