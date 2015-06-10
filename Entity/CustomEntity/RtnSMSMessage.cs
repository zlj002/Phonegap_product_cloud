using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.CustomEntity
{
    public class RtnSMSMessage
    {
        public int ReturnFlag { get; set; }

        public string ReturnMessage { get; set; }

        public int SmsRemainderCount { get; set; }
    }
}
