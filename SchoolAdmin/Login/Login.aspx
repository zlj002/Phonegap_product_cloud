<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Training.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="/plugins/ace/assets/css/bootstrap.min.css" rel="stylesheet" />
    <script type="text/javascript" src="BizJS/jquery-1.9.0.min.js"></script>
    <script type="text/javascript" src="Bizjs/login.js"></script>
    <link href="css/login2.css" rel="stylesheet" type="text/css" />
    <script src="/plugins/ace/assets/js/bootstrap.min.js"></script>
    <!--urlHelper-->
    <script src="/plugins/venusoft/urlHelper.js"></script>
    <!--Layer-->
    <script src="/plugins/layer-v1.8.5/layer/layer.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width: 100%;">
            <tr>
                <td style="width: 60%;">
                    <br />
                    <br />
                    <br />
                    <br />
                     <br />
                    <br />
                    <img src="images/2.png" /></td>
                <td style="width: 40%;">
                    <h1>实训中心后台管理 </h1>
                    <div style="text-align:center;">
                    <h3 id="warning"><span id="msg"></span><br /><a href="/res/Chrome41.0.2272.89.1426235198.rar" style="color:#0078B3" target="_blank"><img style="width:28px;height:28px;" src="Images/chrome.ico" /> 下载Google Chrome</a></h3>
                    </div>
                        <div class="login" style="margin-top: 50px; text-align: right;">

                        <div class="header" style="text-align: center;">
                            <div class="switch" id="switch">
                                <a class="switch_btn_focus" id="switch_qlogin">用户登录</a>

                            </div>
                        </div>


                        <div class="web_qr_login" id="web_qr_login" style="display: block; height: 235px;">

                            <!--登录-->
                            <div class="web_login" id="web_login">


                                <div class="login-box">


                                    <div class="login_form">
                                        <form name="loginform" accept-charset="utf-8" id="login_form" class="loginForm" method="post">
                                            <input type="hidden" name="did" value="0" />
                                            <input type="hidden" name="to" value="log" />
                                            <div class="uinArea" id="uinArea">
                                                <label class="input-tips" for="u">帐号：</label>
                                                <div class="inputOuter" id="uArea">

                                                    <input type="text" name="username" class="inputstyle" placeholder="请输入用户" id="txtLoginID" />
                                                </div>
                                            </div>
                                            <div class="pwdArea" id="pwdArea">
                                                <label class="input-tips" for="p">密码：</label>
                                                <div class="inputOuter" id="pArea">

                                                    <input type="password" name="p" class="inputstyle" placeholder="请输入密码" id="txtPassword" />
                                                </div>
                                            </div>

                                            <div style="padding-left: 50px; margin-top: 20px;">
                                                <input type="button" value="登 录" style="width: 150px; color: white;" class="button_blue" id="btnLogin" />

                                            </div>
                                        </form>
                                    </div>

                                </div>

                            </div>
                            <!--登录end-->
                        </div>

                        <!--注册-->
                        <div class="qlogin" id="qlogin" style="display: none;">

                            <div class="web_login">
                                <form name="form2" id="regUser" accept-charset="utf-8" method="post">
                                    <input type="hidden" name="to" value="reg" />
                                    <input type="hidden" name="did" value="0" />
                                    <ul class="reg_form" id="reg-ul">
                                        <div id="userCue" class="cue">快速注册请注意格式</div>
                                        <li>

                                            <label for="user" class="input-tips2">用户名：</label>
                                            <div class="inputOuter2">
                                                <input type="text" id="user" name="user" maxlength="16" class="inputstyle2" />
                                            </div>

                                        </li>

                                        <li>
                                            <label for="passwd" class="input-tips2">密码：</label>
                                            <div class="inputOuter2">
                                                <input type="password" id="passwd" name="passwd" maxlength="16" class="inputstyle2" />
                                            </div>

                                        </li>
                                        <li>
                                            <label for="passwd2" class="input-tips2">确认密码：</label>
                                            <div class="inputOuter2">
                                                <input type="password" id="passwd2" name="" maxlength="16" class="inputstyle2" />
                                            </div>

                                        </li>

                                        <li>
                                            <label for="qq" class="input-tips2">QQ：</label>
                                            <div class="inputOuter2">

                                                <input type="text" id="qq" name="qq" maxlength="10" class="inputstyle2" />
                                            </div>

                                        </li>

                                        <li>
                                            <div class="inputArea">
                                                <input type="button" id="reg" style="margin-top: 10px; margin-left: 85px;" class="button_blue" value="同意协议并注册" />
                                                <a href="#" class="zcxy" target="_blank">注册协议</a>
                                            </div>

                                        </li>
                                        <div class="cl"></div>
                                    </ul>
                                </form>


                            </div>


                        </div>
                        <!--注册end-->
                    </div>
                    <div class="jianyi">*推荐使用ie10或以上版本ie浏览器或Chrome内核浏览器访问本站</div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
