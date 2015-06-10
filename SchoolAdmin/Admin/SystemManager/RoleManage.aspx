<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Main.Master" AutoEventWireup="true" CodeFile="RoleManage.aspx.cs" Inherits="Admin_SystemManager_Sys_RoleManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!--zTree-->
    <link href="/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <script src="/plugins/zTree_v3/js/jquery.ztree.core-3.5.min.js"></script>
    <script src="/plugins/zTree_v3/js/jquery.ztree.excheck-3.5.min.js"></script>
    <script src="/plugins/zTree_v3/js/jquery.ztree.exedit-3.5.min.js"></script>
    <!--jquery datatable-->
    <script src="/plugins/jquery.DataTables/DataTables-master/media/js/jquery.dataTables.js"></script>
    <script src="/plugins/ace/assets/js/jquery.dataTables.bootstrap.js"></script>
    <!--本页-->
    <script src="BizJS/Sys_RoleManage.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div ng-app="app" ng-controller="page">
        <div class="row">
            <div class="col-xs-12">
                <div class="table-responsive">

                    <fieldset>
                        <button type="button" class="btn btn-success" id="btnAdd" ng-click="btnAdd()">新增</button>
                        <button type="button" class="btn btn-warning" id="btnDelete" ng-click="btnDelete()">删除</button>角色名称<input name="RoleName" class="column_filter" />
                    </fieldset>
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
                                <th>角色名称</th>
                            </tr>
                        </thead>

                    </table>
                </div>
            </div>
        </div>

        <form name="myform" novalidate>
            <div class="modal fade" id="divInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false" data-backdrop="static">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title">角色</h4>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                <div class="col-xs-2">
                                    <font color="red">*</font>角色名称
                                </div>
                                <div class="col-xs-5">
                                    <input type="hidden" ng-model="role.RoleID" />
                                    <input type="text" name="RoleName" placeholder="请输入登录名" ng-model="role.RoleName" ng-maxlength="15" required />

                                </div>
                                <div class="col-xs-2">
                                    <span style="color: red;" ng-show="myform.RoleName.$dirty && myform.RoleName.$invalid">
                                        <span ng-show="myform.RoleName.$error.required">必填</span>
                                        <span ng-show="myform.RoleName.$error.maxlength">太长了</span>
                                    </span>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" ng-disabled="myform.$invalid" class="btn btn-success" ng-click="Save();">保存</button>
                        </div>
                    </div>
                </div>
            </div>
        </form> 
        <div class="modal fade " id="divUserList" tabindex="-1" role="dialog" aria-labelledby="myModalUser" aria-hidden="false"  >
            <div class="modal-dialog ">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">分配用户</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="table-responsive">
                                    <fieldset>
                                        登录名/职工号/姓名<input name="UserName" class="column_filter" />
                                    </fieldset>

                                    <table id="tableListUser" class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th class="center">
                                                    <label>
                                                        <input type="checkbox" class="ace" />
                                                        <span class="lbl"></span>
                                                    </label>
                                                </th>
                                                <th>登录名</th>
                                                <th>职工号</th>
                                                <th>姓名</th>
                                            </tr>
                                        </thead>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>

        <div class="modal fade" id="divMenu" tabindex="-1" role="dialog" aria-labelledby="myModalMenu" aria-hidden="false" >
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">分配权限</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="table-responsive">
                                    <ul id="treeDemo" class="ztree">
                                    </ul>

                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>
</asp:Content>

