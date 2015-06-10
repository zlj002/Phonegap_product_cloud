using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;

namespace DataAccess.Repository
{
    public class Basic_DictCodeRepository : RepositoryBase<Basic_DictCode>, IBasic_DictCodeRepository
    {

        public override OurHelper.PageHelper<Basic_DictCode> GetListPage(OurHelper.PageHelper<Basic_DictCode> pageQuery)
        {
            //base.PageSqlTable = " select * from ( "
            //                      + " SELECT c.* FROM dbo.Basic_DictCode c "
            //                      + " INNER JOIN dbo.Basic_DictCodeType t ON c.DictCodeType=t.DictCodeType "
            //                    + " ) A ";
            base.PageSqlTable = "SELECT c.* FROM dbo.Basic_DictCode c  INNER JOIN dbo.Basic_DictCodeType t ON c.DictCodeType=t.DictCodeType";
            pageQuery.OrderBy = "DictCode";
            return base.GetListPage(pageQuery);
        }
    }
}
