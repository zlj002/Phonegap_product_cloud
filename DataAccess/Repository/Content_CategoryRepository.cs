using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;

namespace DataAccess.Repository
{
    public class Content_CategoryRepository : RootRepositoryBase<Content_Category>, IContent_CategoryRepository
    {
        public Content_CategoryRepository()
        {
        }
        public Content_CategoryRepository(string schoolID)
        {
            SchoolID = schoolID;
        }
    }
}
