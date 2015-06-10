using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using BizProcess.Interface;
using BizProcess.Base.Service;
using DataAccess.Repository;
using DataAccess.Interface;

namespace BizProcess.Service
{
    public class Sys_School_ExtendService : BaseService<Sys_School_Extend>, ISys_School_ExtendService
    {
        ISys_School_ExtendRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Sys_School_ExtendService()
        {
            subRepository = new Sys_School_ExtendRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 默认构造
        /// </summary>
        public Sys_School_ExtendService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Sys_School_ExtendRepository(base.SchoolID);
            base.repository = subRepository;
        }


        /// <summary>
        /// 根据学校ID获取学校信息
        /// </summary>
        /// <param name="schoolID"></param>
        /// <returns></returns>
        public Sys_School_Extend GetSchoolInfoBySchoolID()
        {
            return subRepository.GetSchoolInfoBySchoolID();
        }

        /// <summary>
        /// 插入或更新
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        public Sys_School_Extend InertOrUpdateEntity(Sys_School_Extend entity)
        {
            Sys_School_Extend campus = null;
            try
            {
                Sys_School_Extend e = repository.GetEntityByColNameAndColValue("SchoolID", entity.SchoolID);
                if (e != null)
                {
 
                    e.Info = entity.Info;
                    e.Honor = entity.Honor;
                 
                    campus = repository.Update(e);
                }
                else
                {
                    #region 数据验证
                    //string valResult = ValidateHelper.ValidateObject<Basic_Campus>(entity, true);
                    //if (!string.IsNullOrEmpty(valResult))
                    //{
                    //    throw new Exception(valResult);
                    //}
                    #endregion
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
