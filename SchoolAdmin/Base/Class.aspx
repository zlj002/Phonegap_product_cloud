<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="Class.aspx.cs" Inherits="Cloud_Server.Base.Class" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


      <div class="page-header"  >
        <h1>班级管理
                <small><i class="icon-double-angle-right"></i>&nbsp;显示班级信息
                </small>
        </h1>
       
    </div>
     
    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addGrade">添加年级</button>
    <button type="button" class="btn btn-default">删除年级</button>

    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <!-- Single button -->
    <div class="btn-group">
        <button type="button" class="btn dropdown-toggle" data-toggle="dropdown">
            新增班级 <span class="icon-caret-down icon-on-right"></span>
        </button>
   
        <ul class="dropdown-menu dropdown-default" role="menu">
            <li><a href="#" data-toggle="modal" data-target="#addClass">至2012级 专业</a></li>
            <li><a href="#" data-toggle="modal" data-target="#addClass">至2013级 专业</a></li>
            <li><a href="#" data-toggle="modal" data-target="#addClass">至2014级 专业</a></li>
        </ul>
    </div>

    <button type="button" class="btn btn-default">删除班级</button>


    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

       <button type="button" class="btn btn-default">导入班级数据</button>


    <br />
    <br />


    <!-- 新增年级 -->
    <div class="modal fade" id="addGrade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">关闭</span></button>
                    <h4 class="modal-title"  >新增年级</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">年级名称</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control"   placeholder="年级名称">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary">保存</button>
                </div>
            </div>
        </div>
    </div>


        <!-- 新增班级 -->
    <div class="modal fade" id="addClass" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">关闭</span></button>
                    <h4 class="modal-title"  >新增班级</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="inputEmail3" class="col-sm-2 control-label">班级名称</label>
                            <div class="col-sm-10">
                                <input type="email" class="form-control" id="inputEmail3" placeholder="班级名称">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary">保存</button>
                </div>
            </div>
        </div>
    </div>
    
    
        
    <div class="panel panel-primary">
        <div class="panel-heading">2013级 汽修专业</div>
        <div class="panel-body">
            <div class="row">
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修1班
                </div>
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修2班
                </div>
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修3班
                </div>
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修4班
                </div>
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修5班
                </div>
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修6班
                </div>

            </div>
        </div>
    </div>


    <div class="panel panel-primary">
        <div class="panel-heading">2014级 汽修专业</div>
        <div class="panel-body">
            <div class="row">
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修1班
                </div>
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修2班
                </div>
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修3班
                </div>
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修4班
                </div>
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修5班
                </div>
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修6班
                </div>

            </div>
        </div>
    </div>


     <div class="panel panel-primary">
        <div class="panel-heading">2014级 汽修专业</div>
        <div class="panel-body">
            <div class="row">
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修1班
                </div>
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修2班
                </div>
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修3班
                </div>
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修4班
                </div>
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修5班
                </div>
                <div class="col-xs-6 col-md-2" style="text-align: center;">
                    <a href="#" class="btn  btn-lg ">
                        <img src="../img/class.jpg" alt="..." style="width: 100%; height: 100%;" />
                    </a>
                    汽修6班
                </div>

            </div>
        </div>
    </div>

     
</asp:Content>
