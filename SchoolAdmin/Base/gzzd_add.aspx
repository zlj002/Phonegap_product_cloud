<%@ Page Language="C#" AutoEventWireup="true" CodeFile="gzzd_add.aspx.cs" Inherits="Cloud_Server.Base.gzzd_add" MasterPageFile="~/Main.Master" %>

 <asp:Content runat="server" ID="content1" ContentPlaceHolderID="head">
     <script src="BizJS/gzzd_add.js"></script>
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/lang/zh-cn/zh-cn.js"></script>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
        <div class="page-header">
            <h1>规章制度 
            <small><i class="icon-double-angle-right"></i>&nbsp; 规章制度信息
                </small>
            </h1>
        </div>

        <form class="form-horizontal" role="form">
            
            <div class="form-group">
                <label class="col-sm-2 control-label">制度名称</label>
                <div class="col-sm-10">
                    <input type="email" class="form-control" placeholder="制度名称" style="width: 400px;" />
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">详细内容</label>
                <div class="col-sm-10">
                    <script id="editor_jdzs" type="text/plain" style="  height: 300px;"></script>
                </div>
            </div>
 

        </form>

       <hr />
        <div class="row-fluid wizard-actions">
            <a id="btnCancel" class="btn btn-prev" href="gzzd.aspx">
                <i class="icon-remove"></i>
                取消
            </a>

            <a id="btnOK" class="btn   btn-primary" href="gzzd.aspx">
                <i class="icon-ok"></i>
                确定
            </a>
        </div>

    <script>
        var ue1 = UE.getEditor('editor_jdzs');

    </script>
</asp:Content>
