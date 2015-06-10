using BizProcess.Interface;
using BizProcess.Service;
using Entity;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cloud_Server.Base
{
    public partial class Basic_SchoolInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /// <summary>
        /// 获取学校概况
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public static string GetEntity()
        {
            ISys_School_ExtendService service = new Sys_School_ExtendService();
            Sys_School_Extend entity = service.GetEntityByColNameAndColValue("SchoolID", new PageBase().CurrentSchoolID);
            var newEntity = new
            {
                entity.SchoolID,
                entity.Info,
                entity.Honor
            };
            return JsonConvert.SerializeObject(newEntity);
        }

        /// <summary>
        /// 插入或更新学校概况
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        [WebMethod]
        public static string InsertOrUpdate(Sys_School_Extend entity)
        {

            entity.SchoolID = new PageBase().CurrentSchoolID;

            ISys_School_ExtendService service = new Sys_School_ExtendService();
            try
            {
                service.InertOrUpdateEntity(entity);
                var result = new
                {
                    ReturnFlag = 1,
                    ReturnMessage = "操作成功"
                };
                return JsonConvert.SerializeObject(result);
            }
            catch (Exception exp)
            {
                var result = new
                {
                    ReturnFlag = 0,
                    ReturnMessage = exp
                };
                return JsonConvert.SerializeObject(result);
            }

        }
    }
}