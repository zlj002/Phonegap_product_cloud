<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="sxzx.aspx.cs" Inherits="Cloud_Server.Base.sxzx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    
    <link href="../plugins/raty-2.5.2/demo/css/application.css" rel="stylesheet" />
    <script src="../plugins/raty-2.5.2/lib/jquery.raty.min.js"></script>

    <script src="BizJS/sxzx.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <h1>实训中心 
                <small><i class="icon-double-angle-right"></i>  显示各实训中心的信息
                </small>
        </h1>
    </div>
 

    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
   
            <div class="row-fluid">
                <ul class="ace-thumbnails">

                    <li style="text-align:center;">
                        <a href="sxzx_add.aspx" title="Photo Title" data-rel="colorbox">

                            <img alt="150x150" src="../img/sxzx.jpg" style="height: 150px; width: 150px;" />
<div id="star1"></div>
                        </a>
                      
                         <span class="label-holder">
                                    <span class="label label-info" style="font-size:15px;"> 汽车实训中心 </span>
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
                     
                     
                    <li style="text-align:center;">
                        <a href="sxzx_add.aspx" title="Photo Title" data-rel="colorbox">

                            <img alt="150x150" src="../img/sxzx.jpg" style="height: 150px; width: 150px;" />
                <div id="star2"></div>
                        </a>
                      
                         <span class="label-holder">
                                    <span class="label label-info" style="font-size:15px;"> 汽车实训中心 </span>
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


                    
                    <li style="text-align:center;">
                        <a href="sxzx_add.aspx" title="Photo Title" data-rel="colorbox">

                            <img alt="150x150" src="../img/sxzx.jpg" style="height: 150px; width: 150px;" />
       <div id="star3"></div>
                        </a>
                      
                         <span class="label-holder">
                                    <span class="label label-info" style="font-size:15px;"> 汽车实训中心 </span>
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


                    
                    <li style="text-align:center;">
                       

                    <img alt="150x150" src="../img/add.jpg" style="height: 150px; width: 150px;" />
                         <div id="star4"></div>
                       <span class="label-holder">
                                    <span class="label label-info" style="font-size:15px;cursor:pointer;"  onclick="javascript:window.location.href='sxzx_add.aspx'"> 添  加 </span>
                                </span>
                      
                    </li>

                </ul>
            </div>
             
        </div>
        
    </div>
    
</asp:Content>
