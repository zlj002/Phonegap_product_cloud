
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

public partial class Base_Basic_CampusManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static InteractiveData Delete(string[] ids)
    {

        InteractiveData m_RetInteractiveData = new InteractiveData();

        IBasic_CampusService service = new Basic_CampusService();
        try
        {
            service.LogicDeleteBatchByIDs(ids);
            m_RetInteractiveData.FinishMessage = "删除成功";
            m_RetInteractiveData.FinishFlag = 1;
        }
        catch (Exception exp)
        {
            m_RetInteractiveData.FinishFlag = 0;
            m_RetInteractiveData.FinishMessage = exp.Message;
        }
        return m_RetInteractiveData;

    }


    [WebMethod]
    public static InteractiveData InsertOrUpdate(Entity.Basic_Campus entity)
    {
        entity.SchoolID = new PageBase().CurrentSchoolID;
        InteractiveData m_RetInteractiveData = new InteractiveData();

        IBasic_CampusService service = new Basic_CampusService();
        try
        {
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
    [WebMethod]
    public static string GetEntity(string campusID)
    {

        IBasic_CampusService service = new Basic_CampusService();
        Basic_Campus entity = service.GetEntityByColNameAndColValue("CampusID", campusID);
        var newEntity = new
        {
            entity.CampusID,
            entity.CampusName,
            entity.CampusCoords,
            entity.Description,
            entity.PhoneNumber
        };
        return JsonConvert.SerializeObject(newEntity);

    }
}