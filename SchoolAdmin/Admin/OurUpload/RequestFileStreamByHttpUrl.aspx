<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RequestFileStreamByHttpUrl.aspx.cs"
    Inherits="OurUpload.OurUpload.RequestFileStreamByHttpUrl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title> 
    <link href="/Plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script src="/Plugins/jquery/1.11.0/jquery.min.js" type="text/javascript"></script>
    <script src="/Plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        window.onload = function () {
            $('#loading-mask').fadeOut();
        }

        function ViewWindow() {
            $("#modal-Window").click();
        }
        $(function () {
            $("#win").height($(window).height() - 151);
            $(window).resize(function () {
                //高度
                $("#win").height($(window).height() - 151);
            });
             
        });
        
    </script>
</head>
<body style="overflow-y: hidden">
    <div id="loading-mask" style="position: absolute; top: 0px; left: 0px; width: 100%;
        height: 100%; background: #D2E0F2; z-index: 20000">
        <div id="pageloading" style="position: absolute; top: 50%; left: 50%; margin: -120px 0px 0px -120px;
            text-align: center; border: 2px solid #8DB2E3; width: 200px; height: 40px; font-size: 14px;
            padding: 10px; font-weight: bold; background: #fff; color: #15428B;">
            <img src="images/pageloading.gif" align="absmiddle" />
            正在加载中,请稍候...
        </div>
    </div>
    <form id="form1" runat="server">
    <div class="container-fluid" style="background-color: #F6F9FC;">
        <div class="row-fluid">
            <div class="span12">
                <img src="images/fu_doc.gif" align="absmiddle" id="imageFileType" style="float: left;" />
                <h5 id="hfileName" style="float: left;" runat="server">
                </h5>
                <div style="clear: both;">
                </div>
                <h5>
                    此服务使用服务器office预览技术</h5>
            </div>
        </div>
    </div>
    <div class="container-fluid" style="background-color: #2b579a;">
        <div class="row-fluid">
            <div class="span12">
                <h4>
                    <font color="white">Office Web App</font></h4>
            </div>
        </div>
    </div>
    <div class="container-fluid" style="background-color: #F6F9FC;">
        <div class="row-fluid">
            <div class="span12">
                <ul class="inline">
                    <li style="cursor: pointer; width: 50px;">
                        <asp:HyperLink ID="downloadBtn" runat="server">  
                        <img src="images/download.png" align="absmiddle" />
                        下载 </asp:HyperLink></li>
                    <li style="cursor: pointer; width: 50px;"><a onclick='document.frames("win").print()'>
                        <img src="images/printer.png" align="absmiddle" />
                        打印 </a></li>
                </ul>
            </div>
        </div>
    </div>
    <div class="container-fluid" style="background-color: #F6F9FC;">
        <div class="row-fluid">
            <div class="span12">
                <iframe id="win" frameborder="no" border="0" marginwidth="0" marginheight="0" style="width: 100%;
                    height: 100%" runat="server"></iframe>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class="row-fluid">
            <div class="span12">
                <a id="modal-Window" href="#modal-container-Window" role="button" class="btn" data-toggle="modal" style="display:none;">
                </a>
                <div id="modal-container-Window" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel"
                    aria-hidden="true">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            ×</button>
                        <h3 id="myModalLabel">
                        </h3>
                    </div>
                    <div class="modal-body">
                        <p>
                            <asp:Label ID="labInfo" runat="server" Text=""></asp:Label>
                        </p>
                    </div>
                    <div class="modal-footer">
                        <button class="btn" data-dismiss="modal" aria-hidden="true">
                            关闭</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
