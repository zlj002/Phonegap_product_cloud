using BizProcess.Base.Service;
using BizProcess.Common.Validate;
using BizProcess.Interface;
using DataAccess.Interface;
using DataAccess.Repository;
using Entity;
using OurHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BizProcess.Service
{
    public class Sys_RoleService : BaseService<Sys_Role>, ISys_RoleService
    {
        ISys_RoleRepository subRepository;
        ISys_RoleUserRepository roleUserRepository;
        ISys_RoleMenuRepository roleMenuRepository;
        ISys_RoleMenuOperationRepository roleMenuOperationRepository;
        public Sys_RoleService()
        {
            subRepository = new Sys_RoleRepository();

            roleUserRepository = new Sys_RoleUserRepository();

            roleMenuRepository = new Sys_RoleMenuRepository();

            roleMenuOperationRepository = new Sys_RoleMenuOperationRepository();
            base.repository = subRepository;
        }

        public Sys_Role InsertOrUpdate(Sys_Role entity)
        {
            Sys_Role campus = null;
            try
            {
                Sys_Role e = repository.GetEntityByColNameAndColValue("RoleID", entity.RoleID);
                if (e != null)
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Sys_Role>(entity, false);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion
                    e.RoleName = entity.RoleName;
                    e.UpdateTime = DateTime.Now;
                    e.UpdateUser = entity.UpdateUser;
                    e.Status = (int)Entity.CustomEntity.ConstantEntity.DataStatus.Valid;
                    campus = repository.Update(e);
                }
                else
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Sys_Role>(entity, true);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion
                    entity.RoleID = Guid.NewGuid().ToString();
                    entity.Status = (int)Entity.CustomEntity.ConstantEntity.DataStatus.Valid;
                    entity.CreateTime = DateTime.Now;
                    campus = repository.Insert(entity);
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return campus;
        }

        public bool SetUsersForRoleID(string roleID, string[] userIDs, bool isAdd)
        {
            List<Sys_RoleUser> list = new List<Sys_RoleUser>();
            foreach (var userID in userIDs)
            {
                Sys_RoleUser entity = new Sys_RoleUser();
                entity.UserID = userID;
                entity.RoleID = roleID;
                list.Add(entity);
            }
            if (isAdd)
            {
                roleUserRepository.InsertBatchBySql(list);
            }
            else
            {
                roleUserRepository.DeleteBatch(list);
            }
            return true;
        }

        public bool SetMenusForRoleID(string roleID, string[] menuIDs, bool isAdd)
        {
            List<Sys_RoleMenu> list = new List<Sys_RoleMenu>();
            foreach (var menuID in menuIDs)
            {
                Sys_RoleMenu entity = new Sys_RoleMenu();
                entity.MenuID = menuID;
                entity.RoleID = roleID;
                list.Add(entity);
            }
            if (isAdd)
            {
                roleMenuRepository.InsertBatchBySql(list);
            }
            else
            {
                roleMenuRepository.DeleteBatch(list);
            }
            return true;
        }

        public bool ChangeLockStatus(string roleID, string isLock)
        {
            try
            {
                var result = false;
                Sys_Role e = repository.GetEntityByColNameAndColValue("RoleID", roleID);
                if (e != null)
                {
                    e.IsLockUser = isLock;
                    if (subRepository.Update(e) != null)
                    {
                        result = true;
                    }
                }
                return result;
            }
            catch (Exception e)
            {
                throw e;
            }
        }


        public bool SetMenuOperationsForRoleID(string roleID, string[] menuOperationIDs, bool isAdd)
        {
            List<Sys_RoleMenuOperation> list = new List<Sys_RoleMenuOperation>();
            //逗号分割,  menuID,OperationID
            foreach (var menuOperationID in menuOperationIDs)
            {
                var mOIDs = menuOperationID.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
                if (mOIDs.Length == 2)
                {
                    Sys_RoleMenuOperation entity = new Sys_RoleMenuOperation();
                    entity.MenuID = mOIDs[0];
                    entity.OperationID = mOIDs[1];
                    entity.RoleID = roleID;
                    list.Add(entity);
                }
            }
            if (isAdd)
            {
                roleMenuOperationRepository.InsertBatchBySql(list);
            }
            else
            {
                roleMenuOperationRepository.DeleteBatch(list);
            }
            return true;
        }
    }
}
