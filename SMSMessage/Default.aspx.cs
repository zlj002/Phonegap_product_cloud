using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BizProcess.Service;
using Entity.CustomEntity;
using Entity;
using BizProcess.Interface;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            RtnSMSMessage rtn = new SendSMSMessageService().GetRemainderSmsCount();
            smscount.Text = rtn.ReturnMessage;
        }

    }
}