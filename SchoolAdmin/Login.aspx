<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Cloud_Server.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
        <script type="text/javascript" src="js/jquery-1.9.0.min.js"></script>
    <script type="text/javascript" src="images/login.js"></script>
    <link href="css/login2.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
   <table style="width:100%;">
            <tr>
                <td style="width:60%;"><br/><br/><br/> <br/> 
                    <img src="images/1.jpg" /></td>
                <td style="width:40%;">
                    <h1>实训中心后台管理 </h1>

                    <div class="login" style="margin-top: 50px; text-align: right; ">

                        <div class="header" style="text-align:center;">
                            <div class="switch" id="switch">
                                <a class="switch_btn_focus" id="switch_qlogin"  href="Index.aspx">用户登录</a>

                            </div>
                        </div>


                        <div class="web_qr_login" id="web_qr_login" style="display: block; height: 235px;">

                            <!--登录-->
                            <div class="web_login" id="web_login">


                                <div class="login-box">


                                    <div class="login_form">
                                        <form     name="loginform" accept-charset="utf-8" id="login_form" class="loginForm" method="post">
                                            <input type="hidden" name="did" value="0" />
                                            <input type="hidden" name="to" value="log" />
                                            <div class="uinArea" id="uinArea">
                                                <label class="input-tips" for="u">帐号：</label>
                                                <div class="inputOuter" id="uArea">

                                                    <input type="text" id="u" name="username" class="inputstyle"  placeholder="请输入用户"/>
                                                </div>
                                            </div>
                                            <div class="pwdArea" id="pwdArea">
                                                <label class="input-tips" for="p">密码：</label>
                                                <div class="inputOuter" id="pArea" >

                                                    <input type="password" id="p" name="p" class="inputstyle"  placeholder="请输入密码"/>
                                                </div>
                                            </div>

                                            <div style="padding-left:50px;margin-top:20px;">
                                              <input  type="button" value="登 录" style="width:150px;" class="button_blue"  onclick="javascript:window.location.href='index.aspx'; " /> 

                                            </div>
                                        </form>
                                    </div>

                                </div>

                            </div>
                            <!--登录end-->
                        </div>

                        <!--注册-->
                        <div class="qlogin" id="qlogin" style="display: none; ">

                            <div class="web_login">
                                <form name="form2" id="regUser" accept-charset="utf-8" action="http://www.js-css.cn" method="post">
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
                                                <input type="button" id="reg" style="margin-top:10px;margin-left:85px;" class="button_blue" value="同意协议并注册" /> <a href="#" class="zcxy" target="_blank">注册协议</a>
                                            </div>

                                        </li>
                                        <div class="cl"></div>
                                    </ul>
                                </form>


                            </div>


                        </div>
                        <!--注册end-->
                    </div>
                    <div class="jianyi">*推荐使用ie8或以上版本ie浏览器或Chrome内核浏览器访问本站</div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
