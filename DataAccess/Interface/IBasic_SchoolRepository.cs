using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface IBasic_SchoolRepository : IRepository<Basic_School> 
    {
        List<Basic_School> GetTopSchoolByName(string name, int topNumber);
    }
}
