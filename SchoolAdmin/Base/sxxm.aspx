<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sxxm.aspx.cs" Inherits="Cloud_Server.Base.sxxm" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ID="content1" ContentPlaceHolderID="head">
 
    <script src="BizJS/sxxm.js"></script>

    <script>
        $(function () {
            $("#btn_sxxm_add").click(function () {
                window.location.href = "sxxm_add.aspx";
            });
        });
    </script>
</asp:Content>

<asp:Content runat="server" ID="content2" ContentPlaceHolderID="ContentPlaceHolder1">

    <div class="page-header"  >
        <h1>实训项目 
                <small><i class="icon-double-angle-right"></i>&nbsp; 显示各实训项目信息
                </small>
        </h1>
    </div>


      <p>
 <a class="btn btn-primary " id="btn_sxxm_add" href="sxxm_add.aspx">
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
        <thead  >
            <tr style="font-weight:bold;">
                <td >序号</td>
                <td>实训项目名称</td>
                <td>面向专业</td>
                <td>负责人</td>
            </tr>
        </thead>
        <tbody>
            <tr style="cursor: pointer">
                <td>1</td>
                <td>汽车修理项目</td>
                <td>汽修专业</td>
                <td>张三</td>
            </tr>
            <tr style="cursor: pointer">
                <td>2</td>
                <td>汽车修理项目</td>
                <td>汽修专业</td>
                <td>张三</td>
            </tr>
            <tr style="cursor: pointer">
                <td>3</td>
                <td>汽车修理项目</td>
                <td>汽修专业</td>
                <td>张三</td>
            </tr>
            <tr style="cursor: pointer">
                <td>4</td>
                <td>汽车修理项目</td>
                <td>汽修专业</td>
                <td>张三</td>

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


