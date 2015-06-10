using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Main : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    protected override void OnInit(EventArgs e)
    {
        //if (this.Request.Path.IndexOf("NoPermission") < 0 && this.Request.Path.IndexOf("Index.aspx") < 0)
        //{
        //    var url = this.Request.Path;
        //    //明细页面特殊处理//明细页面也要定位菜单位置
        //    if (url.IndexOf("_") > -1 && url.IndexOf(".")>-1)
        //    {
        //        url = url.Replace(url.Substring(url.IndexOf("_"), url.IndexOf(".")-url.IndexOf("_")), "");
        //    }
        //    if (new PageBase().CurrentUser.MenuList.Where(o => o.MenuUrl ==url).FirstOrDefault() == null)
        //    {
        //        HttpContext.Current.Response.Redirect("~/Admin/SystemManager/NoPermission.aspx");
        //    }
             
        //}
    }
}
