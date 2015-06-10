<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Main.Master" AutoEventWireup="true" CodeFile="teacher.aspx.cs" Inherits="Admin_BasicManager_teacher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!--jquery datatable-->
    <script src="/plugins/jquery.DataTables/DataTables-master/media/js/jquery.dataTables.js"></script>
    <script src="/plugins/ace/assets/js/jquery.dataTables.bootstrap.js"></script>
    <!--导入上传文件-->
    <script src="../OurUpload/ajaxfileupload.js"></script>
    <!--本页-->
    <script src="BizJS/teacher.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div ng-app="app" ng-controller="page">
        <div class="row">
            <div class="col-xs-12">
                <div class="table-responsive">
                    <button type="button" class="btn btn-info" id="btnImport" ng-click="Import()">导入</button>
                    <button type="button" class="btn btn-success" id="btnAdd" onclick="javascript:window.location.href='teacher_add.aspx'">新增</button>
                    <button type="button" class="btn btn-warning" id="btnDelete" ng-click="btnDelete()">删除</button>
                    登录名/职工号/姓名<input name="UserName" class="column_filter" id="txtSearchUserName" />


                    <table id="tableList" class="table table-striped table-bordered table-hover">
                        <thead>
                            <tr>
                                <th class="center">
                                    <label>
                                        <input type="checkbox" class="ace" />
                                        <span class="lbl"></span>
                                    </label>
                                </th>
                                <th>操作</th>
                                <th>姓名</th>
                                <th>登录名</th>
                                <th>职工号</th>
                                <th>办公电话</th>
                            </tr>
                        </thead>

                    </table>
                </div>
            </div>
        </div>

        <div class="modal fade" id="importDiv" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #F1F1F1;">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title" style="width: 160px; margin: 0 auto;">批量导入</h4>
                    </div>
                    <div style="width: 100%; overflow: auto; padding-top: 30px;">

                        <table style="margin: 0 auto; text-align: center;">
                            <tr>
                                <td>
                                    <input type="file" id="fileupload" name="fileupload" style="width: 220px;" />
                                </td>
                                <td style="padding-left: 20px;">
                                    <button type="button" class="btn btn-app btn-info btn-sm" id="btnfileupload" ng-click="StartImport()"><i class="icon-cloud-upload bigger-200"></i>上传</button>
                                </td>
                            </tr>
                        </table>
                        <a href="../OurUpload/ImportTemplete/importTemplete.xlsx" style="font-size: 12px; margin-left: 10px;">下载导入模版</a>

                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">返回</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

