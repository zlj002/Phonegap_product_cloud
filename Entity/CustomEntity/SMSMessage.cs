using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.CustomEntity
{
    public class SMSMessage
    {
        public SMSMessage()
        {
            this.List = new List<Sys_ContactUsers>();
        }
        public string SMSLogID;

        public string SendUserID;

        public List<Sys_ContactUsers> List;

        public Sys_ContactUsers Sys_ContactUsers;
    }
}
