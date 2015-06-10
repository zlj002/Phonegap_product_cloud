<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="Basic_SchoolInfo.aspx.cs" Inherits="Cloud_Server.Base.Basic_SchoolInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/lang/zh-cn/zh-cn.js"></script>
    <script src="BizJS/Basic_SchoolInfo.js"></script>
    <%--<script src="BizJS/sxzx_add.js"></script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div ng-app="app" ng-controller="page">
        <div class="page-header">
            <h1>学校概况 
                <small><i class="icon-double-angle-right"></i>&nbsp;维护学校的基本信息
                </small>
            </h1>
        </div>

        <div>
            <img src="../img/venusoft.jpg" />
            <span style="font-size: 18px; font-weight: bold; margin-left: 10px;">晨星团队</span>
        </div>

        <h1>学校概况</h1>
        <script id="editor1" type="text/plain" style="width: 800px; height: 400px;"></script>


        <h1>学校荣誉</h1>
        <script id="editor2" type="text/plain" style="width: 800px; height: 400px;"></script>
        <br />


        <button type="button" class="btn btn-success" id="btnSave">保存</button>

    </div>
    <script>
        var ue1 = UE.getEditor('editor1');
        var ue2 = UE.getEditor('editor2');
    </script>
</asp:Content>
