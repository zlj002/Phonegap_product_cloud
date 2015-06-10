$.ajaxSetup({ cache: false });
/*angular 模块*/
var app = angular.module("app", []);
app.controller("page", function ($scope) {
    var table;
    //获取列表 
    $scope.bindList = function () {
        table = $('#tableList').dataTable({
            "bDestroy": true,
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
                    "sClass": "center", "mDataProp": "ID"
                },
                {
                    "sClass": "center", "mDataProp": "ID"
                },
                {
                    "sClass": "center", "mDataProp": "Name"
                },
                {
                    "sClass": "center", "mDataProp": "LoginID"
                },
                {
                    "sClass": "center", "mDataProp": "EmployeeID"
                },
                {
                    "sClass": "center", "mDataProp": "Telephone"
                }
            ],
            //"aoColumnDefs": [{ "bVisible": false, "aTargets": [6] }],//隐藏列
            "oLanguage": { //国际化配置  
                "sUrl": "/plugins/jquery.DataTables/zn_CH.txt",
                "sSearch": "登录名/职工号/姓名"
            },
            "sAjaxSource": "Handler/teacherHandler.ashx?action=GetList&now=" + new Date().getDate(),
            //数据项的属性名，默认为aaData
            "sAjaxDataProp": "List",
            //服务器端，数据回调处理  
            "fnServerData": function (sSource, aDataSet, fnCallback) {
                $.ajax({
                    dataType: 'json',
                    type: "get",
                    url: sSource,
                    data: aDataSet,
                    success: fnCallback
                });
            },
            //选择和操作
            "fnRowCallback": function (nRow, aData, iDataIndex) {
                $('td:eq(0),td:eq(1)', nRow).html('');
                var checkbox = $('<input title="选择" type="checkbox" id="check_' + aData.ID + '" name="check_' + aData.ID + '"  teacherID="' + aData.ID + '"/>');
                $('td:eq(0)', nRow).append(checkbox);
                var btnEdit = $('<a title="编辑" style="cursor:pointer;text-decoration:none" class="green"  ><i class="icon-pencil bigger-130"></i>&nbsp;&nbsp;&nbsp;</a>');
                btnEdit.click(function () {
                    location.href = "teacher_add.aspx?id=" + aData.ID;
                });
                $('td:eq(1)', nRow).append(btnEdit);

                return nRow;
            },
            //"searching":false,
            "fnDrawCallback": function () {
                table.prev().hide();
            }

        });
        //搜索事件
        $("#txtSearchUserName").unbind('keyup').on('keyup', function () {
            console.log("search...");
            table.DataTable().columns(3).search(
                $(this).val()
            ).draw();
        });
        //选择事件
        $('#tableList th input:checkbox').on('click', function () {
            var that = this;
            $(this).closest('table').find('tr > td:first-child input:checkbox')
            .each(function () {
                this.checked = that.checked;
                $(this).closest('tr').toggleClass('selected');
            });

        });
    }

    $scope.bindList();

    //删除按钮事件
    $scope.btnDelete = function () {
        var teachers = [];
        $('#tableList').closest('table').find('tr > td:first-child input:checkbox').each(function () {
            if (this.checked) {
                var entity = {};
                entity.ID = $(this).attr("teacherID");
                teachers.push(entity);
            }
        });
        if (teachers.length > 0) {
            if (confirm("确定要删除吗？")) {

                $(window).loading("showLoading");
                var para = { "action": "Delete", "teachers": MY_JSON.stringify(teachers) };
                $.ajax({
                    type: 'POST',
                    url: "Handler/teacherHandler.ashx/Delete",
                    data: para,
                    dataType: "json",
                    success: function (result) {
                        $(window).loading("hideLoading");
                        $('#tableList').DataTable().draw();
                    },
                    error: function (error) {
                        $(window).loading("hideLoading");
                    }
                });
            }
        } else {
            alert("请先选择要删除的行");
        }
    }

    $scope.Import = function () {
        $('#importDiv').modal('show');
    }

    $scope.StartImport = function () {
        var fileName = $(":file").val();
        if (fileName == "") {
            alert("请选择要上传的文件");
            return false;
        }
        var strtype = fileName.substring(fileName.length - 3, fileName.length);
        var strtype1 = fileName.substring(fileName.length - 4, fileName.length);
        strtype = strtype.toLowerCase();
        strtype1 = strtype1.toLowerCase();
        if (!(strtype == "xls" || strtype1 == "xlsx")) {
            alert("请选择.xls或xlsx格式文件！");
            return false;
        }
        $(window).loading("showLoading");
        $.ajaxFileUpload({
            url: "/Admin/OurUpload/SaveByUploadFileData.aspx?FT=Basic_TeacherInfo",
            secureuri: false,
            fileElementId: "fileupload",
            dataType: "json",
            success: function (data, status) {

                if (typeof data == 'string') {
                    data = JSON.parse(data);
                }
                if (typeof (data.error) != 'undefined') {
                    if (data.error != '') {
                        alert(data.error);
                    }
                    else {
                        alert(data.msg);
                        //批量导入成功，重新加载数据
                        $scope.bindList();
                        $('#exportMembersDiv').modal('hide');
                    }
                }
                $(window).loading("hideLoading"); 
            },
            error: function (data, status, e) {
                $(window).loading("hideLoading");

            }
        });
        $(window).loading("hideLoading");
        return true;
    }
});