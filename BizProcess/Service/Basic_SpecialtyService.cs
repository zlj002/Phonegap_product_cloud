using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using BizProcess.Interface;
using BizProcess.Base.Service;
using DataAccess.Repository;
using DataAccess.Interface;
using OurHelper;
using BizProcess.Common.Validate;

namespace BizProcess.Service
{
    public class Basic_SpecialtyService : BaseService<Basic_Specialty>, IBasic_SpecialtyService
    {
        IBasic_SpecialtyRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_SpecialtyService()
        {
            subRepository = new Basic_SpecialtyRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_SpecialtyService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Basic_SpecialtyRepository(base.SchoolID);
            base.repository = subRepository;
        }

        public List<Basic_Specialty> GetSpecialtyListBySchoolID()
        {
            return subRepository.GetSpecialtyListBySchoolID();
        }

        public Basic_Specialty GetSepecialtyByID(string ID)
        {
            return subRepository.GetSepecialtyByID(ID);
        }


        public List<Basic_Specialty> GetListBySchoolID(ref int totalCount, ref int pageIndex, ref int pageSize)
        {
            return subRepository.GetListBySchoolID(ref totalCount, ref pageIndex, ref pageSize);
        }



        public int LogicDeleteBatchByIDs(string[] ids)
        {
            return subRepository.LogicDeleteBatchByIDs(ids);
        }


        public Basic_Specialty InertOrUpdateEntity(Basic_Specialty entity)
        {
            Basic_Specialty Specialty = null;
            try
            {


                Basic_Specialty e = repository.GetEntityByColNameAndColValue("ID", entity.ID);
                if (e != null)
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Basic_Specialty>(entity, false);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion
                    e.ID = entity.ID;
                    e.Name = entity.Name;
                    e.Description = entity.Description;
                    e.Status = (int)Entity.CustomEntity.ConstantEntity.DataStatus.Valid;
                    Specialty = repository.Update(e);
                }
                else
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Basic_Specialty>(entity, true);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion
                    entity.ID = Guid.NewGuid().ToString();
                    entity.CreateTime = DateTime.Now;
                    entity.Status = 1;
                    Specialty = repository.Insert(entity);
                }
            }
            catch (Exception e)
            {
                throw e;
            }
            return Specialty;
        }
    }
}
