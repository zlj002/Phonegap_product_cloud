<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="Basic_CampusManager.aspx.cs" Inherits=" Base_Basic_CampusManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/plugins/jquery.DataTables/DataTables-master/media/js/jquery.dataTables.js"></script>
    <script src="/plugins/ace/assets/js/jquery.dataTables.bootstrap.js"></script>
    <script src="BizJS/Basic_CampusManager.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-header">
        <h1>校区管理 
                <small><i class="icon-double-angle-right"></i>&nbsp;维护各个校区的坐标
                </small>
        </h1>
    </div>

    <div class="row">
        <div class="col-xs-12">
            <div class="table-responsive">
                <fieldset>
                    校区名称<input name="CampusName" class="column_filter" />
                    <br />
                    <br />
                </fieldset>
                <fieldset>
                    <legend>操作</legend>
                    <a class="btn btn-primary" href="#divInfo" data-toggle="modal">新 增
                    </a>
                    <button type="button" class="btn btn-warning" id="btnDelete">删除</button>
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
                            <th>校区名称</th>
                            <th>校区坐标</th>
                        </tr>
                    </thead>

                </table>
            </div>
        </div>
    </div>

    <div class="modal fade" id="divInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">校区</h4>
                </div>
                <div class="modal-body">

                    <div class="row">
                        <div class="col-xs-2">
                            <font color="red">*</font>校区名称
                        </div>
                        <div class="col-xs-2">
                            <input id="CampusID" name="CampusID" type="hidden" value="0" />
                            <input id="CampusName" name="CampusName" placeholder="请输入校区名称" />
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-xs-2">
                            校区坐标
                        </div>
                        <div class="col-xs-2">
                            <input id="CampusCoords" name="CampusCoords" placeholder="请输入校区坐标" />
                            <a href="http://api.map.baidu.com/lbsapi/getpoint/index.html" target="_blank">去拾取坐标</a>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-xs-2">
                            联系电话
                        </div>
                        <div class="col-xs-2">
                            <input id="PhoneNumber" name="PhoneNumber" placeholder="请输入联系电话" />
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-xs-2">
                            校区描述
                        </div>
                        <div class="col-xs-2">

                            <textarea id="Description" name="Description" cols="50" rows="10"></textarea>
                        </div>
                    </div>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-success" id="btnSave">保存</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
