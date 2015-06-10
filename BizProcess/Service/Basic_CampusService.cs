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
    public class Basic_CampusService : BaseService<Basic_Campus>, IBasic_CampusService
    {
        IBasic_CampusRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_CampusService()
        {
            subRepository = new Basic_CampusRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_CampusService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Basic_CampusRepository(base.SchoolID);
            base.repository = subRepository;
        }

        //public List<Basic_Campus> GetSchoolCampusBySchoolID()
        //{
        //    return subRepository.GetSchoolCampusBySchoolID();
        //}

        public Basic_Campus InertOrUpdateEntity(Basic_Campus entity)
        {
            Basic_Campus campus = null;
            try
            {


                Basic_Campus e = repository.GetEntityByColNameAndColValue("CampusID", entity.CampusID);
                if (e != null)
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Basic_Campus>(entity, false);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion
                    e.CampusID = entity.CampusID;
                    e.CampusName = entity.CampusName;
                    e.CampusCoords = entity.CampusCoords;
                    e.PhoneNumber = entity.PhoneNumber;
                    e.Description = entity.Description;
                    e.Status = (int)Entity.CustomEntity.ConstantEntity.DataStatus.Valid;
                    campus = repository.Update(e);
                }
                else
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Basic_Campus>(entity, true);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion
                    entity.CampusID = Guid.NewGuid().ToString();
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

        public int LogicDeleteBatchByIDs(string[] ids)
        {
            return subRepository.LogicDeleteBatchByIDs(ids);
        }
    }
}
