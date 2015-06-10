<%@ Page Language="C#" AutoEventWireup="true" CodeFile="jdzs_add.aspx.cs" Inherits="Cloud_Server.Base.jdzs_add" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ID="content1" ContentPlaceHolderID="head">
        <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/lang/zh-cn/zh-cn.js"></script>

    <script src="BizJS/jdzs_add.js"></script>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="page-header">
        <h1>鉴定站所 
                <small><i class="icon-double-angle-right"></i>鉴定站所基本信息
                </small>
        </h1>
    </div>

    <form class="form-horizontal" role="form">
        <div class="form-group">
            <label class="col-sm-2 control-label">站（所）名称</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="名称" style="width: 400px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">所属单位</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="所属单位" style="width: 400px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">建站时间</label>
            <div class="col-sm-10">
                <input type="datetime" class="form-control" style="width: 400px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">许可证号</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="许可证号" style="width: 400px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">鉴定工种</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="鉴定工种" style="width: 400px;" />
            </div>
        </div>


        <div class="form-group">
            <label class="col-sm-2 control-label">鉴定等级</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="鉴定等级" style="width: 400px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">联系人</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="联系人" style="width: 400px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">联系电话</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="联系电话" style="width: 400px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">邮编</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="邮编" style="width: 400px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">联系地址</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="联系地址" style="width: 400px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">地图坐标</label>
            <div class="col-sm-10">
                <img src="../img/dtzb.jpg" style="width: 500px; height: 300px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">详细介绍</label>
            <div class="col-sm-10">
               <script id="editor1" type="text/plain" style="height: 400px;"></script>
            </div>
        </div>

        

        <hr />
        <div class="row-fluid wizard-actions">
            <a id="btnCancel" class="btn btn-prev" href="jdzs.aspx">
                <i class="icon-remove"></i>
                取消
            </a>

            <a id="btnOK" class="btn   btn-primary" href="jdzs.aspx">
                <i class="icon-ok"></i>
                确定
            </a>
        </div>

    </form>
    <script>
        var ue1 = UE.getEditor('editor1');

    </script>

</asp:Content>
