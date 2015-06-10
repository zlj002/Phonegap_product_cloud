<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sxs.aspx.cs" Inherits="Cloud_Server.Base.sxs" MasterPageFile="~/Main.Master" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <script src="../js/jquery-2.1.1.min.js"></script>
    <link href="../css/star-rating.css" media="all" rel="stylesheet" type="text/css" />
    <script src="../js/star-rating.js" type="text/javascript"></script>

        <script src="BizJS/sxs.js"></script>
</asp:Content>

<asp:Content ID="content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <h1>实训室 
                <small><i class="icon-double-angle-right"></i>&nbsp;显示各实训中心的实训室
                </small>
        </h1>
    </div>

    <div class="widget-box">
        <div class="widget-header">
            <h4 style="font-weight:bold">
					汽车实训中心
					<small></small>
				</h4>
        </div>
        <div class="widget-body">
            <div class="widget-main">
            <div class="row">
                <div class="col-xs-12">
                    <!-- PAGE CONTENT BEGINS -->
                    <div class="row-fluid">
                        <ul class="ace-thumbnails">

                            <li style="text-align: center;">
                                <a href="sxs_add.aspx" title="Photo Title" data-rel="colorbox">

                                    <img alt="150x150" src="../img/bjsx.jpg" style="height: 150px; width: 150px;" />

                                </a>

                                <span class="label-holder">
                                    <span class="label label-info" style="font-size: 15px;">钣金实训室 </span>
                                </span>
                                <div class="tools">
                                    <a href="#">
                                        <i class="icon-link"></i>
                                    </a>

                                    <a href="#">
                                        <i class="icon-paper-clip"></i>
                                    </a>

                                    <a href="#">
                                        <i class="icon-pencil"></i>
                                    </a>

                                    <a href="#">
                                        <i class="icon-remove red"></i>
                                    </a>
                                </div>
                            </li>


                            <li style="text-align: center;">
                                <a href="sxs_add.aspx" title="Photo Title" data-rel="colorbox">

                                    <img alt="150x150" src="../img/fdjsx.jpg" style="height: 150px; width: 150px;" />

                                </a>

                                <span class="label-holder">
                                    <span class="label label-info" style="font-size: 15px;">发动机拆装实训室 </span>
                                </span>
                                <div class="tools">
                                    <a href="#">
                                        <i class="icon-link"></i>
                                    </a>

                                    <a href="#">
                                        <i class="icon-paper-clip"></i>
                                    </a>

                                    <a href="#">
                                        <i class="icon-pencil"></i>
                                    </a>

                                    <a href="#">
                                        <i class="icon-remove red"></i>
                                    </a>
                                </div>
                            </li>



                            <li style="text-align: center;">
                                <a href="sxs_add.aspx" title="Photo Title" data-rel="colorbox">

                                    <img alt="150x150" src="../img/dpsx.jpg" style="height: 150px; width: 150px;" />

                                </a>

                                <span class="label-holder">
                                    <span class="label label-info" style="font-size: 15px;">汽车底盘实训室 </span>
                                </span>
                                <div class="tools">
                                    <a href="#">
                                        <i class="icon-link"></i>
                                    </a>

                                    <a href="#">
                                        <i class="icon-paper-clip"></i>
                                    </a>

                                    <a href="#">
                                        <i class="icon-pencil"></i>
                                    </a>

                                    <a href="#">
                                        <i class="icon-remove red"></i>
                                    </a>
                                </div>
                            </li>



                            <li style="text-align: center;">


                                <img alt="150x150" src="../img/add.jpg" style="height: 150px; width: 150px;" />

                                <span class="label-holder">
                                    <span class="label label-info" style="font-size: 15px; cursor: pointer;" onclick="javascript:window.location.href='sxs_add.aspx'">添  加 </span>
                                </span>

                            </li>

                        </ul>
                    </div>
                </div>
            </div>
        </div>
      </div>
    </div>
   
</asp:Content>
