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
    public class Basic_StudentService : BaseService<Basic_Student>, IBasic_StudentService
    {
        IBasic_StudentRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_StudentService()
        {
            subRepository = new Basic_StudentRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_StudentService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Basic_StudentRepository(base.SchoolID);
            base.repository = subRepository;
        }


        public Basic_Student GetStudentInfoByID(string ID)
        {
            return subRepository.GetStudentInfoByID(ID);
        }
    }
}
