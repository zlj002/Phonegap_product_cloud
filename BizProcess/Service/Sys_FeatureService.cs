using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using BizProcess.Interface;
using BizProcess.Base.Service;
using DataAccess.Repository;
using DataAccess.Interface;

namespace BizProcess.Service
{
    public class Sys_FeatureService : BaseService<Sys_Feature>, ISys_FeatureService
    {
        ISys_FeatureRepository subRepository;

        IBasic_GroupRepository subGroupRepository;

        IBasic_OrganizeRepository subOrganizeRepository;
        /// <summary>
        /// 默认构造
        /// </summary>
        public Sys_FeatureService()
        {
            subRepository = new Sys_FeatureRepository();
            subGroupRepository = new Basic_GroupRepository();
            subOrganizeRepository = new Basic_OrganizeRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 指定学校
        /// </summary>
        public Sys_FeatureService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Sys_FeatureRepository(base.SchoolID);
            subGroupRepository = new Basic_GroupRepository(base.SchoolID);
            subOrganizeRepository = new Basic_OrganizeRepository(base.SchoolID);
            base.repository = subRepository;
        }
        /// <summary>
        /// 指定学校，用户
        /// </summary>
        /// <param name="schoolID"></param>
        /// <param name="userID"></param>
        public Sys_FeatureService(string schoolID,string userID)
        {
            base.SchoolID = schoolID;
            base.CurrentUserID = userID;
            subRepository = new Sys_FeatureRepository(base.SchoolID,base.CurrentUserID);
            subGroupRepository = new Basic_GroupRepository(base.SchoolID, base.CurrentUserID);
            subOrganizeRepository = new Basic_OrganizeRepository(base.SchoolID, base.CurrentUserID);
            base.repository = subRepository;
        }


        public List<Sys_Feature> GetSys_FeatureByCurrentUser()
        {
            List <Basic_Organize> organizeList =  this.GetOrganizeByCurrentUser();
            List<Basic_Group> groupList = this.GetGroupByCurrentUser();

            return subRepository.GetSys_FeatureByCurrentUser(organizeList.Select(o => o.ID).ToList(), groupList.Select(o => o.ID).ToList());
        }


        public List<Basic_Organize> GetOrganizeByCurrentUser()
        {
            return subOrganizeRepository.GetOrganizeByCurrentUser();
        }

        public List<Basic_Group> GetGroupByCurrentUser()
        {
            return subGroupRepository.GetGroupByCurrentUser();
        }
    }
}
