using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface ISys_RoleMenuOperationRepository : IRepository<Sys_RoleMenuOperation>
    { 
        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="list"></param>
        /// <returns></returns>
        bool DeleteBatch(List<Sys_RoleMenuOperation> list);
        /// <summary>
        /// 获取当前用户的菜单功能列表
        /// </summary>
        /// <param name="pageQuery"></param>
        /// <returns></returns>
        OurHelper.PageHelper<Sys_RoleMenuOperation> GetOperationListByUserID(OurHelper.PageHelper<Sys_RoleMenuOperation> pageQuery);
    }
}
