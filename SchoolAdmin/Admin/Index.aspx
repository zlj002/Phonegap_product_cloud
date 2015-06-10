<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Main.Master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Training.Index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"> 
  
    <script src="../plugins/echarts-2.2.0/build/source/echarts.js"></script>
    <script src="../plugins/echarts-2.2.0/src/config.js"></script>
    <script src="BizJS/Index.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div ng-app="app" ng-controller="Index">
        <div class="page-header">
            <h1>控制台
			 
            </h1>
        </div>
        <!-- /.page-header -->

         
        <!-- /.row -->
  
    </div>



    <script type="text/javascript">
        // 路径配置
        //require.config({
        //    paths: {
        //        'echarts': '../plugins/echarts-2.2.0/build/dist'
        //    }
        //});

        
    </script>
</asp:Content>
