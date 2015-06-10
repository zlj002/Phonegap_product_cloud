using OurHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BizProcess.Base.Interface
{
    public interface IBaseService<T> where T : class, new()
    {
        /// <summary>
        /// 更新一个实例 
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        T Update(T entity);

        /// <summary>
        /// 插入一个实例 
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        T Insert(T entity);

        /// <summary>
        /// 批量插入对象
        /// </summary>
        /// <param name="list"></param>
        /// <returns></returns>
        int InsertBatchBySql(List<T> list);

        /// <summary>
        /// 判断是否存在
        /// </summary>
        /// <param name="tableName"></param>
        /// <param name="sqlWhere"></param>
        /// <returns></returns>
        bool IsExists(string tableName, string sqlWhere);

        /// <summary>
        /// 根据列名和值获取对象，（取第一个）
        /// </summary>
        /// <param name="colName"></param>
        /// <param name="colVal"></param>
        /// <returns></returns>
        T GetEntityByColNameAndColValue(string colName, object colVal);
        /// <summary>
        /// 多条件获取
        /// </summary>
        /// <param name="dicParams"></param>
        /// <returns></returns>
        T GetEntityByColNamesAndColValues(Dictionary<string, object> dicParams);
        /// <summary>
        /// 通用分页
        /// </summary>
        /// <param name="requestQuery"></param>
        /// <returns></returns>
        PageHelper<T> GetListPage(PageHelper<T> pageQuery);

        /// <summary>
        /// 批量逻辑删除
        /// </summary>
        /// <param name="list"></param>
        /// <returns></returns>
        int LogicDeleteBatch(List<T> list, string columnName);

        /// <summary>
        /// 批量物理删除
        /// </summary>
        /// <param name="list"></param>
        /// <param name="columnName"></param>
        /// <returns></returns>
        int DeleteBatch(List<T> list, string columnName);

    }
}
