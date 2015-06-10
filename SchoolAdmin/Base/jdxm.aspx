<%@ Page Language="C#" AutoEventWireup="true" CodeFile="jdxm.aspx.cs" Inherits="Cloud_Server.Base.jdxm" MasterPageFile="~/Main.Master" %>

<asp:Content runat="server" ID="content1" ContentPlaceHolderID="head">
 
    <script src="BizJS/jdxm.js"></script>

    <script>
        $(function () {
            $("#btn_sxxm_add").click(function () {
                window.location.href = "jdxm_add.aspx";
            });
        });
    </script>
</asp:Content>

<asp:Content runat="server" ID="content2" ContentPlaceHolderID="ContentPlaceHolder1">

    <div class="page-header"  >
        <h1>鉴定项目 
                <small><i class="icon-double-angle-right"></i>&nbsp; 显示各鉴定项目信息
                </small>
        </h1>
    </div>



 <p>
 <a class="btn btn-primary " id="btn_sxxm_add" href="jdxm_add.aspx">
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
                <td>鉴定项目名称</td>
                <td>面向专业</td>
                <td>鉴定等级</td>
                <td>鉴定费用</td>
                <td>证书名称</td>
                <td>发证机构（或部门）</td>
            </tr>
        </thead>
        <tbody>
            <tr style="cursor: pointer">
                <td>1</td>
                <td>汽车维修工</td>
                <td>汽车运用技术</td>
                <td>二级</td>
                <td>800元</td>
                <td>汽车维修工</td>
                <td>上海市人力资源和社会保障局</td>
            </tr>
      <tr style="cursor: pointer">
                <td>2</td>
                <td>汽车维修工</td>
                <td>汽车运用技术</td>
                <td>三级</td>
                <td>700元</td>
                <td>汽车维修工</td>
                <td>上海市人力资源和社会保障局</td>
            </tr>
             <tr style="cursor: pointer">
                <td>3</td>
                <td>汽车维修工</td>
                <td>汽车运用技术</td>
                <td>四级</td>
                <td>600元</td>
                <td>汽车维修工</td>
                <td>上海市人力资源和社会保障局</td>
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


