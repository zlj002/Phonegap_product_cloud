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

public partial class Admin_BasicManager_CampusManager : System.Web.UI.Page
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
            List<Basic_Campus> list = new List<Basic_Campus>();
            foreach (var item in ids)
            {
                Basic_Campus t = new Basic_Campus();
                t.CampusID = item;
                list.Add(t);
            }

            service.LogicDeleteBatch(list, "CampusID");
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
    public static InteractiveData InsertOrUpdate(Basic_Campus entity)
    {

        InteractiveData m_RetInteractiveData = new InteractiveData();

        IBasic_CampusService service = new Basic_CampusService();
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