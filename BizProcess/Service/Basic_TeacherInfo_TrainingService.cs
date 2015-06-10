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
    public class Basic_TeacherInfo_TrainingService : BaseService<Basic_TeacherInfo_Training>, IBasic_TeacherInfo_TrainingService
    {
        IBasic_TeacherInfo_TrainingRepository subRepository;
        public Basic_TeacherInfo_TrainingService()
        {
            subRepository = new Basic_TeacherInfo_TrainingRepository();
            base.repository = subRepository;
        }

        public Basic_TeacherInfo_Training InsertOrUpdate(Basic_TeacherInfo_Training entity)
        {
            Basic_TeacherInfo_Training oldEntity = null;
            try
            {
                Basic_TeacherInfo_Training e = repository.GetEntityByColNameAndColValue("ID", entity.ID);
                if (e != null)
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Basic_TeacherInfo_Training>(entity, false);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion
                    //处理需要更新的字段 
                    e.TeacherID = entity.TeacherID;
                    e.Name = entity.Name;
                    e.Organization = entity.Organization;
                    e.TrainingType = entity.TrainingType;
                    e.BeginDate = entity.BeginDate;
                    e.EndDate = entity.EndDate;
                    e.Remark = entity.Remark;
                    e.UpdateTime = DateTime.Now;
                    oldEntity = repository.Update(e);
                }
                else
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Basic_TeacherInfo_Training>(entity, true);
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
