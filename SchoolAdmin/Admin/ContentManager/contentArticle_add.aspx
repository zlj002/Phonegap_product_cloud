<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Main.Master" AutoEventWireup="true" CodeFile="contentArticle_add.aspx.cs" Inherits="Admin_ContentManager_contentArticle_add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!--上传插件-->
    <script src="../OurUpload/ajaxfileupload.js"></script>
    <script src="../OurUpload/jquery.OurUpload.js"></script>
    <link href="../OurUpload/Style/OurUpload.css" rel="stylesheet" />
    <!--时间js-->
    <script src="/plugins/My97DatePicker/WdatePicker.js"></script>
    <link href="/plugins/My97DatePicker/skin/default/datepicker.css" rel="stylesheet" />

    <link href="/plugins/My97DatePicker/skin/ourWdatePicker.css" rel="stylesheet" />
    <!--zTree-->
    <link href="/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <script src="/plugins/zTree_v3/js/jquery.ztree.core-3.5.min.js"></script>
    <script src="/plugins/zTree_v3/js/jquery.ztree.exedit-3.5.min.js"></script>
    <script src="/plugins/zTree_v3/js/jquery.ztree.excheck-3.5.min.js"></script>
    <!-- 百度编辑器 -->
    <script type="text/javascript" charset="utf-8" src="/plugins/ueditor1_4_3-utf8-net/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/plugins/ueditor1_4_3-utf8-net/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="/plugins/ueditor1_4_3-utf8-net/lang/zh-cn/zh-cn.js"></script>
    <!-- 本页-->
    <script src="BizJS/contentArticle_add.js"></script>
    <link href="style/contentArticle_add.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div ng-app="app" ng-controller="page">

        <div class="row">
            <div class="col-xs-12">
                <!-- PAGE CONTENT BEGINS -->

                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right" for="form-field-1"><font color="red">*</font>所属栏目</label>
                        <div class="col-sm-10">
                            <input type="hidden" ng-model="entity.ID" />
                            <input id="citySel" type="text" value="点击选择栏目" style="width: 200px;" ng-click="showMenu();" readonly="readonly" />
                            <div id="menuContent" class="menuContent" style="display: none; position: absolute; z-index: 10000; background-color: #f0f6e4;">
                                <ul id="tree" class="ztree" style="width: 200px;">
                                </ul>
                            </div>
                        </div>

                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right" for="form-field-1">推荐类型</label>
                        <div class="col-sm-10">
                            <div class="btn-group">
                                <button ng-class="{true: 'btn btn-primary', false: 'btn'}[entity.isTop]" ng-click="changeRecommend('top')">置顶</button>
                                <button ng-class="{true: 'btn btn-primary', false: 'btn'}[entity.isRecommend]" ng-click="changeRecommend('recommend')">推荐</button>
                                <button ng-class="{true: 'btn btn-primary', false: 'btn'}[entity.isHot]" ng-click="changeRecommend('hot')">热门</button>
                                <button ng-class="{true: 'btn btn-primary', false: 'btn'}[entity.isSlide]" ng-click="changeRecommend('slide')">幻灯片</button>
                            </div>

                        </div>
                    </div>
                    <div class="form-group" ng-show="entity.isSlide">
                        <label class="col-sm-2 control-label no-padding-right" for="form-field-1"><font color="red"></font></label>
                        <div class="col-sm-10">
                            <a class="btn btn-success" id="imgAddSlide">添加幻灯片
                            </a>
                        </div>
                    </div>

                    <div class="form-group" style="z-index: 120">
                        <label class="col-sm-2 control-label no-padding-right" for="form-field-1"><font color="red">*</font>内容标题</label>
                        <div class="col-sm-10">
                            <input type="text" ng-model="entity.Title" placeholder="标题最多100个字符" class="col-xs-10 col-sm-5" style="z-index: 120" />
                        </div>
                    </div>

                    <div class="form-group" style="height:150px;">
                        <label class="col-sm-2 control-label no-padding-right" for="form-field-1">封面图片</label>
                        <div class="col-sm-10">
                            <img onerror="javascript:this.src='/images/NoImage.jpg';this.onerror=null;" src="/images/NoImage.jpg" style="width: 150px; height: 150px;" id="image" ng-src="{{entity.CoverImage}}" ng-model="entity.CoverImage" />

                            <span style="text-align: center; position: absolute; width: 150px; height: 24px; line-height: 24px; bottom: 0; left: 10px; background-color: #000; opacity: 0.6; color: #fff;" id="btnSelectFile">编辑</span>
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right" for="form-field-1"><font color="red">*</font>排序数字</label>
                        <div class="col-sm-10">
                            <input type="text" style="width: 80px;" ng-model="entity.DisplayIndex" value="0" id="txtDiaplayIndex" />
                            <span style="color: #a0a0a0">*数字，越小越向前</span>
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right" for="form-field-1"><font color="red">*</font>浏览次数</label>
                        <div class="col-sm-10">
                            <input type="text" style="width: 80px;" ng-model="entity.BrowseCount" value="0" id="txtBrowserCount" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right" for="form-field-1"><font color="red">*</font>发布时间</label>
                        <div class="col-sm-10">
                            <input id="timer_PublishTime" ng-model="entity.PublishTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" type="text" readonly="readonly" style="height: 29px;" />
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right"  ><font color="red"></font>URL链接</label>
                        <div class="col-sm-10">
                            <input type="text" style="width: 400px;" ng-model="entity.SourceUrl" />
                            <span style="color: #a0a0a0">*例如：http://www.baidu.com</span>
                        </div>
                    </div>

                     <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right" for="form-field-1">内容摘要</label>
                        <div class="col-sm-10">
                            <textarea style="width: 400px; height: 70px;" placeholder="不填写则自动截取内容前255字符" ng-model="entity.Digest"></textarea>
                        </div>
                    </div>

                    <div class="form-group" style="height: 600px;">
                        <label class="col-sm-2 control-label no-padding-right" for="form-field-1">内容描述</label>
                        <div class="col-sm-10">
                            <script id="editor1" type="text/plain" style="height: 400px;"></script>
                        </div>
                    </div>

                     <div class="row-fluid wizard-actions" style="padding-right:30px;">
                        <a class="btn btn-primary" ng-click="submit();">
                            <i class="icon-ok"></i>
                            确定
                        </a>
                        &nbsp;&nbsp;
                        <a class="btn btn-prev" ng-click="cancel();">
                            <i class="icon-remove"></i>
                            取消
                        </a>


                    </div>
            </div>
        </div>
    </div>
</asp:Content>

