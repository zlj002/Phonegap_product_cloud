using OurHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Base.Interface
{
    /// <summary> 
    /// author lorinzhang@163.com 
    /// 本类中为数据库对Service 层提供的所有操作方法，如需更多，请自行添加
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public interface IRepository<T> where T : class, new()
    {
        #region 本项目数据库操作
        /// <summary>
        /// 更新一个实例
        /// </summary>
        /// <param name="entity">对象实例</param>
        /// <returns>更新后的对象实例</returns>
        T Update(T entity);

        /// <summary>
        /// 插入一个实例
        /// </summary>
        /// <param name="entity">对象实例</param>
        /// <returns>插入后的对象实例</returns>
        T Insert(T entity);

        /// <summary>
        /// 插入的扩展方法
        /// </summary>
        /// <param name="entity">对象实例</param>
        /// <param name="isSubmit">是否现在提交修改，默认 true</param>
        /// <returns>插入后的对象实例</returns>
        T Insert(T entity, bool isSubmit);

        /// <summary>
        /// 批量物理删除
        /// </summary>
        /// <param name="list"></param>
        /// <param name="columnName"></param>
        /// <returns></returns>
        int DeleteBatch(List<T> list, string columnName);

        /// <summary>
        /// 更具多个列删除指定数据
        /// </summary>
        /// <param name="dic"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        int DelEntityByColNamesAndColValues(Dictionary<string, object> dic, params object[] parameters);


        /// <summary>
        /// 批量逻辑删除
        /// </summary>
        /// <param name="list"></param>
        /// <param name="columnName"></param>
        /// <returns></returns>
        int LogicDeleteBatch(List<T> list, string columnName);

        /// <summary>
        /// 批量插入数据库 自定义sql语句
        /// </summary>
        /// <param name="list"></param>
        /// <returns></returns>
        int InsertBatchBySql(List<T> list);


        /// <summary>
        /// 根据列名和值获取对象，（取第一个）
        /// </summary>
        /// <param name="colName"></param>
        /// <param name="colVal"></param>
        /// <returns></returns>
        T GetEntityByColNameAndColValue(string colName, object colVal);

        /// <summary>
        /// 根据多个列明和对象获取对象，（取第一个）
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
        /// 根据条件判断某表中是否存在某数据
        /// </summary>
        /// <param name="tableName"></param>
        /// <param name="sqlWhere"></param>
        /// <returns></returns>
        bool IsExists(string tableName, string sqlWhere);
         
        #endregion


    }
}
