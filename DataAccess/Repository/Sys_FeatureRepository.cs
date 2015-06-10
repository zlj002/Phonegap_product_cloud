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
    public class Sys_FeatureRepository : RootRepositoryBase<Sys_Feature>, ISys_FeatureRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Sys_FeatureRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Sys_FeatureRepository(string schoolID)
        {
            base.SchoolID = schoolID;
        }

        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Sys_FeatureRepository(string schoolID, string currentUserID)
        {
            base.SchoolID = schoolID;
            base.CurrentUserID = currentUserID;
        }


        public List<Sys_Feature> GetSys_FeatureByCurrentUser(List<string> departmentIDs, List<string> groupIDs)
        {  
            PageHelper<Sys_Feature> pageQuery = new PageHelper<Sys_Feature>();
            pageQuery.PageSize = 10000;
            base.PageSqlTable = " SELECT sf.* FROM  [Sys_Feature] sf left join Sys_Feature_Authority sfa on sfa.SchoolID = sf.SchoolID and sfa.FeatureID = sf.FeatureID "; 
           
            //所属部门
            if (departmentIDs.Count > 0)
            {
                //组合条件
                ComplexKeyValue ckV = new ComplexKeyValue();
                ckV.WhereType = KeyValueWhereType.Or;
                //当前学校 
                ckV.QueryKeyValues.Add(new KeyValue("sfa.SchoolID", base.SchoolID, KeyValueOperatorType.Equal));
                //部门
                ckV.QueryKeyValues.Add(new KeyValue("sfa.TargetType", "0", KeyValueOperatorType.Equal));
                ckV.QueryKeyValues.Add(new KeyValue("sfa.TargetID", string.Join(",", departmentIDs), KeyValueOperatorType.In));
                //放入组合条件
                pageQuery.ComplexKeyValues.Add(ckV);
            } 
            //所属用户组
            if (groupIDs.Count > 0)
            {
                //组合条件
                ComplexKeyValue ckV = new ComplexKeyValue();
                ckV.WhereType = KeyValueWhereType.Or;
                //当前学校 
                ckV.QueryKeyValues.Add(new KeyValue("sfa.SchoolID", base.SchoolID, KeyValueOperatorType.Equal));
                ckV.QueryKeyValues.Add(new KeyValue("sfa.TargetType", "1", KeyValueWhereType.And, KeyValueOperatorType.Equal));
                //组
                ckV.QueryKeyValues.Add(new KeyValue("sfa.TargetID", string.Join(",", groupIDs), KeyValueOperatorType.In));
                //放入组合条件
                pageQuery.ComplexKeyValues.Add(ckV);
            }
            //组合条件
            ComplexKeyValue ckVUser = new ComplexKeyValue();
            ckVUser.WhereType = KeyValueWhereType.Or;
            //当前学校 
            ckVUser.QueryKeyValues.Add(new KeyValue("sfa.SchoolID", base.SchoolID, KeyValueOperatorType.Equal));
            //具体用户
            ckVUser.QueryKeyValues.Add(new KeyValue("sfa.TargetType", "2", KeyValueWhereType.And, KeyValueOperatorType.Equal));
            //用户
            ckVUser.QueryKeyValues.Add(new KeyValue("sfa.TargetID", base.CurrentUserID, KeyValueOperatorType.In));
            //放入组合条件
            pageQuery.ComplexKeyValues.Add(ckVUser);

            //游客
            ckVUser = new ComplexKeyValue();
            ckVUser.WhereType = KeyValueWhereType.Or;
            //当前学校 
            ckVUser.QueryKeyValues.Add(new KeyValue("sfa.SchoolID", base.SchoolID, KeyValueOperatorType.Equal));
            //具体用户
            ckVUser.QueryKeyValues.Add(new KeyValue("sfa.TargetType", "3", KeyValueWhereType.And, KeyValueOperatorType.Equal)); 
            //放入组合条件
            pageQuery.ComplexKeyValues.Add(ckVUser);


            //通用类型菜单
            //pageQuery.QueryKeyValues.Add(new KeyValue("sf.[FeatureType]", "0", KeyValueWhereType.Or, KeyValueOperatorType.Equal));

            pageQuery.OrderBy = " DisplayIndex asc ";

            return GetListPageByCustomSql(pageQuery).Data;
        }
    }
}
