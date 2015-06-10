/**
 * 设置未来(全局)的AJAX请求默认选项
 * 主要设置了AJAX请求遇到Session过期的情况
 */
$.ajaxSetup({
    complete: function (xhr, status) {
        var sessionStatus = xhr.getResponseHeader('sessionState');
        if (sessionStatus == 'logout') {
            var top = getTopWinow(); 
            top.location.href = '/Login/Login.aspx?sessionState=logout'; 
        }
    }
});

/**
 * 在页面中任何嵌套层次的窗口中获取顶层窗口
 * @return 当前页面的顶层窗口对象
 */
function getTopWinow() {
    var p = window;
    while (p != p.parent) {
        p = p.parent;
    }
    return p;
}



$(function () {

    $("#errorMessage").html("");
    $('#modelName').html("");
    $('#cellName').html("");
    //获取当前信息
    $(window).loading("showLoading");
    $.ajax({
        type: 'POST',
        url: "/Admin/SystemManager/Handler/Sys_UserHandler.ashx?action=GetCurrentUserInfo&now=" + new Date().getTime(),
        data: {},
        dataType: "json",
        success: function (result) {
            if (result.FinishFlag == 1) {
                //个人信息，以及头像，连接
                $("#btnSelfInfo").attr("href", "/Admin/Basic/teacher_add.aspx?selfid=" + result.Entity.ID);
                $("#spanCurrentUserName").html(result.Entity.UserName);
                $("#imgCurrentUserHeader").attr("src", result.Entity.TeacherPhotoUrl);
                //权限信息
                $.each(result.MenuList, function (index, item) {
                    if (item.Depth != 0) {
                        var menuUrl = (item.MenuUrl == null ? "#" : item.MenuUrl);
                        if (menuUrl.indexOf("?") > -1) {
                            menuUrl += ("&menuID=" + item.MenuID);
                        } else {
                            menuUrl += ("?menuID=" + item.MenuID);
                        }

                        var menu = $("<li id='" + item.MenuID + "'> <a href='" + menuUrl + "'><i class='" + item.MenuIconClass + "'></i><span class='menu-text'>" + item.MenuName + "</span></a></li>");


                        var parent = $("#navList").find("li[id=" + item.ParentMenuID + "]");
                        if (parent && parent.length > 0) {
                            var ul = $("<ul class='submenu'></ul>");
                            var submenu = parent.find(".submenu");
                            if (submenu && submenu.length > 0) {
                                submenu.append(menu);
                            } else {
                                parent.append(ul);
                                ul.append(menu);
                            }

                            parent.children().eq(0).attr("class", "dropdown-toggle");
                            var down = $("<b class='arrow icon-angle-down'></b>");
                            var isExistsDown = parent.children().eq(0).find(".icon-angle-down");
                            if (isExistsDown && isExistsDown.length > 0) {

                            } else {
                                parent.children().eq(0).append(down);
                            }

                        } else {
                            $("#navList").append(menu);
                        }
                    }
                });

                //设置当前菜单状态
                var url = window.location.pathname;
                //明细页面特殊处理//明细页面也要定位菜单位置
                if (url.indexOf("_") > -1 && url.indexOf(".") > -1) {
                    url = url.replace(url.substring(url.indexOf("_"), url.indexOf(".")), "");
                }

                $("a[href*='" + url + "']").parent().addClass("active");
                $("a[href*='" + url + "']").parent().parent().parent().addClass("active open");
                //设置默认样式
                if (ace.settings == null) {
                    ace.settings.navbar_fixed(true);
                    $("#ace-settings-navbar").attr("checked", true);
                    ace.settings.sidebar_fixed(true);
                    $("#ace-settings-sidebar").attr("checked", true);
                    ace.settings.breadcrumbs_fixed(true);
                    $("#ace-settings-breadcrumbs").attr("checked", true);
                    ace.settings.main_container_fixed(false);
                    $("#ace-settings-add-container").attr("checked", false);
                    var navbar_fixed = cookies.getCookie("navbar_fixed");
                    if (navbar_fixed == "0") {
                        ace.settings.navbar_fixed(false);
                        $("#ace-settings-navbar").attr("checked", false);
                    }
                    var sidebar_fixed = cookies.getCookie("sidebar_fixed");
                    if (sidebar_fixed == "0") {
                        ace.settings.sidebar_fixed(false);
                        $("#ace-settings-sidebar").attr("checked", false);
                    }
                    var breadcrumbs_fixed = cookies.getCookie("breadcrumbs_fixed");
                    if (breadcrumbs_fixed == "0") {
                        ace.settings.breadcrumbs_fixed(false);
                        $("#ace-settings-breadcrumbs").attr("checked", false);
                    }
                    var main_container_fixed = cookies.getCookie("main_container_fixed");
                    if (main_container_fixed == "0") {
                        ace.settings.main_container_fixed(false);
                        $("#ace-settings-add-container").attr("checked", false);
                    }
                } else {
                    console.log("当前状态》》" + cookies.getCookie("sidebar_collapsed"));
                    ////console.log(ace.settings.sidebar_collapsed);
                    if (cookies.getCookie("sidebar_collapsed") == "true") {
                        console.log("设置闭合");
                        ace.settings.sidebar_collapsed(true);
                    } else {
                        console.log("设置展开");
                        ace.settings.sidebar_collapsed(false);
                    }
                }

                //$("#sidebar-collapse").unbind().on("click", function () {

                //    cookies.setCookie("sidebar_collapsed", !min);

                //});


                $.each($(".nav-list").children(), function (index, item) {
                    $(item).unbind().on("click", function () {
                        $(".nav-list").children().removeClass("active");
                        console.log($(".nav-list").children().length);
                    });
                });


            }
            $(window).loading("hideLoading");
        },
        error: function (error) {
            $(window).loading("hideLoading");
        }
    });


    //重置密码
    $("#resultPassword").unbind().click(function () {
        $('#resetPasswordDIV').modal({
            keyboard: true
        });
    });

    //--Start重置密码保存 --------
    $("#btnSaveResetPwd").unbind().click(function () {
        var odPassword = $("#oldPassword");
        var newPassword = $("#newPassword");
        var newPasswordAgain = $("#newPasswordAgain");
        if (odPassword.val() == null || odPassword.val() == "") {
            alert("旧密码不能为空");
            return;
        } else if (newPassword.val() == null || newPassword.val() == "") {
            alert("新密码不能为空");
            return;
        } else if (newPassword.val() != newPasswordAgain.val()) {
            alert("两次新密码输入不一致，请重新输入");
            return;
        }

        var url = "/Admin/SystemManager/Handler/Sys_UserHandler.ashx";

        var para = { "action": "UpdatePwd", "oldPassword": odPassword.val(), "newPassword": newPassword.val() };
        $.ajax({
            type: 'Post',
            url: url,
            data: para,
            dataType: "json",
            success: function (result) {
                if (result.FinishFlag == "1") {
                    alert("操作成功");
                    odPassword.val("");
                    newPassword.val("");
                    newPasswordAgain.val("");
                    $('#resetPasswordDIV').modal('hide');
                } else {
                    alert(result.FinishMessage);
                }
            },
            error: function (error) {
                alert("发生未知错误，更新失败");
            }
        });
    });
    //--End 重置密码保存--------



    //处理键盘事件 禁止后退键（Backspace）密码或单行、多行文本框除外  
    function banBackSpace(e) {
        var ev = e || window.event;//获取event对象     
        var obj = ev.target || ev.srcElement;//获取事件源     

        var t = obj.type || obj.getAttribute('type');//获取事件源类型    

        //获取作为判断条件的事件类型  
        var vReadOnly = obj.getAttribute('readonly');
        var vEnabled = obj.getAttribute('enabled');
        //处理null值情况  
        vReadOnly = (vReadOnly == null) ? false : vReadOnly;
        vEnabled = (vEnabled == null) ? true : vEnabled;

        //当敲Backspace键时，事件源类型为密码或单行、多行文本的，  
        //并且readonly属性为true或enabled属性为false的，则退格键失效  
        var flag1 = (ev.keyCode == 8 && (t == "number" || t == "password" || t == "text" || t == "textarea")
                    && (vReadOnly == "readonly" || vEnabled != true)) ? true : false;

        //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效  
        var flag2 = (ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea" && t != "number")
                    ? true : false;

        //判断  
        if (flag2) {
            return false;
        }
        if (flag1) {
            return false;
        }
    }

    //禁止后退键 作用于Firefox、Opera  
    document.onkeypress = banBackSpace;
    //禁止后退键  作用于IE、Chrome  
    document.onkeydown = banBackSpace;
    var menuID = urlHelper.getQueryString('menuID');
    if (menuID != null && menuID != "") {
        getCurrentUserOperationListByMenuID(menuID);
    }

});


//--Start控制页面按钮是否显示-----------------------------------------------
function getCurrentUserOperationListByMenuID(menuID) {
    var url = "/Admin/Handler/sysuserHandler.ashx";
    var param = { "action": "GETCURRENTUSEROPERATIONLISTBYMENUID", "MenuID": menuID };
    //参数
    $.ajax({
        type: 'Post',
        url: url,
        data: param,
        dataType: "json",
        success: function (result) {
            if (result.FinishFlag == "1") {
                var str = "";
                if (result.List.length > 0) {
                    $.each(result.List, function (index, item) {
                        str += "," + item.OperationID
                    });
                    $("[operationid]").each(function (index, item) {
                        var index = str.indexOf($(item).attr("operationid"));
                        if (index < 0) {
                            $(this).remove();
                        }
                    });
                } else {
                    $("[operationid]").remove();
                }
            }
        },
        error: function (error) {
            layer.alert("服务器配置异常", 0);
        }
    });
}
//--End控制页面按钮是否显示-----------------------------------------------
