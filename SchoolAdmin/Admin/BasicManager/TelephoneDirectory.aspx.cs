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

public partial class Admin_BasicManager_TelephoneDirectory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    [WebMethod]
    public static InteractiveData Delete(string[] ids)
    {

        InteractiveData m_RetInteractiveData = new InteractiveData();

        IBasic_TelephoneDirectoryService service = new Basic_TelephoneDirectoryService();
        try
        {
            List<Basic_TelephoneDirectory> list = new List<Basic_TelephoneDirectory>();
            foreach (var item in ids)
            {
                Basic_TelephoneDirectory entity = new Basic_TelephoneDirectory();
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
    public static InteractiveData InsertOrUpdate(Basic_TelephoneDirectory entity)
    {

        InteractiveData m_RetInteractiveData = new InteractiveData();

        IBasic_TelephoneDirectoryService service = new Basic_TelephoneDirectoryService();
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

        IBasic_TelephoneDirectoryService service = new Basic_TelephoneDirectoryService();
        Basic_TelephoneDirectory entity = service.GetEntityByColNameAndColValue("ID", ID);
        var newEntity = new
        {
            entity.ID,
            entity.Name,
            entity.Telephone,
            entity.ExtNumber
        };
        return JsonConvert.SerializeObject(newEntity);

    }
}