using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface IArticleRepository : IRepository<Article> 
    {
        Article GetTuijianToday();
    }
}
