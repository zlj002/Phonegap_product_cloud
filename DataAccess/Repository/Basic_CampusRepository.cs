using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;

namespace DataAccess.Repository
{
    public class Basic_CampusRepository : RootRepositoryBase<Basic_Campus>, IBasic_CampusRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Basic_CampusRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Basic_CampusRepository(string schoolID)
        {
            SchoolID = schoolID;
        }
       

        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="ids"></param>
        /// <returns></returns>
        public int LogicDeleteBatchByIDs(string[] ids)
        {
            return 1;
            //#region 拼Sql语句
            //var strWhereSql = new StringBuilder();
            //List<object> list = new List<object>();
            ////避免注入
            ////构造in条件
            //if (ids.Length > 0)
            //{
            //    strWhereSql.Append("  CampusID in (");
            //    for (int i = 0; i < ids.Length; i++)
            //    {
            //        if (i == 0)
            //        {
            //            strWhereSql.Append(" {" + i + "} ");
            //        }
            //        else
            //        {
            //            strWhereSql.Append(" ,{" + i + "} ");
            //        }
            //        list.Add(ids[i]);
            //    }
            //    strWhereSql.Append(" )");
            //}
            //#endregion
            //return base.LogicDeleteBatch( );
        }
    }
}
