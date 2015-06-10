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
                    "sClass": "center", "mDataProp": "RoleID"
                },
                {
                    "sClass": "center", "mDataProp": "RoleName"
                },
                {
                    "sClass": "center", "mDataProp": "RoleName"
                }
            ],
            "oLanguage": { //国际化配置  
                "sUrl": "/plugins/jquery.DataTables/zn_CH.txt",
                "sSearch": "登录名/职工号/姓名"
            },
            "sAjaxSource": "Handler/Sys_RoleHandler.ashx?action=GetRoleList&now=" + new Date().getTime(),
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
                var checkbox = $('<input title="选择" type="checkbox" id="check_' + aData.RoleID + '" name="check_' + aData.RoleID + '"  RoleID="' + aData.RoleID + '"/>');
                $('td:eq(0)', nRow).append(checkbox);
                var btnEdit = $('<a title="编辑" style="cursor:pointer;text-decoration:none" class="green"  ><i class="icon-pencil bigger-130"></i>&nbsp;&nbsp;&nbsp;</a>');
                btnEdit.click(function () {
                    $scope.getEntity(aData.RoleID);
                });
                $('td:eq(1)', nRow).append(btnEdit);
                var btnUser = $('<a title="分配用户" style="cursor:pointer;text-decoration:none" class="green"  ><i class="icon-user bigger-130"></i>&nbsp;&nbsp;&nbsp;</a>');
                btnUser.click(function () {
                    $scope.SetUser(aData.RoleID);
                });
                $('td:eq(1)', nRow).append(btnUser);
                var btnMenu = $('<a title="分配权限" style="cursor:pointer;text-decoration:none" class="green"  ><i class="icon-star bigger-130"></i>&nbsp;&nbsp;&nbsp;</a>');
                btnMenu.click(function () {
                    $scope.SetMenu(aData.RoleID);
                });
                $('td:eq(1)', nRow).append(btnMenu);

                if (aData.IsLockUser == "1") {
                    var btnLock = $('<a title="解锁" style="cursor:pointer;text-decoration:none" class="green"  ><i class="icon-lock bigger-130"></i>&nbsp;&nbsp;&nbsp;</a>');
                    btnLock.click(function () {
                        $scope.changeLockStatus(aData.RoleID, "0");
                    });
                    $('td:eq(1)', nRow).append(btnLock);
                } else {
                    var btnLock = $('<a title="锁定" style="cursor:pointer;text-decoration:none" class="green"  ><i class="icon-unlock bigger-130"></i>&nbsp;&nbsp;&nbsp;</a>');
                    btnLock.click(function () {
                        $scope.changeLockStatus(aData.RoleID, "1");
                    });
                    $('td:eq(1)', nRow).append(btnLock);
                }
                return nRow;
            },
            //"searching": false,
            "fnDrawCallback": function () {
                table.prev().hide();
            }

        });
        //搜索事件
        $('input[name=RoleName].column_filter').unbind('keyup').on('keyup', function () {
            table.DataTable().columns(2).search(
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
    //修改锁定状态
    $scope.changeLockStatus = function (roleID, isLock) {
        if (confirm("锁定之后对应用户不可登录，反之可以登录，确定要操作吗？")) {


            var loading = layer.load('正在处理，请稍后...');
            var url = "Handler/Sys_RoleHandler.ashx";
            var para = { "roleID": roleID, "isLock": isLock, "action": "ChangeLockStatus" };
            $.ajax({
                type: 'POST',
                url: url,
                data: para,
                dataType: "json",
                success: function (result) {
                    if (result.FinishFlag == "0") {
                        layer.msg(result.FinishMessage, 1, 0);
                    }
                    else if (result.FinishFlag == "1") {
                        layer.msg("操作成功", 1, 1);
                        $('#tableList').DataTable().draw();
                    }
                    layer.close(loading);
                },
                error: function (error) {
                    layer.msg(error.responseText, 1, 0)
                }
            });
        }
    }
    //初始化加载列表
    $scope.bindList();

    //新增按钮事件
    $scope.btnAdd = function () {
        $('#divInfo').modal({
            keyboard: true
        });
        //重置
        $scope.role = {};
        $scope.$digest();
    }

    //删除按钮事件
    $scope.btnDelete = function () {
        if (confirm("确定要删除吗？")) {

            var roleList = [];
            $('#tableList').closest('table').find('tr > td:first-child input:checkbox')
            .each(function () {
                if (this.checked) {
                    var role = {};
                    role.RoleID = $(this).attr("RoleID");
                    roleList.push(role);
                }
            });
            var loading = layer.load('正在处理，请稍后...');
            var url = "Handler/Sys_RoleHandler.ashx";
            var para = { "list": MY_JSON.stringify(roleList), "action": "Delete" };
            $.ajax({
                type: 'POST',
                url: url,
                data: para,
                dataType: "json",
                success: function (result) {
                    if (result.FinishFlag == "0") {
                        //alert(result.FinishMessage);
                        layer.msg(result.FinishMessage, 1, 0);
                    }
                    else if (result.FinishFlag == "1") {
                        layer.msg("操作成功", 1, 1);
                        $('#tableList').DataTable().draw();
                    }
                    layer.close(loading);
                },
                error: function (error) {
                    layer.msg(error.responseText, 1, 0)
                }
            });
        }
    }

    //保存
    $scope.Save = function () {

        var loading = layer.load('正在处理，请稍后...');
        var url = "Handler/Sys_RoleHandler.ashx";
        var para = { "entity": MY_JSON.stringify($scope.role), "action": "InsertOrUpdate" };
        $.ajax({
            type: 'POST',
            url: url,
            data: para,
            dataType: "json",
            success: function (result) {
                if (result.FinishFlag == "0") {
                    //alert(result.FinishMessage);
                    layer.msg(result.FinishMessage, 1, 0);
                }
                else if (result.FinishFlag == "1") {
                    layer.msg("操作成功", 1, 1);
                    $('#divInfo').modal('hide');
                    $('#tableList').DataTable().draw();
                }
                layer.close(loading);
            },
            error: function (error) {
                layer.msg("服务器配置异常", 1, 0);
            }
        });
    }

    //获取明细
    $scope.getEntity = function (id) {
        var loading = layer.load('正在处理，请稍后...');
        var url = "Handler/Sys_RoleHandler.ashx";
        var para = { "id": id, "action": "GetEntity" };
        $.ajax({
            type: 'POST',
            url: url,
            data: para,
            dataType: "json",
            success: function (result) {

                $('#divInfo').modal({
                    keyboard: true
                });
                $scope.role = result.Entity;
                $scope.$digest();
                layer.close(loading);
            },
            error: function (error) {

            }
        });
    }

    //显示其他列表
    $scope.SetUser = function (id) {
        var table = $('#tableListUser').dataTable({
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
                    "sClass": "center", "mDataProp": "ID"
                },

                {
                    "sClass": "center", "mDataProp": "LoginID"
                },
                {
                    "sClass": "center", "mDataProp": "EmployeeID"
                },
                {
                    "sClass": "center", "mDataProp": "UserName"
                }
            ],
            "oLanguage": { //国际化配置  
                "sUrl": "/plugins/jquery.DataTables/zn_CH.txt",
                "sSearch": "角色名称"
            },
            "sAjaxSource": "Handler/Sys_UserHandler.ashx?action=GetUserList&now=" + new Date().getTime() + "&RoleID=" + id,
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
                $('td:eq(0)', nRow).html('');
                var checkbox = $('<input title="选择" type="checkbox" id="check_' + aData.RoleID + '" name="check_' + aData.ID + '"  UserID="' + aData.ID + '"/>');
                if (aData.UserIsBelongToRole) {
                    checkbox.prop("checked", "checked");
                }

                checkbox.click(function () {
                    var userIDs = [];
                    userIDs.push(aData.ID);
                    $scope.SetUsersForRoleID(id, userIDs, checkbox.prop("checked"));
                });
                $('td:eq(0)', nRow).append(checkbox);

                return nRow;
            },
            "fnDrawCallback": function () {
                table.prev().hide();
            }
        });

        //搜索事件
        $('input[name=UserName].column_filter').unbind('keyup').on('keyup', function () {
            table.DataTable().columns(3).search(
                $(this).val()
            ).draw();
        });
        //选择事件
        $('#tableListUser th input:checkbox').unbind().on('click', function () {
            var userIDs = [];
            var that = this;
            $(this).closest('table').find('tr > td:first-child input:checkbox')
            .each(function () {
                this.checked = that.checked;
                $(this).closest('tr').toggleClass('selected');

                var userID = $(this).attr("UserID");
                userIDs.push(userID);
            });
            $scope.SetUsersForRoleID(id, userIDs, that.checked);
        });
        $('#divUserList').modal({
            keyboard: true
        });
    }

    //保存设置
    $scope.SetUsersForRoleID = function (roleID, userIDs, isAdd) {
        $(window).loading("showLoading");
        //var para = {};
        //para.roleID = roleID;
        //para.userIDs = userIDs;
        //para.isAdd = isAdd;
        var para = { "roleID": roleID, "userIDs": MY_JSON.stringify(userIDs), "isAdd": isAdd.toString() };
        var url = "Handler/Sys_RoleHandler.ashx?action=SetUsersForRoleID&now=" + new Date().getTime();
        $.ajax({
            type: 'POST',
            data: para,
            url: url,
            dataType: "json",
            success: function (result) {
                $(window).loading("hideLoading");
            },
            error: function (error) {
                $(window).loading("hideLoading");
            }
        });
    }

    $scope.zTree;
    $scope.currentRoleID;
    $scope.SetMenu = function (id) {
        $scope.currentRoleID = id;
        var setting = {
            check: {
                enable: true,
                chkStyle: "checkbox"
                //,
                //chkboxType: { "Y": "s", "N": "s" }
            },
            view: {
                showLine: true,
                selectedMulti: false
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                onCheck: $scope.zTreeOnCheck
            }
        };

        $(window).loading("showLoading");
        $.ajax({
            url: "Handler/Sys_MenuHandler.ashx?action=GetMenuList&now=" + new Date().getTime() + "&RoleID=" + id,
            dataType: "json",
            type: 'POST',
            success: function (data) {
                var zNodes = data;
                $.each(zNodes, function (index, item) {
                    item.checked = item.MenuIsBelongToRole == 1 ? true : false;
                })
                $scope.zTree = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                $scope.zTree.expandAll(true);
                $(window).loading("hideLoading");
            },
            error: function (data) {
                var obj = MY_JSON.parse(data.responseText);
                alert(obj.Message);
                $(window).loading("hideLoading");
            }
        });
        $('#divMenu').modal({
            keyboard: true
        });
    }

    $scope.zTreeOnCheck = function (event, treeId, treeNode) {
        var nodes = $scope.zTree.getChangeCheckedNodes();
        var menuIDs = [];
        var menuOperations = [];
        var checked;
        $.each(nodes, function (index, item) {
            if(item.MenuType=="menu"){
                menuIDs.push(item.id);
            } else if (item.MenuType == "operation") {
                menuOperations.push(item.pId+","+item.id);
            }
            checked = treeNode.checked;
            item.checkedOld = checked;
        });
        //console.log(MY_JSON.stringify(menuIDs)+"将要》》"+checked);
        $scope.SetMenusForRoleID($scope.currentRoleID, menuIDs, checked);
        $scope.SetMenuOperationsForRoleID($scope.currentRoleID, menuOperations, checked);
    }

    $scope.SetMenusForRoleID = function (roleID, menuIDs, isAdd) {
        $(window).loading("showLoading");
        //var os = {};
        //os.roleID = roleID;
        //os.menuIDs = menuIDs;
        //os.isAdd = isAdd;

        var para = { "roleID": roleID, "menuIDs": MY_JSON.stringify(menuIDs), "isAdd": isAdd.toString() };
        var url = "Handler/Sys_RoleHandler.ashx?action=SetMenusForRoleID&now=" + new Date().getTime();
        $.ajax({
            type: 'POST',
            url: url,
            data: para,
            dataType: "json",
            success: function (result) {
                $(window).loading("hideLoading");
            },
            error: function (error) {
                $(window).loading("hideLoading");
            }
        });
    }
    $scope.SetMenuOperationsForRoleID = function (roleID, menuOperationIDs, isAdd) {
        $(window).loading("showLoading"); 
        var para = { "roleID": roleID, "menuOperationIDs": MY_JSON.stringify(menuOperationIDs), "isAdd": isAdd.toString() };
        var url = "Handler/Sys_RoleHandler.ashx?action=SetMenuOperationsForRoleID&now=" + new Date().getTime();
        $.ajax({
            type: 'POST',
            url: url,
            data: para,
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