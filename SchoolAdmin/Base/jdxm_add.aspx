<%@ Page Language="C#" AutoEventWireup="true" CodeFile="jdxm_add.aspx.cs" Inherits="Cloud_Server.Base.jdxm_add" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ID="content1" ContentPlaceHolderID="head">
        <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/lang/zh-cn/zh-cn.js"></script>

    <script src="BizJS/jdxm_add.js"></script>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="page-header">
        <h1>鉴定项目 
                <small><i class="icon-double-angle-right"></i>&nbsp;鉴定项目基本信息
                </small>
        </h1>
    </div>

    <form class="form-horizontal" role="form">
        <div class="form-group">
            <label class="col-sm-2 control-label">项目名称</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="名称" style="width: 400px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">面向专业</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="面向专业" style="width: 400px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">鉴定等级</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="鉴定等级" style="width: 400px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">鉴定费用</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="鉴定费用" style="width: 400px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">报考条件</label>
            <div class="col-sm-10">
        <script id="editor1" type="text/plain" style="height: 200px;"></script>
            </div>
        </div>


        <div class="form-group">
            <label class="col-sm-2 control-label">证书名称</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="证书名称" style="width: 400px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">发证机构（或部门）</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="发证机构（或部门）" style="width: 400px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">学校该项目联系人</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="学校该项目联系人" style="width: 400px;" />
            </div>
        </div>

         

        <div class="form-group">
            <label class="col-sm-2 control-label">备注</label>
            <div class="col-sm-10">
               <script id="editor2" type="text/plain" style="height: 300px;"></script>
            </div>
        </div>

        

        <hr />
        <div class="row-fluid wizard-actions">
            <a id="btnCancel" class="btn btn-prev" href="jdxm.aspx">
                <i class="icon-remove"></i>
                取消
            </a>

            <a id="btnOK" class="btn   btn-primary" href="jdxm.aspx">
                <i class="icon-ok"></i>
                确定
            </a>
        </div>

    </form>
    <script>
        var ue1 = UE.getEditor('editor1');
        var ue2 = UE.getEditor('editor2');
    </script>

</asp:Content>
