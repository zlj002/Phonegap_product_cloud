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
    public class Message_RegisterMobileRepository : RootRepositoryBase<Message_RegisterMobile>, IMessage_RegisterMobileRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Message_RegisterMobileRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Message_RegisterMobileRepository(string schoolID)
        {
            SchoolID = schoolID;
        }


        //public override PageHelper<Message_RegisterMobile> GetListPage(PageHelper<Message_RegisterMobile> pageQuery)
        //{
        //    //处理查询条件
        //    if (pageQuery.QueryKeyValue.ContainsKey("MobileNumber"))
        //    {
        //        pageQuery.SqlWhere += "  and MobileNumber={" + pageQuery.Parameters.Count + "} ";
        //        pageQuery.Parameters.Add(pageQuery.QueryKeyValue["MobileNumber"] );
        //    }
        //    if (pageQuery.QueryKeyValue.ContainsKey("MessageCode"))
        //    {
        //        pageQuery.SqlWhere += "  and MessageCode={" + pageQuery.Parameters.Count + "} ";
        //        pageQuery.Parameters.Add(pageQuery.QueryKeyValue["MessageCode"]);
        //    }
        //    pageQuery.SqlWhere += "  and SchoolID = {" + pageQuery.Parameters.Count + "} ";
        //    pageQuery.Parameters.Add(base.SchoolID);

        //    return base.GetListPage(pageQuery);
        //}

        public void DeleteMessageCodeByMobileNumber(string mobileNumber)
        {
            StringBuilder sqlWhere = new StringBuilder();
            List<object> list = new List<object>();
            
            sqlWhere.Append(" MobileNumber = {" + list.Count + "} ");
            list.Add(mobileNumber);

            this.DeleteBatchBySqlWhere(sqlWhere.ToString(), list.ToArray());
        }
    }
}
