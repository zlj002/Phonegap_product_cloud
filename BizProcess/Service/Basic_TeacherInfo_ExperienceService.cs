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
    public class Basic_TeacherInfo_ExperienceService : BaseService<Basic_TeacherInfo_Experience>, IBasic_TeacherInfo_ExperienceService
    {
        IBasic_TeacherInfo_ExperienceRepository subRepository;
        public Basic_TeacherInfo_ExperienceService()
        {
            subRepository = new Basic_TeacherInfo_ExperienceRepository();
            base.repository = subRepository;
        }


        public Basic_TeacherInfo_Experience InsertOrUpdate(Basic_TeacherInfo_Experience entity)
        {
            Basic_TeacherInfo_Experience oldEntity = null;
            try
            {
                Basic_TeacherInfo_Experience e = repository.GetEntityByColNameAndColValue("ID", entity.ID);
                if (e != null)
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Basic_TeacherInfo_Experience>(entity, false);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion
                    //处理需要更新的字段 
                    e.TeacherID = entity.TeacherID;
                    e.CompanyName = entity.CompanyName;
                    e.BeginDate = entity.BeginDate;
                    e.EndDate = entity.EndDate;
                    e.WorkType = entity.WorkType;
                    e.CompanyName = entity.CompanyName;
                    e.Industry = entity.Industry;
                    e.Remark = entity.Remark;
                    e.UpdateTime = DateTime.Now;
                    oldEntity = repository.Update(e);
                }
                else
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Basic_TeacherInfo_Experience>(entity, true);
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
