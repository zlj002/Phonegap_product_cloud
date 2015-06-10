using BizProcess.Interface;
using BizProcess.Service;
using Entity;
using Newtonsoft.Json;
using OurHelper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_BasicManager_SchoolInfoManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static string GetEntity(int id)
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
    [WebMethod]
    public static InteractiveData InsertOrUpdate(Sys_School_Extend entity)
    {

        InteractiveData m_RetInteractiveData = new InteractiveData();

        ISys_School_ExtendService service = new Sys_School_ExtendService();
        try
        {
            entity.SchoolID = new PageBase().CurrentSchoolID;
            service.InertOrUpdateEntity(entity);
            m_RetInteractiveData.FinishMessage = "保存成功";
            m_RetInteractiveData.FinishFlag = 1;
        }
        catch (Exception exp)
        {
            m_RetInteractiveData.FinishFlag = 0;
            m_RetInteractiveData.FinishMessage = exp.Message;
        }
        return m_RetInteractiveData;

    }
}