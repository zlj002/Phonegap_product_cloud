using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface IBasic_OrganizeRepository : IRepository<Basic_Organize>
    { 
        /// <summary>
        /// 获取当前用户所属组织结构
        /// </summary>
        /// <returns></returns>
        List<Basic_Organize> GetOrganizeByCurrentUser();
    }
}
