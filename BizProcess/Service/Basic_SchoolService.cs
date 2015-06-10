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
    public class Basic_SchoolService: BaseService<Basic_School>, IBasic_SchoolService
    {
        IBasic_SchoolRepository subRepository;
        public Basic_SchoolService()
        {
            subRepository = new Basic_SchoolRepository();
            base.repository = subRepository;
        }

        public List<Basic_School> GetTopSchoolByName(string name, int topNumber)
        {
            return subRepository.GetTopSchoolByName(name, topNumber);
        }
    }
}
