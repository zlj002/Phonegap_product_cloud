using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;

namespace DataAccess.Repository
{
    public class Basic_SchoolRepository : RepositoryBase<Basic_School>, IBasic_SchoolRepository
    {
        public List<Basic_School> GetTopSchoolByName(string name, int topNumber)
        {
            List<object> list = new List<object>(); 
            string fields = " top " + topNumber + " * ";
            string whereStr = " and Name like {" + list.Count + "}";
            list.Add("%" + name + "%");
            string orderStr = " Name ";
            return this.SqlQuery(fields, whereStr, orderStr, list.ToArray());
        }
    }
}
