using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface IBasic_GroupRepository : IRepository<Basic_Group>
    {
        /// <summary>
        /// 获取当前用户所属组
        /// </summary>
        /// <returns></returns>
        List<Basic_Group> GetGroupByCurrentUser();
    }
}
