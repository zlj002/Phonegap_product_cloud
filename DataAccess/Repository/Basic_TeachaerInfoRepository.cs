using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;
using OurHelper;
using System.Data;
namespace DataAccess.Repository
{
    public class Basic_TeachaerInfoRepository : RepositoryBase<Basic_TeacherInfo>, IBasic_TeacherInfoRepository
    {
        public override OurHelper.PageHelper<Basic_TeacherInfo> GetListPage(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery)
        {
            base.PageSqlTable = "  select distinct t.*,u.LoginID  from [Basic_TeacherInfo] t inner join  [Sys_User] u on t.ID = u.ID   ";
            pageQuery.OrderBy = " UpdateTime desc ";

            return base.GetListPageByCustomSql(pageQuery);
        }

        public List<Basic_TeacherInfo> GetTeacherListByCenterID(OurHelper.PageHelper<Basic_TeacherInfo> pageQuery)
        {
            base.PageSqlTable = " SELECT t.*,c.Name AS CenterName FROM dbo.Basic_TeacherInfo t LEFT JOIN dbo.Basic_TrainingCenter c ON t.CenterID=c.ID ";
            return base.GetListPageByCustomSql(pageQuery).Data;
        }


        public List<Basic_TeacherInfo> GetTeacherListByRoomID(PageHelper<Basic_TeacherInfo> pageQuery)
        {
            base.PageSqlTable = "select distinct t.*,u.LoginID,tr.ID AS RoomID,tr.Name AS RoomName  from [Basic_TeacherInfo] t INNER join  [Sys_User] u on t.ID = u.ID INNER join [dbo].[Basic_TrainingRoom_Teacher] trt on trt.TeacherID = t.ID INNER join [dbo].[Basic_TrainingRoom] tr on tr.ID = trt.RoomID ";
            return base.GetListPageByCustomSql(pageQuery).Data;
        }

        public List<Basic_TeacherInfo> GetTeacherSexInfo(PageHelper<Basic_TeacherInfo> pageQuery)
        {
            base.PageSqlTable = @"select * from (select Sex,count(ID) as Num from [dbo].[Basic_TeacherInfo]
where status=1 and CenterID={" + base.PageParameters.Count + @"} and TeachingType=2
group by Sex)a";
            foreach (var item in pageQuery.QueryKeyValues)
            {
                if (item.Key == "CenterID")
                {
                    base.PageParameters.Add(item.Value);
                }
            }
            return base.GetListPageByCustomSql(pageQuery).Data;
        }

