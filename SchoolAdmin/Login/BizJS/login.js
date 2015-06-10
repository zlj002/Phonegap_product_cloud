$(function () {

    var sessionState = urlHelper.getQueryString('sessionState');
    if (sessionState != null && sessionState != "" && sessionState == "logout") {
        layer.alert("您长时间未操作，请重新登录", 0);
    }

    var msg = "";
    var userAgent = navigator.userAgent,
            rMsie = /(msie\s|trident.*rv:)([\w.]+)/,
            rFirefox = /(firefox)\/([\w.]+)/,
            rOpera = /(opera).+version\/([\w.]+)/,
            rChrome = /(chrome)\/([\w.]+)/,
            rSafari = /version\/([\w.]+).*(safari)/;
    var ua = userAgent.toLowerCase();
    var browserMatch = uaMatch(userAgent.toLowerCase());
    var match = rChrome.exec(ua);
    if (match != null) {
        $("#warning").hide();
    }
    else {
        if (!browserMatch.browser) {
            msg = "检测到您的浏览器不是Chrome ";
        }
        else {
            msg = "检测到您的浏览器为" + browserMatch.browser + ":" + browserMatch.version;
        }
        $("#msg").html(msg);
        $("#warning").show();
        if (browserMatch.browser == "IE" && browserMatch.version>=10)
        {
            $("#warning").hide();
        }
    }
    $("#msg").html(msg);

    $("#btnLogin").unbind().on("click", function () {
        var loading = layer.load('正在登录，请稍后...');

        // business logic...
        //$btn.button('reset');
        var url = "Handler/userHandler.ashx";
        var txtLoginID = $("#txtLoginID").val();
        var txtPassword = $("#txtPassword").val();
        //参数
        var para = { "LoginID": txtLoginID, "PassWord": txtPassword, "action": "Login" };

        $.ajax({
            type: 'post',
            url: url,
            data: para,
            dataType: "json",
            success: function (result) {
                if (result.FinishFlag == 1) {
                    location.href = "/Admin/Index.aspx";
                } else {
                    layer.msg(result.FinishMessage, 1, 0);
                }
                layer.close(loading);
            },
            error: function (error) {
                //alert("服务器配置异常");
                layer.msg("服务器配置异常", 1, 0);
            }
        });
    });
    $(document).unbind().on("keydown", function (event) {

        if (event.keyCode == 13) {

            $("#btnLogin").click();
            return false;
        }
    });
});
function uaMatch(ua) {
    var userAgent = navigator.userAgent,
            rMsie = /(msie\s|trident.*rv:)([\w.]+)/,
            rFirefox = /(firefox)\/([\w.]+)/,
            rOpera = /(opera).+version\/([\w.]+)/,
            rChrome = /(chrome)\/([\w.]+)/,
            rSafari = /version\/([\w.]+).*(safari)/;
    var match = rMsie.exec(ua);
    if (match != null) {
        return { browser: "IE", version: match[2] || "0" };
    }
    var match = rFirefox.exec(ua);
    if (match != null) {
        return { browser: "Firefox" || "", version: match[2] || "0" };
    }
    var match = rOpera.exec(ua);
    if (match != null) {
        return { browser: "Opera" || "", version: match[2] || "0" };
    }
    var match = rChrome.exec(ua);
    if (match != null) {
        return { browser: "Chrome" || "", version: match[2] || "0" };
    }
    var match = rSafari.exec(ua);
    if (match != null) {
        return { browser: "Safari" || "", version: match[1] || "0" };
    }
    if (match != null) {
        return { browser: "", version: "0" };
    }
}