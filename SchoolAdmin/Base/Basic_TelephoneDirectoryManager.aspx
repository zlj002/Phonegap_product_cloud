<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="Basic_TelephoneDirectoryManager.aspx.cs" Inherits="Cloud_Server.Base.Basic_TelephoneDirectoryManager" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
    <div class="row">
        <div class="col-xs-12">
            <div class="table-responsive">
                <fieldset>
                    <legend style="font-weight:bold;">校园黄页</legend>
                    黄页名称: <input name="Name" class="column_filter" />
                    <br/><br/>
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
                            <th>名称</th>
                            <th>电话号码</th>
                            <th>分机号码</th>
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
                    <h4 class="modal-title">校园黄页</h4>
                </div>
                <div class="modal-body">
                     
                    <div class="row">
                        <div class="col-xs-2">
                            <font color="red">*</font>名称
                        </div>
                        <div class="col-xs-2">
                            <input id="ID" name="ID" type="hidden" value="0" />
                            <input id="Name" name="Name" placeholder="请输入名称" />
                        </div>
                    </div>
                  
                    <br />
                    <div class="row">
                        <div class="col-xs-2">
                            联系电话
                        </div>
                        <div class="col-xs-2">
                            <input id="Telephone" name="Telephone" placeholder="请输入联系电话" />
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-xs-2">
                            分机号码
                        </div>
                        <div class="col-xs-2">
                            <input id="ExtNumber" name="ExtNumber"  />
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-success"  id="btnSave">保存</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
