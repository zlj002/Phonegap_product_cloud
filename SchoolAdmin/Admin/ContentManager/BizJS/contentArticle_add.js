
/*angular 模块*/
var app = angular.module("app", []);
app.controller("page", function ($scope) {
    var ue1 = UE.getEditor('editor1');
    //加载上传控件
    $("#btnSelectFile").ourUpload("init", {
        success: function (obj, data, status, settings) {
            $.each(data, function (index, item) {
                if (item.UploadStatus == "0") {
                    //alert(item.ErrorMessage);
                    layer.msg(item.ErrorMessage, 1, 0);
                    return false;
                }
                //文件连接部分 
                $("#image").attr("src", item.FilePath);
            });
        }
    });
    $("#imgAddSlide").ourUpload("init", {});

    $scope.cancel = function () {
        history.go(-1);
    }
    $scope.changeRecommend = function (type) {
        switch (type) {
            case "top":
                $scope.entity.isTop = !$scope.entity.isTop;
                break;
            case "recommend":
                $scope.entity.isRecommend = !$scope.entity.isRecommend;
                break;
            case "hot":
                $scope.entity.isHot = !$scope.entity.isHot;
                break;
            case "slide":
                $scope.entity.isSlide = !$scope.entity.isSlide;
                break;
        }
    }
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
    //获取具体实体数据
    $scope.getEntity = function () {
        $(window).loading("showLoading");

        var id = urlHelper.getQueryString('id');

        if (id != null && id != "") {
            var url = "Handler/contentHandler.ashx?action=getEntityArticle&id=" + id;
            //参数
            var para = {};
            return $.ajax({
                type: 'get',
                url: url,
                dataType: "json",
                data: para,
                success: function (result) {
                    if (result.FinishFlag == 1) {
                        $scope.entity = result.Entity;
                        // 树形选择
                        var node = zTree.getNodeByParam("id", $scope.entity.CategoryID, null);
                        if (node) {
                            zTree.selectNode(node);
                            $("#citySel").val(node.name);
                        }
                        if ($scope.entity.ArticleContent) {
                            //富文本
                            ue1.ready(function () {
                                ue1.setContent($scope.entity.ArticleContent, false);
                            });
                        }
                        $("#image").attr("src", $scope.entity.CoverImage);
                        //推荐类型推荐类型 0--普通, 1--置顶,2--推荐 3--热门, 4--幻灯片，可多选 ;号分割
                        $scope.entity.isTop = false;
                        $scope.entity.isRecommend = false;
                        $scope.entity.isHot = false;
                        $scope.entity.isSlide = false;
                        var recommendTypes = $scope.entity.RecommendType.split(';');
                        if (recommendTypes.length > 0) {
                            $.each(recommendTypes, function (index, item) {
                                if (item == "1") {
                                    $scope.entity.isTop = true;
                                }
                                if (item == "2") {
                                    $scope.entity.isRecommend = true;
                                }
                                if (item == "3") {
                                    $scope.entity.isHot = true;
                                }
                                if (item == "4") {
                                    $scope.entity.isSlide = true;
                                }

                            })
                        }
                        
                        var tempFiles = [];
                        $.each($scope.entity.Content_ArticleSlide,function(index,item){
                            var temp = {};
                            temp.FileGuid=item.SlideID;
                            temp.NewFileName = item.SlideFileName;
                            temp.FilePath = item.SlideImageUrl;
                            temp.FileSize = item.SlideFileSize;
                            temp.UploadStatus = 1;
                            tempFiles.push(temp);
                        });


                        $("#imgAddSlide").ourUpload("initData", tempFiles);
                        $scope.$digest();
                    } else {
                        //alert(result.FinishMessage);
                        layer.msg(result.FinishMessage, 1, 0);
                    }

                    $(window).loading("hideLoading");
                },
                error: function (error) {
                    $(window).loading("hideLoading");
                    //alert("服务器配置异常");

                    layer.msg("服务器配置异常", 1, 0);
                }
            });
        } else {
            $scope.entity = {};
            $scope.entity.isTop = false;
            $scope.entity.isRecommend = false;
            $scope.entity.isHot = false;
            $scope.entity.isSlide = false;
            $scope.entity.BrowseCount = 0;
            $scope.entity.DisplayIndex = 0;
            $scope.$digest();
            $(window).loading("hideLoading");
        }
    }
    //提交数据
    $scope.submit = function () {


        //特殊处理，手工指定 
        node = zTree.getSelectedNodes()[0];
        if (node) {
            $scope.entity.CategoryID = node.id;
        } else {
            layer.msg("请选择栏目", 1, 1);
            return false;
        }
        //BrowseCount  DiaplayIndex
        if (isNaN(parseInt($scope.entity.BrowseCount))) {
            layer.msg("浏览次数请输入数字", 1, 1);
            return false;
        }
        if (isNaN(parseInt($scope.entity.DisplayIndex))) {
            layer.msg("显示顺序请输入整数", 1, 1);
            return false;
        }
        //推荐类型推荐类型 0--普通, 1--置顶,2--推荐 3--热门, 4--幻灯片，可多选 ;号分割
        $scope.entity.RecommendType = "0";
        if ($scope.entity.isTop) {
            $scope.entity.RecommendType += ";1"
        }
        if ($scope.entity.isRecommend) {
            $scope.entity.RecommendType += ";2"
        }
        if ($scope.entity.isHot) {
            $scope.entity.RecommendType += ";3"
        }
        if ($scope.entity.isSlide) {
            $scope.entity.RecommendType += ";4"

            var filesList = $("#imgAddSlide").ourUpload("getFiles");
            var content_ArticleSlide = [];
            //获取时这样判断
            if (filesList != false) {
                //{"NewFileName":"1_23.png","FilePath":"/upload/Attachment/2015/2/1_23.png","FileSize":"52.67"}]
                $.each(filesList, function (index, item) {
                    var tempSlide = {};
                    tempSlide.SlideFileName = item.NewFileName;
                    tempSlide.SlideImageUrl = item.FilePath;
                    tempSlide.SlideTitle = item.NewFileName;
                    tempSlide.SlideFileSize = item.FileSize;
                    content_ArticleSlide.push(tempSlide);
                });

            }
            $scope.entity.Content_ArticleSlide = content_ArticleSlide;
        }
        //封面
        $scope.entity.CoverImage = $("#image").attr("src");
        $scope.entity.PublishTime = $("#timer_PublishTime").val();
        $scope.entity.ArticleContent = ue1.getContent();
        var url = "Handler/contentHandler.ashx";
        //参数
        var para = { "entity": MY_JSON.stringify($scope.entity), "action": "InsertOrUpdateArticle" };
        $(window).loading("showLoading");
        $.ajax({
            type: 'post',
            url: url,
            data: para,
            dataType: "json",
            success: function (result) {
                if (result.FinishFlag == 1) {
                    //alert("操作成功");
                    layer.msg("操作成功", 1, 1);
                    history.go(-1);
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
    //初始化数据
    $scope.dataBind = function () {
        $.when(
             $scope.bindTree()
            ).done(function () {
                $scope.getEntity();
            });
    }
    $scope.dataBind();
});

