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

namespace BizProcess.Service
{
    public class Basic_TelephoneDirectoryService : BaseService<Basic_TelephoneDirectory>, IBasic_TelephoneDirectoryService
    {
        IBasic_TelephoneDirectoryRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_TelephoneDirectoryService()
        {
            subRepository = new Basic_TelephoneDirectoryRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_TelephoneDirectoryService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Basic_TelephoneDirectoryRepository(base.SchoolID);
            base.repository = subRepository;
        }

        public List<Basic_TelephoneDirectory> GetListBySchoolID()
        {
            return subRepository.GetListBySchoolID();
        }

        public Basic_TelephoneDirectory InertOrUpdateEntity(Basic_TelephoneDirectory entity)
        {
            Basic_TelephoneDirectory campus = null;
            try
            {


                Basic_TelephoneDirectory e = repository.GetEntityByColNameAndColValue("ID", entity.ID);
                if (e != null)
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Basic_TelephoneDirectory>(entity, false);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion
                    e.SchoolID = entity.SchoolID;
                    e.Name = entity.Name;
                    e.Telephone = entity.Telephone;
                    e.ExtNumber = entity.ExtNumber;
                    e.DisplayIndex = entity.DisplayIndex;
                    e.Remark = entity.Remark;
                    e.UpdateUser = entity.UpdateUser;
                    e.UpdateTime = DateTime.Now;
                    e.Status = (int)Entity.CustomEntity.ConstantEntity.DataStatus.Valid;

                    campus = repository.Update(e);
                }
                else
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Basic_TelephoneDirectory>(entity, true);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion
                    entity.ID = Guid.NewGuid().ToString();
                    entity.CreateTime = DateTime.Now;
 

                    entity.Status = 1;
                    campus = repository.Insert(entity);
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return campus;
        }
    }
}
