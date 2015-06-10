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

public partial class Admin_BasicManager_SpecialtyManager : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static InteractiveData Delete(string[] ids)
    {

        InteractiveData m_RetInteractiveData = new InteractiveData();

        IBasic_SpecialtyService service = new Basic_SpecialtyService();
        try
        {
            List<Basic_Specialty> list = new List<Basic_Specialty>();
            foreach (var item in ids)
            {
                Basic_Specialty entity = new Basic_Specialty();
                entity.ID = item;
                list.Add(entity);

            }

            service.LogicDeleteBatch(list, "ID");
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
    public static InteractiveData InsertOrUpdate(Basic_Specialty entity)
    {

        InteractiveData m_RetInteractiveData = new InteractiveData();

        IBasic_SpecialtyService service = new Basic_SpecialtyService();
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
    public static string GetEntity(string ID)
    {

        IBasic_SpecialtyService service = new Basic_SpecialtyService();
        Basic_Specialty entity = service.GetEntityByColNameAndColValue("ID", ID);
        var newEntity = new
        {
            entity.ID,
            entity.Name,
            entity.Description
        };
        return JsonConvert.SerializeObject(newEntity);

    }
}