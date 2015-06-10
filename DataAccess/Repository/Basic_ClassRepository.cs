using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;
using OurHelper;

namespace DataAccess.Repository
{
    public class Basic_ClassRepository : RootRepositoryBase<Basic_Class>, IBasic_ClassRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Basic_ClassRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Basic_ClassRepository(string schoolID)
        {
            SchoolID = schoolID;
        }
         
    }
}
