<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="Basic_TeacherManager.aspx.cs" Inherits="Cloud_Server.Base.Basic_TeacherManager" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
    <div class="page-header">
        <h1>可爱老师 
                <small><i class="icon-double-angle-right"></i>&nbsp;管理可爱老师的信息
                </small>
        </h1>
    </div>

    <p>
        <input type="text" />
        <a class="btn btn-primary " id="btn_gzzd_add" href="#">
        查询
        </a> 
    </p>
    <table class="table table-striped table-bordered table-hover">
        <thead>
            <tr>
                <th style="width: 5%;">#</th>
                <th style="width: 20%;">姓名</th>
                <th style="width: 20%;">授课专业</th>
                <th style="width: 20%;">点赞次数</th>
                <th style="width: 20%;">举报次数</th>
                <th style="width: 10%;">操作</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td><a href="#">李老师&nbsp;&nbsp;</a><img src="../img/teacher.jpg" style="width: 150px; height: 150px;" /></td>
                <td style="vertical-align:middle;">语文</td>
                <td style="vertical-align:middle;">
                    <div class="progress" data-percent="66">
                        <div class="progress-bar" style="width: 66%;"></div>
                    </div>
                </td>
                <td style="vertical-align:middle;">
                    <div class="progress" data-percent="10">
                        <div class="progress-bar" style="width: 10%;"></div>
                    </div>
                </td>
                <td style="vertical-align:middle;">禁用</td>
            </tr>
         <tr>
                <td>2</td>
                <td><a href="#">李老师&nbsp;&nbsp;</a><img src="../img/teacher.jpg" style="width: 150px; height: 150px;" /></td>
                <td style="vertical-align:middle;">语文</td>
                <td style="vertical-align:middle;">
                    <div class="progress" data-percent="66">
                        <div class="progress-bar" style="width: 66%;"></div>
                    </div>
                </td>
                <td style="vertical-align:middle;">
                    <div class="progress" data-percent="10">
                        <div class="progress-bar" style="width: 10%;"></div>
                    </div>
                </td>
                <td style="vertical-align:middle;">禁用</td>
            </tr>

               <tr>
                <td>3</td>
                <td><a href="#">李老师&nbsp;&nbsp;</a><img src="../img/teacher.jpg" style="width: 150px; height: 150px;" /></td>
                <td style="vertical-align:middle;">语文</td>
                <td style="vertical-align:middle;">
                    <div class="progress" data-percent="66">
                        <div class="progress-bar" style="width: 66%;"></div>
                    </div>
                </td>
                <td style="vertical-align:middle;">
                    <div class="progress" data-percent="10">
                        <div class="progress-bar" style="width: 10%;"></div>
                    </div>
                </td>
                <td style="vertical-align:middle;">禁用</td>
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
