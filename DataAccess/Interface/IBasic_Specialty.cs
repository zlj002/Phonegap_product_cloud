using DataAccess.Base.Interface;
using Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Interface
{


    public interface IBasic_Specialty : IRepository<Basic_Specialty>
    {
        /// <summary>
        /// 获取专业列表
        /// </summary>
        /// <returns></returns>
        List<Basic_Specialty> GetSpecialtyList();

        /// <summary>
        /// 获取专业设置的明细信息
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        Basic_Specialty GetSpecialtyDetail(int ID);
    }
}
