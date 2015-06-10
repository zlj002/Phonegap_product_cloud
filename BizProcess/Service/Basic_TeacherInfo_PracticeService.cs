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
    public class Basic_TeacherInfo_PracticeService : BaseService<Basic_TeacherInfo_Practice>, IBasic_TeacherInfo_PracticeService
    {
        IBasic_TeacherInfo_PracticeRepository subRepository;
        public Basic_TeacherInfo_PracticeService()
        {
            subRepository = new Basic_TeacherInfo_PracticeRepository();
            base.repository = subRepository;
        }
         
        public Basic_TeacherInfo_Practice InsertOrUpdate(Basic_TeacherInfo_Practice entity)
        {
            Basic_TeacherInfo_Practice oldEntity = null;
            try
            {
                Basic_TeacherInfo_Practice e = repository.GetEntityByColNameAndColValue("ID", entity.ID);
                if (e != null)
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Basic_TeacherInfo_Practice>(entity, false);
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
                    e.WorkingDays = entity.WorkingDays;
                    e.NotWorkingDays = entity.NotWorkingDays;
                    e.PracticeContent = entity.PracticeContent;
                    e.Achievement = entity.Achievement;
                    e.Remark = entity.Remark;
                    e.UpdateTime = DateTime.Now;
                    oldEntity = repository.Update(e);
                }
                else
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Basic_TeacherInfo_Practice>(entity, true);
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
