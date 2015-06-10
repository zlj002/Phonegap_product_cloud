using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using BizProcess.Interface;
using BizProcess.Base.Service;
using DataAccess.Repository;
using DataAccess.Interface;
using BizProcess.Common.Validate;
using OurHelper;
using Entity.CustomEntity;

namespace BizProcess.Service
{
    public class Basic_TeacherInfo_RewardService : BaseService<Basic_TeacherInfo_Reward>, IBasic_TeacherInfo_RewardService
    {
        IBasic_TeacherInfo_RewardRepository subRepository;
        public Basic_TeacherInfo_RewardService()
        {
            subRepository = new Basic_TeacherInfo_RewardRepository();
            base.repository = subRepository;
        }


        public Basic_TeacherInfo_Reward InsertOrUpdate(Basic_TeacherInfo_Reward entity)
        {
            Basic_TeacherInfo_Reward oldEntity = null;
            try
            {
                Basic_TeacherInfo_Reward e = repository.GetEntityByColNameAndColValue("ID", entity.ID);
                if (e != null)
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Basic_TeacherInfo_Reward>(entity, false);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion
                    //处理需要更新的字段 
                    e.TeacherID = entity.TeacherID;
                    e.Name = entity.Name;
                    e.RewardLevel = entity.RewardLevel;
                    e.RewardType = entity.RewardType;
                    e.Role = entity.Role;
                    e.RewardName = entity.RewardName;
                    e.Company = entity.Company;
                    e.GetDate = entity.GetDate;
                    e.Remark = entity.Remark;
                    e.UpdateTime = DateTime.Now;
                    oldEntity = repository.Update(e);
                }
                else
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Basic_TeacherInfo_Reward>(entity, true);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion
                    entity.ID = Guid.NewGuid().ToString();
                    entity.CreateTime = DateTime.Now;
                    entity.Status = (int)Entity.CustomEntity.ConstantEntity.DataStatus.Valid;

                    oldEntity = repository.Insert(entity);
                }

            }
            catch (Exception e)
            {
                throw e;
            }
            return oldEntity;
        }
    }
}
