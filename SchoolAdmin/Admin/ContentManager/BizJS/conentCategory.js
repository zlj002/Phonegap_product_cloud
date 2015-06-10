$.ajaxSetup({cache:false});
/*angular 模块*/
var app = angular.module("app", []);
app.controller("page", function ($scope) {
    var zTree;
    $scope.addTreeNode = function () {
        var node = zTree.getSelectedNodes()[0];
        if (node) {
            $scope.entity = {};
      
            $('#divDialog').modal();
        } else {
            layer.msg("请选择节点", 1, 1);
        }
    }
    $scope.edit = function () {
        var node = zTree.getSelectedNodes()[0];
        if (node) {
            var url = "Handler/contentHandler.ashx";
            //参数
            var para = { "id": node.id, "action": "GetEntity" };
            $(window).loading("showLoading");
            $.ajax({
                type: 'post',
                url: url,
                data: para,
                dataType: "json",
                success: function (result) {
                    if (result.FinishFlag == 1) {
                        $scope.entity = result.Entity;
                        $scope.$digest();
                        $('#divDialog').modal();
                    } else {
                        layer.msg(result.FinishMessage, 1, 0);
                    }
                    $(window).loading("hideLoading");
                },
                error: function (error) {
                    $(window).loading("hideLoading");
                    layer.msg("服务器配置异常", 1, 0);
                }
            });
        } else {
            layer.msg("请选择节点", 1, 1);
        }
    }

    $scope.removeTreeNode = function () {
        var node = zTree.getSelectedNodes()[0];
        if (node) {
            var list = [];
            var entity = {};
            entity.ID = node.id;
            list.push(entity);
            if (list.length > 0) {
                if (confirm("确定要删除吗？")) {
                    if (node.children != null && node.children.length > 0) {
                        layer.msg("请先删除子项", 1, 1);
                    } else {
                        $(window).loading("showLoading");
                        var para = { "action": "Delete", "list": MY_JSON.stringify(list) };
                        $.ajax({
                            type: 'POST',
                            url: "Handler/contentHandler.ashx/Delete",
                            data: para,
                            dataType: "json",
                            success: function (result) {
                                $(window).loading("hideLoading");
                                $scope.bindTree();
                            },
                            error: function (error) {
                                $(window).loading("hideLoading");
                            }
                        });
                    }
                }
            } else {
                layer.msg("请先选择要删除的行", 1, 1);
            }
        } else {
            layer.msg("请选择节点", 1, 1);
        }
    }

    $scope.submit = function () {
        var node = zTree.getSelectedNodes()[0];
        if (node) {
            //新增
            if ($scope.entity.ID == null || $scope.entity.ID == "") {
                //手动处理
                $scope.entity.ParentID = node.id;
            }
            var url = "Handler/contentHandler.ashx";
            //参数
            var para = { "entity": MY_JSON.stringify($scope.entity), "action": "InsertOrUpdate" };
            $(window).loading("showLoading");
            $.ajax({
                type: 'post',
                url: url,
                data: para,
                dataType: "json",
                success: function (result) {
                    if (result.FinishFlag == 1) {
                        layer.msg("操作成功", 1, 1);
                        var newNode = result.Entity;
                        node.id = newNode.id;
                        node.name = newNode.name;
                        node.pId = newNode.pId; 
                        $scope.bindTree();
                        $('#divDialog').modal("hide");
                    } else {
                        layer.msg(result.FinishMessage, 1, 0);
                    }
                    $(window).loading("hideLoading");
                },
                error: function (error) {
                    $(window).loading("hideLoading");
                    layer.msg("服务器配置异常", 1, 0);
                }
            });
        } else {
            layer.msg("请选择节点", 1, 1);
        }
    }

    $scope.bindTree = function () {
        var setting = {
            edit: {
                enable: true,
                showRemoveBtn: false,
                showRenameBtn: false,
                drag: {
                    isCopy: false,
                    prev: true,
                    inner: true,
                    next: false,
                    isMove: true
                }
            },
            view: {
                dblClickExpand: false,
                showLine: true,
                selectedMulti: false
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "id",
                    pIdKey: "pId",
                    rootPId: ""
                }
            },
            callback: {
                beforeDrag: $scope.beforeDrag,
                beforeDrop: $scope.beforeDrop
            }
        };
        $.ajax({
            url: "Handler/contentHandler.ashx?action=GetCategoryList&now=" + new Date().getTime(),
            dataType: "json",
            type: 'get',
            success: function (data) {
                var zNodes = data.List;
                zTree = $.fn.zTree.init($("#tree"), setting, zNodes);
                var nodes = zTree.getNodes();
                if (nodes.length > 0) {
                    zTree.selectNode(nodes[0]);
                }
                zTree.expandAll(true);
            },
            error: function (data) {
            }
        });
    }

    $scope.beforeDrag = function (treeId, treeNodes) {
        for (var i = 0, l = treeNodes.length; i < l; i++) {
            if (treeNodes[i].drag === false) {
                return false;
            }
        }
        return true;
    }

    //托拽
    $scope.beforeDrop = function (treeId, treeNodes, targetNode, moveType) {
        if (confirm('您确定要移动到[' + targetNode.name + ']吗?')) {
            if (targetNode ? targetNode.drop !== false : true) {
                for (var i = 0; i < treeNodes.length; i++) {
                    var objEntity = {
                        ID: treeNodes[i].id, Name: treeNodes[i].name, ParentID: targetNode.id
                    }
                    var url = "Handler/contentHandler.ashx";
                    //参数
                    var para = { "entity": MY_JSON.stringify(objEntity), "action": "InsertOrUpdate" };
                    $.ajax({
                        type: "post",
                        url: url,
                        data: para,
                        dataType: "json",
                        success: function (data) {
                            $scope.bindTree();
                        },
                        error: function (data) {

                        }
                    });
                }
            }

        } else {
            return false;
        }
    }

    $scope.bindTree();
});
