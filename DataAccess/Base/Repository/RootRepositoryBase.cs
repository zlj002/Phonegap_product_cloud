using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DataAccess.Base.Repository
{
    public class RootRepositoryBase<T> : RepositoryBase<T> where T : class,new()
    {
        /// <summary>
        /// 当前学校
        /// </summary>
        public string SchoolID { get; set; }
        /// <summary>
        /// 当前用户ID
        /// </summary>
        public string CurrentUserID { get; set; }
        public RootRepositoryBase()
        {

        }
    }
}
