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
using OurHelper;

namespace BizProcess.Service
{
    public class Content_ArticleService : BaseService<Content_Article>, IContent_ArticleService
    {
        IContent_ArticleRepository subRepository;
        public Content_ArticleService()
        {
            subRepository = new Content_ArticleRepository();
            base.repository = subRepository;
        }
        public Content_ArticleService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Content_ArticleRepository(base.SchoolID);
            base.repository = subRepository;
        }
        public Content_Article InsertOrUpdate(Content_Article entity)
        {
            Content_Article oldEntity = null;
            try
            {
                Content_Article e = repository.GetEntityByColNameAndColValue("ID", entity.ID);
                if (e != null)
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Content_Article>(entity, false);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion
                    //处理需要更新的字段  
                    e.Title = entity.Title;
                    e.CategoryID = entity.CategoryID;
                    e.RecommendType = entity.RecommendType;
                    e.CoverImage = entity.CoverImage;
                    e.BrowseCount = entity.BrowseCount;
                    e.Digest = entity.Digest;
                    //如果为输入则截取内容前部门
                    if (string.IsNullOrEmpty(entity.Digest) && !string.IsNullOrEmpty(entity.ArticleContent))
                    {
                        var contentTemp = HTMLTools.HTMLTextClearStyle(entity.ArticleContent);
                        e.Digest = contentTemp.Length > 49 ? contentTemp.Substring(0, 49) : contentTemp;
                    }
                    //幻灯片
                    e.Content_ArticleSlide.Clear();
                    foreach (var item in entity.Content_ArticleSlide)
                    {
                        item.ArticleID = e.ID;
                        item.SlideID = Guid.NewGuid().ToString();
                    }
                    e.Content_ArticleSlide = entity.Content_ArticleSlide;


                    e.SourceUrl = entity.SourceUrl;
                    e.ArticleContent = entity.ArticleContent;
                    e.DisplayIndex = entity.DisplayIndex;
                    e.PublishTime = entity.PublishTime;


                    e.UpdateTime = DateTime.Now;

                    oldEntity = repository.Update(e);
                }
                else
                {
                    #region 数据验证
                    string valResult = ValidateHelper.ValidateObject<Content_Article>(entity, true);
                    if (!string.IsNullOrEmpty(valResult))
                    {
                        throw new Exception(valResult);
                    }
                    #endregion
                    //如果为输入则截取内容前部门
                    if (string.IsNullOrEmpty(entity.Digest) && !string.IsNullOrEmpty(entity.ArticleContent))
                    {
                        var contentTemp = HTMLTools.HTMLTextClearStyle(entity.ArticleContent);
                        entity.Digest = contentTemp.Length > 49 ? contentTemp.Substring(0, 49) : contentTemp;
                    }
                   


                    entity.ID = Guid.NewGuid().ToString();


                    //幻灯片
                    foreach (var item in entity.Content_ArticleSlide)
                    {
                        item.ArticleID = entity.ID;
                        item.SlideID = Guid.NewGuid().ToString();
                    }

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


        public Content_Article UpdateRecommendTypeStatus(string id, string remmendType)
        {
            var entity = subRepository.GetEntityByColNameAndColValue("id", id);
            entity.RecommendType = remmendType;
            return subRepository.Update(entity);
        }

        public Content_Article AddArticleBySchoolIDAndSchoolKey(Content_Article article, string schoolID, string schoolKey)
        {
            //检查key是否正确
            Message_SchoolKeys keys = new Message_SchoolKeysService().GetSchoolKeysBySchoolIDAndKey(schoolID, schoolKey);
            if (keys == null)
            {
                throw new Exception("key错误");
            }
            //插入新闻
            return InsertOrUpdate(article);
        }
    }
}
