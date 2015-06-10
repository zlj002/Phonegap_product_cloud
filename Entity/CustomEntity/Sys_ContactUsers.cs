using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.CustomEntity
{
   public class Sys_ContactUsers
    {
        public string UserID { get; set; }
        public string UserNo { get; set; }
        public string UserName { get; set; }
        public string MobilePhone { get; set; }
        public string Email { get; set; }
        public Nullable<bool> Gender { get; set; }
        public Nullable<System.DateTime> Birthday { get; set; }
        public string Address { get; set; }
        public string ZipCode { get; set; }
        public int UserType { get; set; }
        public string CreateUser { get; set; }
        public Nullable<System.DateTime> UpdateTime { get; set; }
        public Nullable<int> Status { get; set; }
        public string Duties { get; set; }
    }
}
