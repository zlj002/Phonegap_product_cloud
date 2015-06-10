<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Main.Master" AutoEventWireup="true" CodeFile="contentCategory.aspx.cs" Inherits="Admin_ContentManager_contentCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!--zTree-->
    <link href="/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <script src="/plugins/zTree_v3/js/jquery.ztree.core-3.5.min.js"></script>
    <script src="/plugins/zTree_v3/js/jquery.ztree.exedit-3.5.min.js"></script>
    <script src="/plugins/zTree_v3/js/jquery.ztree.excheck-3.5.min.js"></script>
    <!--富文本插件JS-->
    <script type="text/javascript" charset="utf-8" src="/plugins/ueditor1_4_3-utf8-net/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/plugins/ueditor1_4_3-utf8-net/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="/plugins/ueditor1_4_3-utf8-net/lang/zh-cn/zh-cn.js"></script>
    <!--右键JS-->
    <script src="/plugins/bootstrap/js/bootstrap-contextmenu.js"></script>
    <!--本页JS-->
    <script src="BizJS/conentCategory.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div ng-app="app" ng-controller="page">
        <div class="row" style="height:20px;">
            <div class="col-xs-12">
                <div class="table-responsive">
                    <div style="color:red;">提示:选中项，右键操作</div>
                </div>
            </div>
        </div>
        <ul id="tree" class="ztree" style="width: 450px; overflow: auto;" data-toggle="context" data-target="#context-menu">
        </ul>
        <div id="context-menu">
            <ul class="dropdown-menu" role="menu">
                <li><a tabindex="-1" ng-click="addTreeNode();">增加子项</a></li>
                <li><a tabindex="-1" ng-click="removeTreeNode();">删除选中项</a></li>
                <li><a tabindex="-1" ng-click="edit();">编辑选中项</a></li>
                <li><a tabindex="-1">取消</a></li>
            </ul>
        </div>


        <div class="modal fade" id="divDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false" data-backdrop="static">
            <div class="modal-dialog  ">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title"></h4>
                    </div>
                    <div class="modal-body"  style="height:100px;">
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><span style="color: red;">*</span>名称</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="名称" maxlength="20" style="width: 400px;" ng-model="entity.Name" />
                                <input type="hidden" ng-model="entity.ID" />
                            </div>
                        </div> 
                        <div class="form-group">
                            <label class="col-sm-2 control-label"><span style="color: red;"></span>路径</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" placeholder="URL,形如 /index.html" maxlength="500" style="width: 400px;" ng-model="entity.ContentPath" /> 
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <a id="btnCancel" class="btn btn-prev" data-dismiss="modal">取消
                        </a>
                        <a class="btn btn-success" ng-click="submit()">确定</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

