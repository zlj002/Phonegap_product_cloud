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
    public class Basic_HobbyRepository : RootRepositoryBase<Basic_Hobby>, IBasic_HobbyRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Basic_HobbyRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Basic_HobbyRepository(string schoolID)
        {
            SchoolID = schoolID;
        }
         
    }
}
