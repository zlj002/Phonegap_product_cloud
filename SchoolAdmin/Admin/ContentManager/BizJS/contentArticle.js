$.ajaxSetup({ cache: false });
/*angular 模块*/
var app = angular.module("app", []);
app.controller("page", function ($scope) {
    $('#modelName').html("内容管理");
    $('#cellName').html("");

    //显示树
    $scope.showMenu = function () {
        var cityObj = $("#citySel");
        var cityOffset = $("#citySel").offset();
        $("#menuContent").css({ left: 12 + "px", top: 0 + cityObj.outerHeight() + "px" }).slideDown("fast");

        $("body").bind("mousedown", $scope.onBodyDown);
    }
    //页面点击事件
    $scope.onBodyDown = function (event) {
        if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length > 0)) {
            $scope.hideMenu();
        }
    }
    //隐藏树
    $scope.hideMenu = function () {
        $("#menuContent").fadeOut("fast");
        $("body").unbind("mousedown", $scope.onBodyDown);
    }
    //单击树
    $scope.onClick = function (e, treeId, treeNode) {
        node = zTree.getSelectedNodes()[0];
        if (node) {
            $("#citySel").val(node.name);
        }
        $scope.hideMenu();
        $scope.bindList();
    }
    var zTree;
    $scope.bindTree = function () {
        var setting = {

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
                onClick: $scope.onClick
            }
        };
        return $.ajax({
            url: "Handler/contentHandler.ashx?action=GetCategoryList&now=" + new Date().getTime(),
            dataType: "json",
            type: 'get',
            success: function (data) {
                var zNodes = data.List;
                zTree = $.fn.zTree.init($("#tree"), setting, zNodes);

                zTree.expandAll(true);
            },
            error: function (data) {
            }
        });
    }
    //获取列表 
    $scope.bindList = function (pageIndex) {
        if (!pageIndex) {
            pageIndex = 1;
        }
        var url = "Handler/contentHandler.ashx?action=GetList";
        //参数
        var title = $("#txtTitle").val();
        var categoryID = "";
        if (zTree) {
            node = zTree.getSelectedNodes()[0];
            if (node) {
                categoryID = node.id;
            }
        }
        var para = { "pageindex": pageIndex, "pagesize": 8, "Title": title, "CategoryID": categoryID };
        //var loading = layer.load('正在处理，请稍后...');
        $(window).loading("showLoading");
        $.ajax({
            type: 'post',
            url: url,
            data: para,
            dataType: "json",
            success: function (result) {
                if (result.FinishFlag == 1) {
                    //layer.close(loading);
                    $(window).loading("hideLoading");
                    $scope.list = result.List;
                   
                    var element = $('#pageList');
                    if (result.pageCount > 0) {

                        var options = {
                            bootstrapMajorVersion: 3,
                            currentPage: pageIndex,//当前页码
                            numberOfPages: 5,//最多显示页码，其余省略
                            totalPages: result.pageCount,  //总页数
                            onPageClicked: function (e, originalEvent, type, page) {
                                console.log("Page item clicked, type: " + type + " page: " + page);
                                $scope.bindList(page);
                            }
                        }
                        element.bootstrapPaginator(options);
                        //var temp = "共" + result.pageCount + "页" + element.html();
                        var pageDesc= {};
                        pageDesc.pageIndex = pageIndex;
                        pageDesc.pageCount = result.pageCount;
                        pageDesc.totalCount = result.iTotalRecords;
                        $scope.pageDesc = pageDesc;

                    } else {
                        element.html("暂无数据");
                    }
                    $scope.$digest();

                } else {
                    layer.msg(result.FinishMessage, 1, 0);
                }
            },
            error: function (error) {
                layer.msg("服务器配置异常", 1, 0);
            }
        });

        //搜索事件
        $("#txtTitle").unbind('keyup').on('keyup', function () {
            console.log("search...");
            $scope.bindList(1);
        });
         
    }
    $scope.changeRecommend = function (entity, type) {
        switch (type) {
            case "top":
                entity.isTop = !entity.isTop;
                break;
            case "recommend":
                entity.isRecommend = !entity.isRecommend;
                break;
            case "hot":
                entity.isHot = !entity.isHot;
                break;
            case "slide":
                entity.isSlide = !entity.isSlide;
                break;
        }

        //推荐类型推荐类型 0--普通, 1--置顶,2--推荐 3--热门, 4--幻灯片，可多选 ;号分割
        entity.RecommendType = "0";
        if (entity.isTop) {
            entity.RecommendType += ";1"
        }
        if (entity.isRecommend) {
            entity.RecommendType += ";2"
        }
        if (entity.isHot) {
            entity.RecommendType += ";3"
        }
        if (entity.isSlide) {
            entity.RecommendType += ";4"
        }
        var url = "Handler/contentHandler.ashx";
        //参数
        var para = { "id": entity.ID, "action": "UpdateRecommendTypeStatus", "recommendType": entity.RecommendType };
        $(window).loading("showLoading");
        $.ajax({
            type: 'post',
            url: url,
            data: para,
            dataType: "json",
            success: function (result) {
                if (result.FinishFlag == 1) {
                    layer.msg("操作成功", 1, 1);
                } else {
                    layer.msg(result.FinishMessage, 1, 1);
                }
                $(window).loading("hideLoading");
            },
            error: function (error) {
                $(window).loading("hideLoading");
                //alert("服务器配置异常");
                layer.msg("服务器配置异常", 1, 0);
            }
        });
    }
    //勾选所有
    $scope.checkAll = function (target) {
        $('#imgList').find('input:checkbox').prop("checked", target.checked);
    }
    //删除按钮事件
    $scope.btnDelete = function () {
        var articles = [];
        $('#imgList').find('input:checkbox').each(function () {
            if (this.checked) {
                var entity = {};
                entity.ID = $(this).attr("articleID");
                articles.push(entity);
            }
        });
        if (articles.length > 0) {
            if (confirm("确定要删除吗？")) {

                $(window).loading("showLoading");
                var para = { "action": "DeleteArticle", "list": MY_JSON.stringify(articles) };
                $.ajax({
                    type: 'POST',
                    url: "Handler/contentHandler.ashx/DeleteArticle",
                    data: para,
                    dataType: "json",
                    success: function (result) {
                        $(window).loading("hideLoading");
                        if (result.FinishFlag == 1) {
                            $scope.bindList();
                        } else {
                            layer.msg(result.FinishMessage, 1, 1);
                        }
                    },
                    error: function (error) {
                        $(window).loading("hideLoading");
                        layer.msg(error.responseText, 1, 1);
                    }
                });
            }
        } else {
            layer.msg("请先选择要删除的数据", 1, 1);
        }
    }
    $scope.bindList();
    $scope.bindTree();

});