        public List<Basic_TeacherInfo> GetTeacherEducationInfo(PageHelper<Basic_TeacherInfo> pageQuery)
        {
            base.PageSqlTable = @"select * from (select DictCodeName Education,isnull(Num,0) Num from [dbo].[Basic_DictCode] a
left join
(
select Education,count(ID) as Num from [dbo].[Basic_TeacherInfo]
where status=1 and CenterID={" + base.PageParameters.Count + @"}
group by Education)b
on a.DictCode=b.Education where a.DictCodeType= 'DM_XL')a";
            foreach (var item in pageQuery.QueryKeyValues)
            {
                if (item.Key == "CenterID")
                {
                    base.PageParameters.Add(item.Value);
                }
            }
            return base.GetListPageByCustomSql(pageQuery).Data;
        }

        public List<Basic_TeacherInfo> GetTeacherTechnicalTitleInfo(PageHelper<Basic_TeacherInfo> pageQuery)
        {
            base.PageSqlTable = @"select * from (select DictCodeName TechnicalTitle,isnull(Num,0) Num from [dbo].[Basic_DictCode] a
left join
(
select TechnicalTitle,count(ID) as Num from [dbo].[Basic_TeacherInfo]
where status=1 and CenterID={" + base.PageParameters.Count + @"} and TeachingType=2
group by TechnicalTitle)b
on a.DictCode=b.TechnicalTitle where a.DictCodeType= 'DM_ZYJSZC')a";
            foreach (var item in pageQuery.QueryKeyValues)
            {
                if (item.Key == "CenterID")
                {
                    base.PageParameters.Add(item.Value);
                }
            }
            return base.GetListPageByCustomSql(pageQuery).Data;
        }
        public List<Basic_TeacherInfo> GetTeacherCertificateInfo(PageHelper<Basic_TeacherInfo> pageQuery)
        {
            base.PageSqlTable = @"select * from (select b as Age,count(ID) Num from(
select ID,num1+num2+num3+num4+num5 as b from(
 select ID,
 Case when Certificate1 is not null then 1 else 0 end num1,
 Case when Certificate2 is not null then 1 else 0 end num2,
 Case when Certificate3 is not null then 1 else 0 end num3,
 Case when Certificate4 is not null then 1 else 0 end num4,
 Case when Certificate5 is not null then 1 else 0 end num5
 from  [dbo].[Basic_TeacherInfo] where status=1 and CenterID={" + base.PageParameters.Count + @"} and TeachingType=2 )a
 )a group by b)a";
            foreach (var item in pageQuery.QueryKeyValues)
            {
                if (item.Key == "CenterID")
                {
                    base.PageParameters.Add(item.Value);
                }
            }
            return base.GetListPageByCustomSql(pageQuery).Data;
        }
        // 获取教师年龄段信息
        public List<Basic_TeacherInfo> GetTeacherAgeInfo(PageHelper<Basic_TeacherInfo> pageQuery)
        {
            base.PageSqlTable = @"select * from (select a.*,b.Num as Age from (
   select sum(case when datediff(year,Birthday,getdate()) between 20 and 29 then 1 else 0 end) as Num, '20-29岁' as ExpandCol
   from Basic_TeacherInfo
   where status=1 and CenterID={" + base.PageParameters.Count + @"} and TeachingType=2 and sex=0
   union all
   select 
          sum(case when datediff(year,Birthday,getdate()) between 30 and 39 then 1 else 0 end) as Num,  '30-39岁' as ExpandCol
   from Basic_TeacherInfo
   where status=1 and CenterID={" + base.PageParameters.Count + @"} and TeachingType=2 and sex=0
   union all
   select 
          sum(case when datediff(year,Birthday,getdate()) between 40 and 49  then 1 else 0 end) as Num, '40-50岁' as ExpandCol
   from Basic_TeacherInfo
   where status=1 and CenterID={" + base.PageParameters.Count + @"} and TeachingType=2 and sex=0
   union all
   select 
		  sum(case when datediff(year,Birthday,getdate()) >= 50 then 1 else 0 end) as Num, '50岁及以上' as ExpandCol
   from Basic_TeacherInfo
   where status=1 and CenterID={" + base.PageParameters.Count + @"} and TeachingType=2 and sex=0
   )a
   left join
    (
   select sum(case when datediff(year,Birthday,getdate()) between 20 and 29 then 1 else 0 end) as Num, '20-29岁' as ExpandCol
   from Basic_TeacherInfo
   where status=1 and CenterID={" + base.PageParameters.Count + @"} and TeachingType=2 and sex=1
   union all
   select 
          sum(case when datediff(year,Birthday,getdate()) between 30 and 39 then 1 else 0 end) as Num,  '30-39岁' as ExpandCol
   from Basic_TeacherInfo
   where status=1 and CenterID={" + base.PageParameters.Count + @"} and TeachingType=2 and sex=1
   union all
   select 
          sum(case when datediff(year,Birthday,getdate()) between 40 and 49  then 1 else 0 end) as Num, '40-50岁' as ExpandCol
   from Basic_TeacherInfo
   where status=1 and CenterID={" + base.PageParameters.Count + @"} and TeachingType=2 and sex=1
   union all
   select 
		  sum(case when datediff(year,Birthday,getdate()) >= 50 then 1 else 0 end) as Num, '50岁及以上' as ExpandCol
   from Basic_TeacherInfo
   where status=1 and CenterID={" + base.PageParameters.Count + @"} and TeachingType=2 and sex=1
   )b on a.ExpandCol=b.ExpandCol)a";
            foreach (var item in pageQuery.QueryKeyValues)
            {
                if (item.Key == "CenterID")
                {
                    base.PageParameters.Add(item.Value);
                }
            }
            return base.GetListPageByCustomSql(pageQuery).Data;
        }

        public List<Basic_TeacherInfo> GetTeacherWorkYearInfo(PageHelper<Basic_TeacherInfo> pageQuery)
        {
            base.PageSqlTable = @"select * from (select 
     sum(case when WorkYears < 5 then 1 else 0 end) as Num , '5年内' as ExpandCol 
from Basic_TeacherInfo
where status=1 and CenterID={" + base.PageParameters.Count + @"} and TeachingType=2
union all 
select 
     sum(case when WorkYears between 5 and 10 then 1 else 0 end) as Num ,  '5-10年' as ExpandCol 
from Basic_TeacherInfo
where status=1 and CenterID={" + base.PageParameters.Count + @"} and TeachingType=2
union all 
select 
     sum(case when WorkYears between 10 and 20  then 1 else 0 end) as Num , '10-20年' as ExpandCol 
from Basic_TeacherInfo
where status=1 and CenterID={" + base.PageParameters.Count + @"} and TeachingType=2
union all 
select 
	sum(case when WorkYears between 20 and 30  then 1 else 0 end) as Num , '20-30年' as ExpandCol 
from Basic_TeacherInfo
where status=1 and CenterID={" + base.PageParameters.Count + @"} and TeachingType=2
union all 
select 
	sum(case when WorkYears > 30 then 1 else 0 end) as Num , '30年以上' as ExpandCol 
from Basic_TeacherInfo
where status=1 and CenterID={" + base.PageParameters.Count + @"} and TeachingType=2)a";
            foreach (var item in pageQuery.QueryKeyValues)
            {
                if (item.Key == "CenterID")
                {
                    base.PageParameters.Add(item.Value);
                }
            }
            return base.GetListPageByCustomSql(pageQuery).Data;
        }


         
    }
}
