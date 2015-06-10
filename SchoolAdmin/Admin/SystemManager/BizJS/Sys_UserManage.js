/*angular 模块*/
var app = angular.module("app", []);
app.controller("page", function ($scope) {

    //获取列表 
    $scope.bindList = function () {
        var table = $('#tableList').dataTable({
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
                    "sClass": "center", "mDataProp": "LoginID"
                },
                {
                    "sClass": "center", "mDataProp": "UserName"
                }
            ],
            "oLanguage": { //国际化配置  
                "sUrl": "/plugins/jquery.DataTables/zn_CH.txt",
                "sSearch": "登录名/职工号/姓名"
            },
            "sAjaxSource": "Handler/Sys_UserHandler.ashx?action=GetUserList&now=" + new Date().getTime(),
            //数据项的属性名，默认为aaData
            "sAjaxDataProp": "List",
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
                var checkbox = $('<input title="选择" type="checkbox" id="check_' + aData.UserID + '" name="check_' + aData.UserID + '"  UserID="' + aData.UserID + '"/>');
                $('td:eq(0)', nRow).append(checkbox);
                var btnEdit = $('<a title="编辑帐号" style="cursor:pointer;text-decoration:none" class="green"  ><i class="icon-pencil bigger-130"></i>&nbsp;&nbsp;&nbsp;</a>');
                btnEdit.click(function () {
                    $scope.getEntity(aData.UserID);
                });
                $('td:eq(1)', nRow).append(btnEdit);
                var btnRole = $('<a title="所属角色" style="cursor:pointer;text-decoration:none" class="green"  ><i class="icon-user bigger-130"></i>&nbsp;&nbsp;&nbsp;</a>');
                btnRole.click(function () {
                    $scope.SetRole(aData.UserID);
                });
                $('td:eq(1)', nRow).append(btnRole);
                return nRow;
            },
            "fnDrawCallback": function () {
                table.prev().hide();
            }

        });
        //搜索事件
        $('input[name=UserName].column_filter').unbind('keyup').on('keyup', function () {
            table.DataTable().columns(4).search(
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

    //初始化加载列表
    $scope.bindList();

    //新增按钮事件
    $scope.btnAdd = function () {
        $('#divInfo').modal({
            keyboard: true
        });
        //重置
        $scope.user = {};
        $scope.$digest();
    }

    //删除按钮事件
    $scope.btnDelete = function () {
        if (confirm("确定要删除吗？")) {

            var userIDs = [];
            $('#tableList').closest('table').find('tr > td:first-child input:checkbox')
            .each(function () {
                if (this.checked) {
                    userIDs.push($(this).attr("UserID"));
                }
            });
            $(window).loading("showLoading");
            var os = {};
            os.userIDs = userIDs;
            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: "Sys_UserManage.aspx/LogicDeleteBatch",
                data: MY_JSON.stringify(os),
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
    }

    //保存
    $scope.Save = function () {
        $(window).loading("showLoading");
        var os = MY_JSON.stringify($scope.user);
        $.ajax({
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            url: "Sys_UserManage.aspx/InsertOrUpdate",
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
                    $('#tableList').DataTable().draw();
                }
                $(window).loading("hideLoading");
            },
            error: function (error) {
                $(window).loading("hideLoading");
            }
        });
    }

    //获取明细
    $scope.getEntity = function (id) {
        $(window).loading("showLoading");
        $.ajax({
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            url: "Sys_UserManage.aspx/GetEntity",
            data: "{'userID':'" + id + "'}",
            dataType: "json",
            success: function (result) {

                $('#divInfo').modal({
                    keyboard: true
                });
                $scope.user = JSON.parse(result.d); // JSON.parse(result.d);
                $scope.$digest();
                $(window).loading("hideLoading");
            },
            error: function (error) {
                $(window).loading("hideLoading");
            }
        });
    }

    //显示其他列表
    $scope.SetRole = function (id) {
        var table = $('#tableListRole').dataTable({
            "bDestroy": true,//用于当要在同一个元素上执行新的dataTable绑定时，将之前的那个数据对象清除掉，换以新的对象设置
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
                    "sClass": "center", "mDataProp": "RoleID"
                },
                {
                    "sClass": "center", "mDataProp": "RoleName"
                }
            ],
            "oLanguage": { //国际化配置  
                "sUrl": "/plugins/jquery.DataTables/zn_CH.txt",
                "sSearch": "角色名称"
            },
            "sAjaxSource": "Sys_RoleHandler.ashx?action=GetRoleList&now=" + new Date().getTime() + "&UserID=" + id,
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
                $('td:eq(0)', nRow).html('');
                var checkbox = $('<input title="选择" type="checkbox" id="check_' + aData.RoleID + '" name="check_' + aData.RoleID + '"  RoleID="' + aData.RoleID + '"/>');
                if (aData.UserIsBelongToRole) {
                    checkbox.prop("checked", "checked");
                }

                checkbox.click(function () {
                    var roleIDs = [];
                    roleIDs.push(aData.RoleID);
                    $scope.SetRolesForUserID(id, roleIDs, checkbox.prop("checked"));
                });
                $('td:eq(0)', nRow).append(checkbox);

                return nRow;
            },
            "fnDrawCallback": function () {
                table.prev().hide();
            }
        });

        //搜索事件
        $('input[name=RoleName].column_filter').unbind('keyup').on('keyup', function () {
            table.DataTable().columns(1).search(
                $(this).val()
            ).draw();
        });
        //选择事件
        $('#tableListRole th input:checkbox').unbind().on('click', function () {
            var roleIDs = [];
            var that = this;
            $(this).closest('table').find('tr > td:first-child input:checkbox')
            .each(function () {
                this.checked = that.checked;
                $(this).closest('tr').toggleClass('selected');

                var roleID = $(this).attr("RoleID");
                roleIDs.push(roleID);
            });
            $scope.SetRolesForUserID(id, roleIDs, that.checked);
        });
        $('#divRoleList').modal({
            keyboard: true
        });
    }

    //保存设置
    $scope.SetRolesForUserID = function (userID, roleIDs, isAdd) {
        $(window).loading("showLoading");
        var os = {};
        os.userID = userID;
        os.roleIDs = roleIDs;
        os.isAdd = isAdd;
        $.ajax({
            type: 'POST',
            contentType: "application/json; charset=utf-8",
            url: "Sys_UserManage.aspx/SetRolesForUserID",
            data: MY_JSON.stringify(os),
            dataType: "json",
            success: function (result) {
                $(window).loading("hideLoading");
            },
            error: function (error) {
                $(window).loading("hideLoading");
            }
        });
    }
});