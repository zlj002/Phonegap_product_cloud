using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Text;
using Entity;

namespace DataAccess.Helper
{
    public static class DbContextHelper
    { 
        private const string SessionKey_DbContext = "DbContext";
        /// <summary>
        /// 获得DbContext
        /// </summary>
        /// <returns></returns>
        public static DbContext GetDbContext()
        {
            if (CallContext.GetData(SessionKey_DbContext) == null)
            {
                CallContext.SetData(SessionKey_DbContext, new OurSolutionEntities());
            }
            return CallContext.GetData(SessionKey_DbContext) as OurSolutionEntities;
        }
    }
}
