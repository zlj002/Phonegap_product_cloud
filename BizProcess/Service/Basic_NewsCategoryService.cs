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
    public class Basic_NewsCategoryService : BaseService<Basic_NewsCategory>, IBasic_NewsCategoryService
    {
        IBasic_NewsCategoryRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_NewsCategoryService()
        {
            subRepository = new Basic_NewsCategoryRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_NewsCategoryService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Basic_NewsCategoryRepository(base.SchoolID);
            base.repository = subRepository;
        }



        public List<Basic_NewsCategory> GetListBySchoolID()
        {
            return subRepository.GetListBySchoolID();
        }
    }
}
