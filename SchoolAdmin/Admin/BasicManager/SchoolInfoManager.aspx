﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Main.Master" AutoEventWireup="true" CodeFile="SchoolInfoManager.aspx.cs" Inherits="Admin_BasicManager_SchoolInfoManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1>学校概况</h1>
    <script id="editor1" type="text/plain" style="width: 1024px; height: 500px;"></script>
    <h1>学校荣誉</h1>
    <script id="editor2" type="text/plain" style="width: 1024px; height: 500px;"></script>
    <br />
    <button type="button" class="btn btn-success" id="btnSave">保存</button>
    <script type="text/javascript" charset="utf-8" src="/plugins/ueditor1_4_3-utf8-net/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/plugins/ueditor1_4_3-utf8-net/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="/plugins/ueditor1_4_3-utf8-net/lang/zh-cn/zh-cn.js"></script>
    <script src="/plugins/ueditor1_4_3-utf8-net/ourcustom.js"></script>

    <script src="BizJS/SchoolInfoManager.js"></script>

</asp:Content>
