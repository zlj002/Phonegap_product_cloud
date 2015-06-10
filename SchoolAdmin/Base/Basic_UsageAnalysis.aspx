<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="Basic_UsageAnalysis.aspx.cs" Inherits="Cloud_Server.Base.Basic_UsageAnalysis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 
    <!--eChart-->
    <script src="/plugins/echart/ECharts.js"></script>
    <script src="/plugins/echart/echarts/esl.js"></script>
    <script src="BizJS/Basic_UsageAnalysis.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <h1>使用分析
                <small><i class="icon-double-angle-right"></i>图表方式直观呈现数据统计
                </small>
        </h1>
    </div>
    <div style="height: 400px;">

        <div style="width: 40%; height: 100%; float: left; margin-left: 50px;" id="div1">
        </div>
        <div style="width: 40%; float: right; margin-right: 50px; height: 100%;" id="div2">
        </div>
    </div>

    <div style="height: 400px;">
        <div style="width: 40%; height: 100%; float: left; margin-left: 50px;" id="div3">
        </div>
        <div style="width: 40%; float: right; margin-right: 50px; height: 100%;" id="div4">
        </div>
    </div>
</asp:Content>
