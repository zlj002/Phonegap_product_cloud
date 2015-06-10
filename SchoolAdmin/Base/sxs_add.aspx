<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sxs_add.aspx.cs" Inherits="Cloud_Server.Base.sxs_add" MasterPageFile="~/Main.Master" %>


<asp:Content runat="server" ID="content1" ContentPlaceHolderID="head">
 
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/lang/zh-cn/zh-cn.js"></script>

        <script src="BizJS/sxs_add.js"></script>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="page-header">
        <h1>实训室 
                <small><i class="icon-double-angle-right"></i>&nbsp;实训室基本信息
                </small>
        </h1>
    </div>

    <form class="form-horizontal" role="form">
        <div class="form-group">
            <label class="col-sm-2 control-label">实训室名称</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="名称" style="width: 400px;" />
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">所属实训中心</label>
            <div class="col-sm-10">
                <select class="form-control" id="form-field-select-1" style="width: 400px;">
                    <option value="">&nbsp;</option>
                    <option value="AL" selected>汽车实训中心</option>
                    <option value="AL">数控实训中心</option>
                </select>

            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">面向专业</label>
            <div class="col-sm-10">
                <select class="form-control" style="width: 400px;">
                    <option value="">&nbsp;</option>
                    <option value="AL" selected>汽车维修专业</option>
                    <option value="AL">电子数控专业</option>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">工位数</label>
            <div class="col-sm-10">
                <input type="email" class="form-control" placeholder="工位数" style="width: 100px;" value="20" />
            </div>
        </div>

 <%--       <div class="form-group">
            <label class="col-sm-2 control-label">不可用时间段</label>
            <div class="col-sm-10">
             <input type="datetime" class="form-control"  />至
             <input type="datetime" class="form-control"   />
            </div>
        </div>--%>

        <div class="form-group">
            <label class="col-sm-2 control-label">管理员</label>
            <div class="col-sm-10">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="管理员" style="width: 400px;" value="李伟国" />
                    <span>
                        <button class="btn btn-sm btn-default" type="button">
                            <i class="icon-folder-open-alt bigger-110"></i>选择						 
                        </button>
                    </span>
                </div>
            </div>
        </div>

        <div class="form-group">
            <label class="col-sm-2 control-label">负责人</label>
            <div class="col-sm-10">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="负责人" style="width: 400px;" value="李伟国" />
                    <span>
                        <button class="btn btn-sm btn-default" type="button">
                            <i class="icon-folder-open-alt bigger-110"></i>选择						 
                        </button>
                    </span>
                </div>
            </div>

        </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">展示图片</label>
                <div class="col-sm-10">
                    <img src="../img/shixunshi.jpg" style="width: 150px; height: 150px;" />
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">主要设备</label>
                <div class="col-sm-10">
                    <input type="checkbox" />
                    设备一  
                    <input type="checkbox" />
                    设备二
                    <input type="checkbox" />
                    设备三
                    <input type="checkbox" />
                    设备四
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">实训项目</label>
                <div class="col-sm-10">
                    <input type="checkbox" />
                    项目一  
                    <input type="checkbox" />
                    项目二
                    <input type="checkbox" />
                    项目三
                    <input type="checkbox" />
                    项目四
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">是否对外培训</label>
                <div class="col-sm-10">
                     
			        <label>
				        <input name="switch-field-1" class="ace ace-switch ace-switch-6" type="checkbox" />
				        <span class="lbl"></span>
			        </label>
							 
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-2 control-label">简介</label>
                <div class="col-sm-10">
                    <script id="editor2" type="text/plain" style="height: 400px;"></script>
                </div>
            </div>

         <hr />

        <div class="row-fluid wizard-actions" >
		    <a  id="btnCancel" class="btn btn-prev" href="sxs.aspx">
			    <i  class="icon-remove"></i>
			    取消
		    </a>

<a id="btnOK" class="btn   btn-primary"  href="sxs.aspx">
	<i class="icon-ok"></i>
	确定
</a>
	    </div>
    </form>


    <script>
        var ue1 = UE.getEditor('editor2');

    </script>
</asp:Content>
