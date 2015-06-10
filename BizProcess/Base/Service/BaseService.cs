using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using DataAccess.Base.Interface;
using BizProcess.Common.Validate;
using Entity;
using OurHelper;

namespace BizProcess.Base.Service
{
    public class BaseService<T> : IBaseService<T> where T : class,new()
    {
        //日志
        public Sys_Log log = new Sys_Log();

        //操作类
        public IRepository<T> repository;

        //学校ID
        public string SchoolID { get; set; }

        /// <summary>
        /// 当前用户
        /// </summary>
        public string CurrentUserID { get; set; }

        public T Update(T entity)
        {
            //验证
            string valResult = ValidateHelper.ValidateObject<T>(entity, false);
            if (!string.IsNullOrEmpty(valResult))
            {
                throw new Exception(valResult);
            }

            return repository.Update(entity);
        }

        public T Insert(T entity)
        {
            //验证
            string valResult = ValidateHelper.ValidateObject<T>(entity);
            if (!string.IsNullOrEmpty(valResult))
            {
                throw new Exception(valResult);
            }

            return repository.Insert(entity);
        }



        public int InsertBatchBySql(List<T> list)
        {
            return repository.InsertBatchBySql(list);
        }


        public bool IsExists(string tableName, string sqlWhere)
        {
            return repository.IsExists(tableName, sqlWhere);
        }

        public T GetEntityByColNameAndColValue(string colName, object colVal)
        {
            return repository.GetEntityByColNameAndColValue(colName, colVal);
        }
         
        public PageHelper<T> GetListPage(PageHelper<T> pageQuery)
        {
            return repository.GetListPage(pageQuery);
        }

        public int LogicDeleteBatch(List<T> list, string columnName)
        {
            return repository.LogicDeleteBatch(list, columnName);
        }
        public int DeleteBatch(List<T> list, string columnName)
        {
            return repository.DeleteBatch(list, columnName);
        }


        public T GetEntityByColNamesAndColValues(Dictionary<string, object> dicParams)
        {
            return repository.GetEntityByColNamesAndColValues(dicParams);
        }
    }
}
