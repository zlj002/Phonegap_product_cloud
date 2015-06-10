<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Main.Master" AutoEventWireup="true" CodeFile="contentArticle.aspx.cs" Inherits="Admin_ContentManager_contentArticle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!--jquery datatable-->
    <script src="/plugins/jquery.DataTables/DataTables-master/media/js/jquery.dataTables.js"></script>
    <script src="/plugins/ace/assets/js/jquery.dataTables.bootstrap.js"></script>
    <!--分页插件-->
    <script src="/plugins/bootstrap/js/bootstrap-paginator.js"></script>
    <!--zTree-->
    <link href="/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <script src="/plugins/zTree_v3/js/jquery.ztree.core-3.5.min.js"></script>
    <script src="/plugins/zTree_v3/js/jquery.ztree.exedit-3.5.min.js"></script>
    <script src="/plugins/zTree_v3/js/jquery.ztree.excheck-3.5.min.js"></script>
    <!--本页-->
    <link href="style/contentArticle.css" rel="stylesheet" />
    <script src="BizJS/contentArticle.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div ng-app="app" ng-controller="page">
        <div class="row">
            <div class="col-xs-12">
                <div class="table-responsive">


                    <div class="form-group">

                        <label class="col-sm-5 control-label no-padding-right" for="form-field-1" style="width: 450px;">
                            <button type="button" class="btn btn-success" id="btnAdd" onclick="javascript:window.location.href='contentArticle_add.aspx'">新增</button>
                            <button type="button" class="btn btn-warning" id="btnDelete" ng-click="btnDelete()">删除</button>
                            &nbsp;&nbsp;标题:&nbsp;<input name="Title" class="column_filter" id="txtTitle" />&nbsp;&nbsp;&nbsp;&nbsp;所属栏目:</label>
                        <div class="col-sm-5" style="width: 300px; padding-top: 4px;">
                            <input id="citySel" type="text" value="点击选择栏目" style="width: 200px;" ng-click="showMenu();" readonly="readonly" />
                            <div id="menuContent" class="menuContent" style="display: none; position: absolute; z-index: 10000; background-color: #f0f6e4;">
                                <ul id="tree" class="ztree" style="width: 200px;">
                                </ul>
                            </div>
                            全选<input type="checkbox" id="checkAll" ng-click="checkAll($event.target);" />
                        </div>

                    </div>

                    <div class="imglist" id="imgList">
                        <ul style="margin-left: 10px;">
                            <li ng-repeat="entity in list">
                                <div class="details" style="height: 310px;">
                                    <div class="check">
                                        <input type="checkbox" articleid="{{entity.ID}}" />
                                    </div>
                                    <div class="pic">
                                        <a href="contentArticle_add.aspx?id={{entity.ID}}">
                                            <img ng-src="{{entity.CoverImage}}" onerror="javascript:this.src='/images/NoImage.jpg'" style="height: 160px; width: 200px;" /></a>
                                    </div>
                                    <i class="absbg"></i>
                                    <h1 style="padding-top: 1px;" title="{{entity.Title}}"><span><a style="cursor: pointer; color: #fff" href="contentArticle_add.aspx?id={{entity.ID}}">{{entity.Title}}
                                    </a></span></h1>
                                    <div class="remark" title="{{entity.Digest}}">
                                        <a href="contentArticle_add.aspx?id={{entity.ID}}">{{entity.Digest}}</a>
                                    </div>
                                    <div>
                                        <a ng-class="{true: 'btn btn-primary', false: 'btn'}[entity.isTop]" ng-click="changeRecommend(entity,'top')" title="设置置顶">
                                            <i class="icon-arrow-up"></i>
                                        </a>
                                        <a ng-class="{true: 'btn btn-primary', false: 'btn'}[entity.isRecommend]" ng-click="changeRecommend(entity,'recommend')" title="设置推荐">
                                            <i class="icon-thumbs-up"></i>
                                        </a>
                                        <a ng-class="{true: 'btn btn-primary', false: 'btn'}[entity.isHot]" ng-click="changeRecommend(entity,'hot')" title="设置热门">
                                            <i class="icon-fire"></i>
                                        </a>
                                        <a ng-class="{true: 'btn btn-primary', false: 'btn'}[entity.isSlide]" ng-click="changeRecommend(entity,'slide')" title="设置幻灯片">
                                            <i class="icon-film"></i>
                                        </a>
                                    </div>
                                    <p ng-if="entity.PublishTime!=''" style="color: blue;">
                                        发布时间:{{entity.PublishTime}} 
                                    </p>
                                </div>
                            </li>


                        </ul>

                    </div>
                    <div class="col-lg-12">
                        <div class="col-lg-6" style="text-align:right;">
                            <ul id="pageList"></ul>
                        </div>
                        <div class="col-lg-6" style="text-align:left;"><span style="vertical-align: middle;line-height:77px;vertical-align:middle;font-size:15px">共{{pageDesc.totalCount}}条数据,共{{pageDesc.pageCount}}页，当前第{{pageDesc.pageIndex}}页</span></div>
                    </div>





                </div>
            </div>
        </div>


    </div>
</asp:Content>

