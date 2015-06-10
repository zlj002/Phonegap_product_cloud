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
    public class Basic_NewsService : BaseService<Basic_News>, IBasic_NewsService
    {
        IBasic_NewsRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_NewsService()
        {
            subRepository = new Basic_NewsRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_NewsService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Basic_NewsRepository(base.SchoolID);
            base.repository = subRepository;
        }
 
        public List<Basic_News> GetListBySchoolIDAndCategoryID(string categoryID, int totalCount, int pageIndex, int pageSize)
        {
            return subRepository.GetListBySchoolIDAndCategoryID(categoryID,  totalCount, pageIndex, pageSize);
        }


        public List<Basic_News> GetMainDisplayListBySchoolID(int displaycount)
        {
            return subRepository.GetMainDisplayListBySchoolID(displaycount);
        }

        public List<Basic_News> GetCategroupTopListBySchoolID(string categoryID, int displaycount)
        {
            return subRepository.GetCategroupTopListBySchoolID(categoryID, displaycount);
        }


        
    }
}
