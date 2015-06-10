<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="Basic_KingManager.aspx.cs" Inherits="Cloud_Server.Base.Basic_KingManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-header">
        <h1>全民校草 
                <small><i class="icon-double-angle-right"></i>&nbsp;管理全部校草的信息
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
                <th style="width: 20%;">班级</th>
                <th style="width: 20%;">点赞次数</th>
                <th style="width: 20%;">举报次数</th>
                <th style="width: 10%;">操作</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>1</td>
                <td><a href="#">周杰伦&nbsp;&nbsp;</a><img src="../img/boy.jpg" style="width: 150px; height: 150px;" /></td>
                <td style="vertical-align:middle;">12级汽修三班</td>
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
                <td><a href="#">周杰伦&nbsp;&nbsp;</a><img src="../img/boy.jpg" style="width: 150px; height: 150px;" /></td>
                <td style="vertical-align:middle;">12级汽修三班</td>
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
                <td><a href="#">周杰伦&nbsp;&nbsp;</a><img src="../img/boy.jpg" style="width: 150px; height: 150px;" /></td>
                <td style="vertical-align:middle;">12级汽修三班</td>
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
