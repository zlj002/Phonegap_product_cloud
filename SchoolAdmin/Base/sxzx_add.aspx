<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="sxzx_add.aspx.cs" Inherits="Cloud_Server.Base.sxzx_add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../plugins/raty-2.5.2/demo/css/application.css" rel="stylesheet" />
    <script src="../plugins/raty-2.5.2/lib/jquery.raty.min.js"></script>
 

     <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="../plugins/ueditor1_4_3-utf8-net/lang/zh-cn/zh-cn.js"></script>

    <script src="BizJS/sxzx_add.js"></script>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server" >

    
    <div class="page-header">
        <h1>实训中心 
                <small><i class="icon-double-angle-right"></i>&nbsp;维护实训中心基本信息
                </small>
        </h1>
    </div>

    <form class="form-horizontal" role="form">
        <div class="form-group">
            <label   class="col-sm-2 control-label">名称</label>
            <div class="col-sm-10">
                <input type="email" class="form-control"   placeholder="名称" style="width:400px;" value="汽车实训中心" />
            </div>
        </div>
        <div class="form-group">
            <label   class="col-sm-2 control-label">面积</label>
            <div class="col-sm-10">
                <div class="input-group">
                <span><input type="text" class="form-control"  placeholder="面积"  style="width:400px;" value="2000"/> <label   class="control-label">平方米</label></span>
                    </div>
            </div>
        </div>
        
       <div class="form-group">
            <label   class="col-sm-2 control-label">星级</label>
            <div class="col-sm-10">
<div id="star"></div>
            </div>
        </div>

        <div class="form-group">
            <label   class="col-sm-2 control-label">所属院系</label>
            <div class="col-sm-10">
    <select class="form-control" id="form-field-select-1"  style="width:400px;">
        <option value="">&nbsp;</option>
        <option value="AL" selected>汽车系</option>
        <option value="AL">物流系</option>
        <option value="AL">会计系</option>
    </select>
            </div>
        </div>

       <div class="form-group">
            <label   class="col-sm-2 control-label">负责人</label>
            <div class="col-sm-10">
                 <div class="input-group">
                     <input type="text" class="form-control"  placeholder="负责人"  style="width:400px;" value="李伟国"/> 
                     <span  >
						<button class="btn btn-sm btn-default" type="button">
							<i class="icon-folder-open-alt bigger-110"></i>选择						 
						</button>
					</span>
               </div>
            </div>
        </div>

           <div class="form-group">
            <label   class="col-sm-2 control-label">预览图片</label>
            <div class="col-sm-10">
                <img src="../img/sxzx.jpg" style="width:150px;height:150px;" />
            </div>
        </div>

  <div class="form-group">
            <label   class="col-sm-2 control-label">简介</label>
            <div class="col-sm-10">
      <script id="editor1" type="text/plain" style="height: 400px;"></script>
            </div>
  </div>

        <hr />

        <div class="row-fluid wizard-actions">
		    <a  id="btnCancel" class="btn btn-prev" href="sxzx.aspx">
			    <i  class="icon-remove"></i>
			    取消
		    </a>

<a id="btnOK" class="btn   btn-primary" href="sxzx.aspx">
	<i class="icon-ok"></i>
	确定
</a>
	    </div>

 </form>

     

     <script> 
             var ue1 = UE.getEditor('editor1');
          
    </script>
</asp:Content>
