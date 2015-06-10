/*angular 模块*/
var app = angular.module("app", []);
app.controller("page", function ($scope) { });
$(function () {
  
    page.bindList();
    page.bindEvents();
});
var table;
var page = {
    getEntity: function (id) {
        $(window).loading("showLoading");
        $.ajax({
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            url: "CampusManager.aspx/GetEntity",
            data: "{'campusID':'" + id + "'}",
            dataType: "json",
            success: function (result) {
                var returnData = JSON.parse(result.d); // JSON.parse(result.d);
                $('#divInfo').modal({
                    keyboard: true
                }); 
                $("#divInfo").formparam(returnData);
                $(window).loading("hideLoading");
            },
            error: function (error) {
                $(window).loading("hideLoading");
            }
        });
    },

    //绑定列表
    bindList: function () {
        table = $('#tableList').dataTable({
            "bStateSave": false,//缓存搜索条件
            "bServerSide": true,//是否服务端处理分页
            "bSort": false, //是否启用列排序
            'bFilter': true,  //是否使用内置的过滤功能
            'bLengthChange': false, //是否允许自定义每页显示条数
            'bPaginate': true,  //是否分页
            "bProcessing": true, //当datatable获取数据时候是否显示正在处理提示信息。
            'iDisplayLength': 10, //每页显示10条记录
            "sPaginationType": "bootstrap", //分页样式   full_numbers
            //数据列
            "aoColumns": [
                {
                    "sClass": "center", "mDataProp": "CampusID"
                },
                {
                    "sClass": "center", "mDataProp": "CampusID"
                },

                {
                    "sClass": "center", "mDataProp": "CampusName"
                },
                {
                    "sClass": "center", "mDataProp": "CampusCoords"
                }
            ],
            "oLanguage": { //国际化配置  
                "sUrl": "/plugins/jquery.DataTables/zn_CH.txt",
                "sSearch": "校区名称"
            },
            "sAjaxSource": "Handler/CampusHandler.ashx?action=GetCampusList&now=" + new Date().getTime(),
            //服务器端，数据回调处理  
            "fnServerData": function (sSource, aDataSet, fnCallback) {
                $.ajax({
                    dataType: 'json',
                    type: "POST",
                    url: sSource,
                    data: aDataSet,
                    success: fnCallback
                });
            },
            //选择和操作
            "fnRowCallback": function (nRow, aData, iDataIndex) {
                $('td:eq(0),td:eq(1)', nRow).html('');
                var checkbox = $('<input title="选择" type="checkbox" id="check_' + aData.CampusID + '" name="check_' + aData.CampusID + '"  campusid="' + aData.CampusID + '"/>');
                $('td:eq(0)', nRow).append(checkbox);
                var btnEdit = $('<a title="编辑" style="cursor:pointer" class="green"  campusid="' + aData.CampusID + '"><i class="icon-pencil bigger-130"></i></a>');
                btnEdit.click(function () {
                    page.getEntity(aData.CampusID);
                });
                $('td:eq(1)', nRow).append(btnEdit); 
                return nRow;
            },
            "fnDrawCallback": function () {
                table.prev().hide();
            }
        });
        //搜索事件
        $('input.column_filter').on('keyup', function () {
            table.DataTable().columns(2).search(
                $(this).val()
            ).draw();
        });
        //选择事件
        $('table th input:checkbox').on('click', function () {
            var that = this;
            $(this).closest('table').find('tr > td:first-child input:checkbox')
            .each(function () {
                this.checked = that.checked;
                $(this).closest('tr').toggleClass('selected');
            });

        });
    },
    bindEvents: function () {
        $("#btnAdd").bind("click", function () {
            $('#divInfo').modal({
                keyboard: true
            });

            $("#CampusID").val(0);
            $("#CampusName").val('');
            $("#CampusCoords").val('');
            $("#PhoneNumber").val('');
            $("#Description").val('');
            

        });

        $("#btnSave").bind("click", function () {
            $(window).loading("showLoading");
            var objEntity = $("#divInfo").formparam();
            var os = MY_JSON.stringify(objEntity);
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "CampusManager.aspx/InsertOrUpdate",
                data: "{'entity':" + os + "}",
                dataType: "json",
                success: function (result) {
                    var returnData = result.d; // JSON.parse(result.d);

                    if (returnData.FinishFlag == "0") {
                        alert(returnData.FinishMessage); 
                    }
                    else if (returnData.FinishFlag == "1") {
                        alert(returnData.FinishMessage);
                        $('#divInfo').modal('hide');
                        table.fnDraw();
                    } 
                    $(window).loading("hideLoading");
                },
                error: function (error) {
                    $(window).loading("hideLoading");
                }
            });
        });

        $("#btnDelete").bind("click", function () {
            if (confirm("确定要删除吗？")) {
                var ids = [];
                $.each($('#tableList td input:checkbox'), function (index, item) {
                    $this = $(this);
                    if ($this.is(':checked')) {
                        ids.push($this.attr("campusid"))
                    }
                });
                if (ids.length == 0) {
                    alert('请选择数据');
                } else {

                    $(window).loading("showLoading");
                    var os = MY_JSON.stringify(ids);
                    $.ajax({
                        type: 'POST',
                        contentType: "application/json; charset=utf-8",
                        url: "CampusManager.aspx/Delete",
                        data: "{'ids':" + os + "}",
                        dataType: "json",
                        success: function (result) {
                            var returnData = result.d; // JSON.parse(result.d);
                            if (returnData.FinishFlag == "0") {
                                return false;
                            }
                            else if (returnData.FinishFlag == "1") {
                                alert(returnData.FinishMessage);
                                table.fnDraw();
                            }
                            $(window).loading("hideLoading");
                        },
                        error: function (error) {
                            $(window).loading("hideLoading");
                        }
                    });
                }
            }
        });


    }
}
