<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="Basic_NoticeManager.aspx.cs" Inherits="Cloud_Server.Base.Basic_NoticeManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-header">
        <h1>通知公告 
                <small><i class="icon-double-angle-right"></i>&nbsp;发送最新的通知公告
                </small>
        </h1>
    </div>

    <p>
        <a class="btn btn-primary " name="btn_gzzd_add" href="Basic_SendMessage.aspx">
            <i class="icon-instagram"></i>添加
        </a>

        <a class="btn btn-warning  ">
            <i class="icon-edit"></i>修改
        </a>

        <a class="btn  btn-danger  ">
            <i class="icon-remove"></i>删除
        </a>
    </p>
    <table class="table table-striped table-bordered table-hover">
        <thead>
            <tr style="font-weight: bold;">
                <td style="width: 10%">序号</td>
                <td style="width: 20%">接收范围</td>
                <td style="width: 50%">发送内容</td>
                <td style="width: 20%">发送时间</td>
            </tr>
        </thead>
        <tbody>
            <tr style="cursor: pointer">
                <td>1</td>
                <td>数学教研组</td>
                <td>请各位老师在本周末提交本学期的授课计划</td>
                <td>2014-12-12 14:50</td>
            </tr>
            <tr style="cursor: pointer">
                <td>2</td>
                <td>数学教研组</td>
                <td>请各位老师在本周末提交本学期的授课计划</td>
                <td>2014-12-12 14:50</td>
            </tr>
            <tr style="cursor: pointer">
                <td>3</td>
                <td>数学教研组</td>
                <td>请各位老师在本周末提交本学期的授课计划</td>
                <td>2014-12-12 14:50</td>
            </tr>

        </tbody>
    </table>
    <ul class="pagination pull-right no-margin">
        <li class="prev disabled">
            <a href="#">
                <i class="icon-double-angle-left"></i>
            </a>
        </li>

        <li class="active">
            <a href="#">1</a>
        </li>

        <li>
            <a href="#">2</a>
        </li>

        <li>
            <a href="#">3</a>
        </li>
        <li>
            <a href="#">4</a>
        </li>
        <li>
            <a href="#">5</a>
        </li>

        <li class="next">
            <a href="#">
                <i class="icon-double-angle-right"></i>
            </a>
        </li>
    </ul>
</asp:Content>
