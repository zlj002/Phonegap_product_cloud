using BizProcess.Base.Service;
using BizProcess.Interface;
using DataAccess.Interface;
using DataAccess.Repository;
using Entity;
using Entity.CustomEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BizProcess.Service
{
    public class Sys_MenuService : BaseService<Sys_Menu>, ISys_MenuService
    {
        ISys_MenuRepository subRepository;

        ISys_RoleMenuOperationRepository roleMenuOperationRepository;
        public Sys_MenuService()
        {
            subRepository = new Sys_MenuRepository();
            roleMenuOperationRepository = new Sys_RoleMenuOperationRepository();
            base.repository = subRepository;
        }



        public OurHelper.PageHelper<Sys_Menu> GetPageListAllMenuRoleInfoByRoleID(OurHelper.PageHelper<Sys_Menu> pageQuery)
        {
            return subRepository.GetPageListAllMenuRoleInfoByRoleID(pageQuery);
        }


        public OurHelper.PageHelper<Sys_Menu> GetMenuListByUserID(OurHelper.PageHelper<Sys_Menu> pageQuery)
        {
            return subRepository.GetMenuListByUserID(pageQuery);
        }


        public OurHelper.PageHelper<Sys_RoleMenuOperation> GetOperationListByUserID(OurHelper.PageHelper<Sys_RoleMenuOperation> pageQuery)
        {
            return roleMenuOperationRepository.GetOperationListByUserID(pageQuery);
        }
    }
}
