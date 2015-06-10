<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="Basic_SpecialtyManager.aspx.cs" Inherits="Cloud_Server.Base.Basic_SpecialtyManager" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/lang/zh-cn/zh-cn.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

         <div class="page-header">
        <h1>专业介绍 
                <small><i class="icon-double-angle-right"></i>&nbsp;维护学校的各专业信息
                </small>
        </h1>
    </div>

      <div class="row">
        <div class="col-xs-12">
            <div class="table-responsive">
                <fieldset>
                    
                    专业名称: <input name="Name1" class="column_filter" />
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
                            <th class="center" style="width:8%">
                                <label>
                                    <input type="checkbox" class="ace" />
                                    <span class="lbl"></span>
                                </label>
                            </th>
                            <th style="width:8%">操作</th>
                            <th style="width:14%">专业名称</th>
                            <th style="width:70%">查看详细</th>
                        </tr>
                    </thead>

                </table>
            </div>
        </div>
    </div>

    <div class="modal fade" id="divInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"   >
        <div class="modal-dialog" >
            <div class="modal-content" style="width:850px;">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">专业介绍</h4>
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
                   <script id="Description" type="text/plain" style="width: 650px; height: 500px;"></script>
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
       <script>
           var ue1 = UE.getEditor('Description');
    </script>
</asp:Content>
