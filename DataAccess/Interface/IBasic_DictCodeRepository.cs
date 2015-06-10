using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface IBasic_DictCodeRepository : IRepository<Basic_DictCode>
    {
        /// <summary>
        /// 根据字典类型获取字典列表
        /// </summary>
        /// <param name="codeType"></param>
        /// <returns></returns>
        //List<Basic_DictCode> GetListByDicCodeType(string codeType);
    }
}
