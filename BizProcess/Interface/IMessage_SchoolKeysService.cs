using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;

namespace BizProcess.Interface
{
    public interface IMessage_SchoolKeysService : IBaseService<Message_SchoolKeys>
    {
        Message_SchoolKeys GetSchoolKeysBySchoolIDAndKey(string schoolID, string key);
    }
}
