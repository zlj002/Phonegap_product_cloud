/*angular 模块*/
var app = angular.module("app", []);
app.controller("page", function ($scope) { });
$(function () {

    var ue1 = UE.getEditor('editor1');
    var ue2 = UE.getEditor('editor2');
    $(window).loading("showLoading");
    //var id = 1;

    $.ajax({
        type: 'POST',
        contentType: "application/json; charset=utf-8",
        url: "/Base/Basic_SchoolInfo.aspx/GetEntity",
        dataType: "json",
        success: function (result) {
            var returnData = JSON.parse(result.d); // JSON.parse(result.d);
            var info = returnData.Info;
            var honor = returnData.Honor;
            ue1.ready(function () {
                ue1.setContent(info, false);
            });
            ue2.ready(function () {
                ue2.setContent(honor, false);
            });

            $(window).loading("hideLoading");
        },
        error: function (error) {
            $(window).loading("hideLoading");
        }
    });


    $("#btnSave").unbind().on("click", function () {
        var info = ue1.getContent();
        var honor = ue2.getContent();

        var objEntity = {};
        objEntity.Info = info;
        objEntity.Honor = honor;
        var os = MY_JSON.stringify(objEntity);
        $.ajax({
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            url: "/Base/Basic_SchoolInfo.aspx/InsertOrUpdate",
            data: "{'entity':" + os + "}",
            dataType: "json",
            success: function (result) {
                var returnData = JSON.parse(result.d); // JSON.parse(result.d);
                alert(returnData.ReturnMessage);
                $(window).loading("hideLoading");
            },
            error: function (error) {
                $(window).loading("hideLoading");
            }
        });
    })
});


function showErrorAlert(reason, detail) {
    var msg = '';
    if (reason === 'unsupported-file-type') { msg = "Unsupported format " + detail; }
    else {

    }
    $('<div class="alert"> <button type="button" class="close" data-dismiss="alert">&times;</button>' +
     '<strong>File upload error</strong> ' + msg + ' </div>').prependTo('#alerts');
}