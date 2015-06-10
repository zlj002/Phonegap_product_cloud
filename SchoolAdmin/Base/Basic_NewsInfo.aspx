<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="Basic_NewsInfo.aspx.cs" Inherits="Cloud_Server.Base.Basic_NewsInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%-- 百度编辑器 --%>
        <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/lang/zh-cn/zh-cn.js"></script>

    <link href="BizCss/style.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="page-header">
                        <h1>
                            校园新闻
                            <small>
                                <i class="icon-double-angle-right"></i>
                                创建并发布新闻
                            </small>
                        </h1>
                    </div><!-- /.page-header -->

    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <form class="form-horizontal" role="form">
                <div class="form-group">
                    <label class="col-sm-2 control-label no-padding-right" for="form-field-1">所属栏目</label>
                    <div class="col-sm-10">

                        <select id="form-field-select-1" class="col-xs-10 col-sm-2">
                            <option value="">校园新闻</option>
                            <option value="AL">招生信息</option>
                        </select>
                    </div>
                </div>


                <div class="form-group">
                    <label class="col-sm-2 control-label no-padding-right" for="form-field-1">显示状态</label>
                    <div class="col-sm-10">

                        <div class="btn-group">
                            <button class="btn btn-primary">正常</button>
                            <button class="btn">待审核</button>
                            <button class="btn">不显示</button>
                        </div>
                    </div>
                </div>


                <div class="form-group">
                    <label class="col-sm-2 control-label no-padding-right" for="form-field-1">推荐类型</label>
                    <div class="col-sm-10">
                        <div class="btn-group">
                            <button class="btn btn-primary">置顶</button>
                            <button class="btn btn-primary">推荐</button>
                            <button class="btn">热门</button>
                            <button class="btn btn-primary">幻灯片</button>
                        </div>
                    </div>
                </div>


                <div class="form-group">
                    <label class="col-sm-2 control-label no-padding-right" for="form-field-1">内容标题</label>
                    <div class="col-sm-10">
                        <input type="text" id="form-field-1" placeholder="标题最多100个字符" class="col-xs-10 col-sm-5" />
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label no-padding-right" for="form-field-1">封面图片</label>
                    <div class="col-sm-10">
                        <input type="text" id="form-field-1" placeholder="选择上传的图片" class="col-xs-10 col-sm-5" />
                        <button>浏览</button>
                    </div>
                </div>


                <div class="form-group">
                    <label class="col-sm-2 control-label no-padding-right" for="form-field-1">排序数字</label>
                    <div class="col-sm-10">
                        <input type="number"  style="width:80px;"   />
                        <span style="color:#a0a0a0">*数字，越小越向前</span>
                    </div>
                </div>


                <div class="form-group">
                    <label class="col-sm-2 control-label no-padding-right" for="form-field-1">浏览次数</label>
                    <div class="col-sm-10">
                         <input type="number"  style="width:80px;"   />
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label no-padding-right" for="form-field-1">发布时间</label>
                    <div class="col-sm-10">
                        <input   type="datetime-local" id="form-field-1"  />

                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label no-padding-right" for="form-field-1">URL链接</label>
                    <div class="col-sm-10">
                        <input type="url" id="form-field-1"  style="width:400px;" />
                        <span style="color:#a0a0a0">*例如：http://www.baidu.com</span>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label no-padding-right" for="form-field-1">内容摘要</label>
                    <div class="col-sm-10">
                       <textarea style="width:400px;height:70px;" placeholder="不填写则自动截取内容前255字符"></textarea>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label no-padding-right" for="form-field-1">内容描述</label>
                    <div class="col-sm-9">
                           <script id="editor1" type="text/plain" style="height: 400px;"></script>
                    </div>
                </div>

                       <hr />
        <div class="row-fluid wizard-actions">
            <a id="btnCancel" class="btn btn-prev" href="#">
                <i class="icon-remove"></i>
                取消
            </a>
            &nbsp;&nbsp;
            <a id="btnOK" class="btn   btn-primary" href="#">
                <i class="icon-ok"></i>
                确定
            </a>
        </div>


        </div>
    </div>

     <script>
         var ue1 = UE.getEditor('editor1');
    </script>
</asp:Content>
