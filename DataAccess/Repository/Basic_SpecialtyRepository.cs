using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;
using OurHelper;

namespace DataAccess.Repository
{
    public class Basic_SpecialtyRepository : RootRepositoryBase<Basic_Specialty>, IBasic_SpecialtyRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Basic_SpecialtyRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Basic_SpecialtyRepository(string schoolID)
        {
            SchoolID = schoolID;
        }
        /// <summary>
        /// 根据学校ID获取学校信息
        /// </summary>
        /// <param name="schoolID"></param>
        /// <returns></returns>


        public List<Basic_Specialty> GetSpecialtyListBySchoolID()
        {

            PageHelper<Basic_Specialty> pageQuery = new PageHelper<Basic_Specialty>();
            

            pageQuery.PageSize = 10000;
            pageQuery.QueryKeyValues.Add(new KeyValue("Status", "1", KeyValueOperatorType.Equal));
            pageQuery.QueryKeyValues.Add(new KeyValue("SchoolID", base.SchoolID, KeyValueOperatorType.Equal));
            var result = base.GetListPageByCustomSql(pageQuery);
 
            return result.Data;
             
        }

        public Basic_Specialty GetSepecialtyByID(string ID)
        {
            return this.GetEntityByColNameAndColValue("ID",ID);
             
        }


        public List<Basic_Specialty> GetListBySchoolID(ref int totalCount, ref int pageIndex, ref int pageSize)
        {
            PageHelper<Basic_Specialty> pageQuery = new PageHelper<Basic_Specialty>();
            pageQuery.PageIndex = pageIndex;
            
            pageQuery.PageSize = pageSize;
            pageQuery.QueryKeyValues.Add(new KeyValue("Status", "1", KeyValueOperatorType.Equal));
            pageQuery.QueryKeyValues.Add(new KeyValue("SchoolID", base.SchoolID, KeyValueOperatorType.Equal));
            var result = base.GetListPageByCustomSql(pageQuery);
            totalCount = result.TotalCount;
            return result.Data;
             
             
        }
         


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
            //    strWhereSql.Append("  ID in (");
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
            //return LogicDeleteBatchBySql(strWhereSql.ToString(), list.ToArray());
        }
    }
}
