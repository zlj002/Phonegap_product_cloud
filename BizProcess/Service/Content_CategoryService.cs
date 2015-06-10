using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using BizProcess.Interface;
using BizProcess.Base.Service;
using DataAccess.Repository;
using DataAccess.Interface;
using BizProcess.Common.Validate;
using System.Transactions;

namespace BizProcess.Service
{
    public class Content_CategoryService : BaseService<Content_Category>, IContent_CategoryService
    {
        IContent_CategoryRepository subRepository;
        public Content_CategoryService()
        {
            subRepository = new Content_CategoryRepository();
            base.repository = subRepository;
        }
        public Content_CategoryService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Content_CategoryRepository(base.SchoolID);
            base.repository = subRepository;
        }
        public Content_Category InsertOrUpdate(Content_Category entity)
        {
            Content_Category oldEntity = null;
            try
            {
                Content_Category e = repository.GetEntityByColNameAndColValue("ID", entity.ID);
                if (e != null)
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Content_Category>(entity, false);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion
                    //处理需要更新的字段 
                    e.ParentID = entity.ParentID;
                    e.Name = entity.Name;
                    e.ContentPath = entity.ContentPath;
                    e.UpdateTime = DateTime.Now;

                    oldEntity = repository.Update(e);
                }
                else
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Content_Category>(entity, true);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion
                    entity.ID = Guid.NewGuid().ToString();
                   
                    entity.CreateTime = DateTime.Now;
                    entity.Status = (int)Entity.CustomEntity.ConstantEntity.DataStatus.Valid;
                    oldEntity = repository.Insert(entity);
                }

            }
            catch (Exception e)
            {
                throw e;
            }
            return oldEntity;

        }
    }
}
