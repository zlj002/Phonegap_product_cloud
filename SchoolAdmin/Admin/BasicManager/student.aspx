<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Main.Master" AutoEventWireup="true" CodeFile="student.aspx.cs" Inherits="Admin_BasicManager_student" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!--jquery datatable-->
    <script src="/plugins/jquery.DataTables/DataTables-master/media/js/jquery.dataTables.js"></script>
    <script src="/plugins/ace/assets/js/jquery.dataTables.bootstrap.js"></script>
    <!--导入上传文件-->
    <script src="../OurUpload/ajaxfileupload.js"></script>
    <!--本页-->
    <script src="BizJS/student.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div ng-app="app" ng-controller="page">
        <div class="row">
            <div class="col-xs-12">
                <div class="table-responsive">
                    
                    <button type="button" class="btn btn-warning" id="btnDelete" ng-click="btnDelete()">删除</button>
                    登录名/手机号/姓名<input name="UserName" class="column_filter" id="txtSearchUserName" />


                    <table id="tableList" class="table table-striped table-bordered table-hover">
                        <thead>
                            <tr>
                                <th class="center">
                                    <label>
                                        <input type="checkbox" class="ace" />
                                        <span class="lbl"></span>
                                    </label>
                                </th> 
                                <th>姓名</th>
                                <th>登录名</th>
                                <th>学号</th>
                                <th>手机号</th>
                            </tr>
                        </thead>

                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

