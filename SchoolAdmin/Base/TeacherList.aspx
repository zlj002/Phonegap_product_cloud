<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="TeacherList.aspx.cs" Inherits="Cloud_Server.Teacher.List" %>
 
<asp:Content runat="server" ID="content3" ContentPlaceHolderID="head">
 
     
    <script src="BizJS/TeacherList.js"></script>
    <script>
        $(function () {
            $("#btn_gzzd_add").click(function () {
                window.location.href = "TeacherDetail.aspx";
            });
        });
    </script>
</asp:Content>

<asp:Content runat="server" ID="content4" ContentPlaceHolderID="ContentPlaceHolder1">

    <div class="page-header" >
        <h1>师资管理 
                <small><i class="icon-double-angle-right"></i>&nbsp;显示全部实训教师的信息
                </small>
        </h1>
    </div> 

  <p>
 <a class="btn btn-primary " id="btn_gzzd_add" href="TeacherDetail.aspx">
                            <i class="icon-instagram"></i>添加
                        </a>

                    <a class="btn btn-warning  ">
                        <i class="icon-edit"></i>修改
                    </a>

                    <a class="btn  btn-danger  ">
                        <i class="icon-remove"></i>删除
                    </a>
      </p>
    <table class="table table-striped table-bordered table-hover">
       <thead>
                <tr>
                    <th>#</th>
                    <th>职工号</th>
                    <th>姓名</th>
                    <th>手机号</th>
                    <th>岗位类型</th>
                    <th>双师型教师</th>
                    <th>所属实训中心</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td><a href="TeacherDetail.aspx">z105</a><img src="../img/master.jpg"  style="width:150px;height:150px;"/></td>
                    <td>张老师</td>
                    <td>18217286527</td>
                    <td>专任</td>
                    <td>是</td>
                    <td>汽车实训中心</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td><a href="TeacherDetail.aspx">z105</a><img src="../img/master.jpg"  style="width:150px;height:150px;"/></td>
                    <td>张老师</td>
                    <td>18217286527</td>
                    <td>专任</td>
                    <td>是</td>
                    <td>汽车实训中心</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td><a href="TeacherDetail.aspx">z105</a><img src="../img/master.jpg"  style="width:150px;height:150px;"/></td>
                    <td>张老师</td>
                    <td>18217286527</td>
                    <td>聘任</td>
                     <td>是</td>
                    <td>汽车实训中心</td>
                </tr>
            </tbody>
    </table>
     <ul class="pagination pull-right no-margin">
													<li class="prev disabled">
														<a href="#">
															<i class="icon-double-angle-left"></i>
														</a>
													</li>

													<li class="active">
														<a href="#">1</a>
													</li>

													<li>
														<a href="#">2</a>
													</li>

													<li>
														<a href="#">3</a>
													</li>
        											 <li>
														<a href="#">4</a>
													</li>
        											<li>
														<a href="#">5</a>
													</li>

													<li class="next">
														<a href="#">
															<i class="icon-double-angle-right"></i>
														</a>
													</li>
												</ul>
</asp:Content>