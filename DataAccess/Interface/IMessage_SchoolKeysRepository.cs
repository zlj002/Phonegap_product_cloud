using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface IMessage_SchoolKeysRepository : IRepository<Message_SchoolKeys>
    {
        Message_SchoolKeys GetSchoolKeysBySchoolIDAndKey(string schoolID, string key);
    }
}
