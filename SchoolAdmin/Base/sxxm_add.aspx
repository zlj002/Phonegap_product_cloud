<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sxxm_add.aspx.cs" Inherits="Cloud_Server.Base.sxxm_add" MasterPageFile="~/Main.Master" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/lang/zh-cn/zh-cn.js"></script>
    <script src="BizJS/sxxm_add.js"></script>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="page-header">
        <h1>实训项目
                <small><i class="icon-double-angle-right"></i>&nbsp;实训项目基本信息
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
            <label class="col-sm-2 control-label">适用专业</label>
            <div class="col-sm-10">
                <input type="checkbox" />
                汽车维修 
                    <input type="checkbox" />
                机电制造与维护
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">总学时</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="总学时" style="width: 100px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">周学时</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="周学时" style="width: 100px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">总学分</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="总学分" style="width: 100px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">实训类型</label>
            <div class="col-sm-10">
                <select class="form-control" style="width: 400px;">
                    <option value="">&nbsp;</option>
                    <option value="AL" selected>实操</option>
                    <option value="AL">理论</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">考核方式</label>
            <div class="col-sm-10">
                <select class="form-control" style="width: 400px;">
                    <option value="">&nbsp;</option>
                    <option value="AL" selected>实习报告</option>
                    <option value="AL">实习鉴定</option>
                    <option value="AL">实习成绩</option>

                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">实训目的</label>
            <div class="col-sm-10">
                <script id="editor1" type="text/plain" style="height: 200px;"></script>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">实训原理</label>
            <div class="col-sm-10">
                <script id="editor2" type="text/plain" style="height: 200px;"></script>
            </div>

        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">实训资料</label>
            <div class="col-sm-10">
                <script id="editor3" type="text/plain" style="height: 200px;"></script>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">实训要求</label>
            <div class="col-sm-10">
                <script id="editor4" type="text/plain" style="height: 200px;"></script>
            </div>
        </div>

        <hr />

        <div class="row-fluid wizard-actions" >
             <a  class="btn btn-prev" href="sxxm.aspx"> 
                <i class="icon-remove"></i>
                取消 
             </a>
            <a  id="btnOK" class="btn   btn-primary" href="sxxm.aspx">
                <i class="icon-ok"></i>
                确定
            </a>
        </div>

    </form>

    <script>
        var ue1 = UE.getEditor('editor1');
        var ue2 = UE.getEditor('editor2');
        var ue3 = UE.getEditor('editor3');
        var ue4 = UE.getEditor('editor4');
    </script>

</asp:Content>
