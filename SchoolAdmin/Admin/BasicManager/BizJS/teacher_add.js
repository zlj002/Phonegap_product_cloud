$.ajaxSetup({ cache: false });
/*angular 模块*/
var app = angular.module("app", []);
app.controller("page", function ($scope) {

    $scope.cancel = function () {
        history.go(-1);
    }
    //初始化上传控件

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

    //实践天数合计
    $("#text_PracticeWorkingDays,#text_PracticeNotWorkingDays").unbind().on("change", function () {
        $("#div_PracticeTotalWorkingDays").html("");
        var text_PracticeWorkingDays = $("#text_PracticeWorkingDays").val();
        var text_PracticeNotWorkingDays = $("#text_PracticeNotWorkingDays").val();
        if (!isNaN(parseInt(text_PracticeWorkingDays)) && !isNaN(parseInt(text_PracticeNotWorkingDays))) {
            $("#div_PracticeTotalWorkingDays").html(parseInt(text_PracticeWorkingDays) + parseInt(text_PracticeNotWorkingDays));
        }
    });



    //初始化数据
    $scope.dataBind = function () {

        //绑定其他相关的数据 
        $.when(
            $scope.getPoliticalList(),
            //$scope.getTrainingCenterList(),
            $scope.getHealthyList(),
            $scope.getNativePlaceList(),
            $scope.getEthnicList(),
            $scope.getJobTypeList(),
            $scope.getSKLXList(),
            $scope.getTeacherPropertyList(),
            $scope.getEducationList(),
            $scope.getDegreeList(),
            $scope.getLanguageList(),
            $scope.getLevelAttainedList(),
            $scope.getTeachSpecialtyList(),
            $scope.getDisciplineList(),
            $scope.getLevelList(),
            $scope.getTechnicalTitleList(),
            $scope.getKYJBList(),
            $scope.getHJJSList(),
            $scope.getPXXZList(),
            $scope.getJLJBList(),
            $scope.getHJLBList(),
            $scope.getJLMCList(),
            $scope.getHYList(),
            $scope.getGZLXList(),
            $scope.getZYJNLevelList(),
            $scope.getEntity()
            ).done(function () {
                $(".chosen-select").chosen({
                    no_results_text: "没有找到",
                    placeholder_text: "请选择",
                    allow_single_de: true,
                    search_contains: true,
                    disable_search_threshold: 20
                });
            });


    }

    //获取具体实体数据
    $scope.getEntity = function () {
        $(window).loading("showLoading");

        var id = urlHelper.getQueryString('id');
        var selfid = urlHelper.getQueryString('selfid');
        if (selfid != null && selfid != "") {
            id = selfid;
        }
        if (id != null && id != "") {
            var url = "Handler/teacherHandler.ashx?action=getEntity&id=" + id;
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

                        $scope.$digest();
                        if ($scope.entity.PhotoUrl == null || $scope.entity.PhotoUrl == "") {
                            $scope.entity.PhotoUrl = "../../images/NoImage.jpg"
                        } else {
                            $("#image").attr("src", $scope.entity.PhotoUrl);
                        }

                        //显示实训室列表
                        //$scope.DisplayRoomListNames($scope.entity.Basic_TrainingRoom_Teacher);
                        //初始化时间轴
                        $scope.initTimeLine();


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
            $scope.entity.Basic_TrainingRoom_Teacher = [];
        }
    }

    //初始化时间轴插件
    $scope.initTimeLine = function () {
        $('.year').unbind().on("click", function () {
            $('.event_year>li').removeClass('current');
            $(this).parent('li').addClass('current');
            var year = $(this).attr('for');
            $('#' + year).parent().prevAll('div').slideUp(800);
            $('#' + year).parent().slideDown(800).nextAll('div').slideDown(800);
        });
        //控制显示隐藏
        $(".eventName").hover(function () {
            $(this).find("a").show();
        }, function () { $(this).find("a").hide(); });
        $(".eventOperationDel").unbind().on("click", function () {
            if (confirm("确定要删除吗？")) {
                $(window).loading("showLoading");

                var dataType = $(this).attr("dataType");
                var id = $(this).attr("dataid");
                var url = "Handler/teacherHandler.ashx";
                //参数 
                var para = { "action": "DeleteOtherInfo", "id": id, "dataType": dataType };
                $.ajax({
                    type: 'post',
                    url: url,
                    data: para,
                    dataType: "json",
                    success: function (result) {
                        if (result.FinishFlag == 1) {
                            $scope.getEntity();
                            $scope.$digest();
                        } else {
                            //alert(result.FinishMessage);
                            layer.msg(result.FinishMessage, 1, 0);
                        }

                        $(window).loading("hideLoading");
                    }
                });
            }
        });
        $(".eventOperationUpdate").unbind().on("click", function () {

            var dataType = $(this).attr("dataType");

            var id = $(this).attr("dataid");
            var url = "Handler/teacherHandler.ashx";
            //参数 
            var para = { "action": "GetOtherInfoDetail", "id": id, "dataType": dataType };
            $(window).loading("showLoading");
            $.ajax({
                type: 'post',
                url: url,
                data: para,
                dataType: "json",
                success: function (result) {
                    if (result.FinishFlag == 1) {
                        if (dataType == "fruit") {
                            $("#frmJKY").modal();
                            $scope.entityFruit = result.EntityFruit;
                        } else if (dataType == "training") {
                            $("#frmPXXX").modal();
                            $scope.entityTraining = result.EntityTraining;
                        } else if (dataType == "reward") {
                            $("#frmJLXX").modal();
                            $scope.entityReward = result.EntityReward;
                        } else if (dataType == "education") {
                            $("#frmXLJX").modal();
                            $scope.entityEducation = result.EntityEducation;



                        } else if (dataType == "practice") {
                            $("#frmQYSJ").modal();
                            $scope.entityPractice = result.EntityPractice;
                            //天数特殊处理
                            $("#div_PracticeTotalWorkingDays").html("");
                            if (!isNaN($scope.entityPractice.WorkingDays) && !isNaN($scope.entityPractice.NotWorkingDays)) {
                                $("#div_PracticeTotalWorkingDays").html(parseInt($scope.entityPractice.WorkingDays) + parseInt($scope.entityPractice.NotWorkingDays));
                            }
                            //内容和成果特殊处理

                            $('input[name="PracticeContent"]').each(function () {
                                that = $(this);
                                that.prop("checked", false);
                                var domValue = that.val();
                                if ($scope.entityPractice.PracticeContent != null && $scope.entityPractice.PracticeContent != "") {
                                    var contents = $scope.entityPractice.PracticeContent.split(";");
                                    $.each(contents, function (index, item) {
                                        if (item == domValue) {
                                            that.prop("checked", "checked");
                                        }
                                    });
                                }
                            });


                            $('input[name="Achievement"]').each(function () {
                                that = $(this);
                                that.prop("checked", false);
                                var domValue = that.val();
                                if ($scope.entityPractice.Achievement != null && $scope.entityPractice.Achievement != "") {
                                    var contents = $scope.entityPractice.Achievement.split(";");
                                    $.each(contents, function (index, item) {
                                        if (item == domValue) {
                                            that.prop("checked", "checked");
                                        }
                                    });
                                }
                            });

                        } else if (dataType == "experience") {
                            $("#frmGZJL").modal();
                            $scope.entityExperience = result.EntityExperience;
                        }

                        $scope.$digest();
                    } else {
                        //alert(result.FinishMessage);
                        layer.msg(result.FinishMessage, 1, 0);
                    }

                    $(window).loading("hideLoading");
                }
            });
        });
    }

    //绑定实训中心
    $scope.getTrainingCenterList = function () {
        //var dtd = $.Deferred();
        var url = "Handler/sxzxHandler.ashx";
        //参数 
        var para = {};
        return $.ajax({
            type: 'get',
            url: url,
            data: MY_JSON.stringify(para),
            dataType: "json",
            beforeSend: function (XMLHttpRequest) {
                $(window).loading("showLoading");
            },
            success: function (result) {
                $scope.centerList = result.List;
                $scope.$digest();

                $(window).loading("hideLoading");
                //dtd.resolve();
            }
        });
        //return dtd.promise();
    }
    //行业
    $scope.getHYList = function () {
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_HY" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.hyList = result.List;
                $scope.$digest();
            }
        });
    }
    //工作类型
    $scope.getGZLXList = function () {
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_GZLX" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.gzlxList = result.List;
                $scope.$digest();
            }
        });
    }
    //奖励名称
    $scope.getJLMCList = function () {
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_JLMC" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.jlmcList = result.List;
                $scope.$digest();
            }
        });
    }
    //获奖类别
    $scope.getHJLBList = function () {
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_HJLB" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.hjlbList = result.List;
                $scope.$digest();
            }
        });
    }
    //奖励级别
    $scope.getJLJBList = function () {
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_JLJB" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.jljbList = result.List;
                $scope.$digest();
            }
        });
    }
    //培训性质
    $scope.getPXXZList = function () {
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_PXXZ" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.pxxzList = result.List;
                $scope.$digest();
            }
        });
    }
    //获奖角色
    $scope.getHJJSList = function () {
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_HJJS" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.hjjsList = result.List;
                $scope.$digest();
            }
        });
    }
    //科研级别
    $scope.getKYJBList = function () {
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_KYJB" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.kyjbList = result.List;
                $scope.$digest();
            }
        });
    }

    //政治面貌
    $scope.getPoliticalList = function () {
        //var dtd = $.Deferred(); //在函数内部，新建一个Deferred对象
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_ZZMM" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.politicalList = result.List;
                //$scope.entity = {};
                //$scope.entity.Political = "654";
                $scope.$digest();

                //dtd.resolve();
            }
        });
        //return dtd.promise();
    }
    ////健康状况
    $scope.getHealthyList = function () {
        //var dtd = $.Deferred(); //在函数内部，新建一个Deferred对象
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_JKZK" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.healthyList = result.List;
                $scope.$digest();
                //dtd.resolve();

            }
        });
        //return dtd.promise(); // 返回promise对象
    }
    ////籍贯
    //nativePlaceList
    $scope.getNativePlaceList = function () {
        //var dtd = $.Deferred();
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_JG" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.nativePlaceList = result.List;
                $scope.$digest();

                //dtd.resolve();
            }
        });
        //return dtd.promise();
    }
    ////民族
    //ethnicList
    $scope.getEthnicList = function () {
        //var dtd = $.Deferred();
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_MZ" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.ethnicList = result.List;
                $scope.$digest();

                //dtd.resolve();
            }
        });
        //return dtd.promise();
    }
    ////岗位类型
    //jobTypeList
    $scope.getJobTypeList = function () {
        //var dtd = $.Deferred();
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_GWLX" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.jobTypeList = result.List;
                $scope.$digest();
                //dtd.resolve();
            }
        });
        //return dtd.promise();
    }
    //授课类型
    $scope.getSKLXList = function () {
        //var dtd = $.Deferred();
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_SKLX" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.sklxList = result.List;
                $scope.$digest();
                //dtd.resolve();
            }
        });
        //return dtd.promise();
    }



    ////教学性质
    //teacherPropertyList
    $scope.getTeacherPropertyList = function () {
        //var dtd = $.Deferred();
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_JSXZ" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.teacherPropertyList = result.List;
                $scope.$digest();

                //dtd.resolve();
            }
        });
        //return dtd.promise();
    }
    ////学历
    //educationList
    $scope.getEducationList = function () {
        //var dtd = $.Deferred();
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_XL" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.educationList = result.List;
                $scope.$digest();

                //dtd.resolve();
            }
        });
        //return dtd.promise();
    }
    ////学位
    //degreeList
    $scope.getDegreeList = function () {
        //var dtd = $.Deferred();
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_XW" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.degreeList = result.List;
                $scope.$digest();

                //dtd.resolve();
            }
        });
        //return dtd.promise();
    }
    ////语种
    //languageList
    $scope.getLanguageList = function () {
        //var dtd = $.Deferred();
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_WY" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.languageList = result.List;
                $scope.$digest();

                //dtd.resolve();
            }
        });
        //return dtd.promise();
    }
    ////掌握程度
    //levelAttainedList
    $scope.getLevelAttainedList = function () {
        //var dtd = $.Deferred();
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_ZWCD" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.levelAttainedList = result.List;
                $scope.$digest();

                //dtd.resolve();
            }
        });
        //return dtd.promise();
    }
    ////任教专业
    //teachSpecialtyList
    $scope.getTeachSpecialtyList = function () {
        //var dtd = $.Deferred();
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_RJZY" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.teachSpecialtyList = result.List;
                $scope.$digest();

                //dtd.resolve();
            }
        });
        //return dtd.promise();
    }
    ////任教学科
    //disciplineList
    $scope.getDisciplineList = function () {
        //var dtd = $.Deferred();
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_RJXK" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.disciplineList = result.List;
                $scope.$digest();

                //dtd.resolve();
            }
        });
        //return dtd.promise();
    }
    ////等级
    //levelList
    $scope.getLevelList = function () {
        //var dtd = $.Deferred();
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_ZSDJ" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.levelList = result.List;
                $scope.$digest();

                //dtd.resolve();
            }
        });
        //return dtd.promise();
    }

    //职业技能等级
    $scope.getZYJNLevelList = function () {
        //var dtd = $.Deferred();
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_ZYJNDJ" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.zyjnLevelList = result.List;
                $scope.$digest();

                //dtd.resolve();
            }
        });
        //return dtd.promise();
    }
    ////职称
    //technicalTitleList
    $scope.getTechnicalTitleList = function () {
        //var dtd = $.Deferred();
        var url = "Handler/dicHandler.ashx";
        var param = { "action": "GETLIST", "DictCodeType": "DM_ZYJSZC" };
        //参数
        return $.ajax({
            type: 'get',
            url: url,
            data: param,
            dataType: "json",
            success: function (result) {
                $scope.technicalTitleList = result.List;
                $scope.$digest();

                //dtd.resolve();
            }
        });
        //return dtd.promise();
    }
    //提交数据
    $scope.submit = function () {


        //特殊处理，手工指定 
        $scope.entity.Birthday = $("#timer_Birthday").val();
        $scope.entity.GetDate1 = $("#timer_GetDate1").val();
        $scope.entity.GetDate2 = $("#timer_GetDate2").val();
        $scope.entity.GetDate3 = $("#timer_GetDate3").val();
        $scope.entity.GetDate4 = $("#timer_GetDate4").val();
        $scope.entity.GetDate5 = $("#timer_GetDate5").val();
        $scope.entity.PhotoUrl = $("#image").attr("src");
        if ($scope.entity.Birthday == null || $scope.entity.Birthday == "") {
            layer.alert("请输入出生日期", 0);
            return false;
        }
        $scope.entity.TechnicalGetDate = $("#timer_TechnicalGetDate").val();


        if ($scope.entity.Sex == 1) {
            $scope.entity.Sex = true;
        } else {
            $scope.entity.Sex = false;
        }
        if ($scope.entity.IsManager == 1) {
            $scope.entity.IsManager = true;
        } else {
            $scope.entity.IsManager = false;
        }
  
        var url = "Handler/teacherHandler.ashx";
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
                    //alert("操作成功");
                    layer.msg("操作成功", 1, 1);
                    history.go(-1);
                } else {
                    //layer.msg(result.FinishMessage, 1, 0);
                    layer.alert(result.FinishMessage, 0);
                    //alert(result.FinishMessage);
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
    //提高其他信息明细
    $scope.sumitOtherInfoDetail = function (dataType) {



        if (dataType == "fruit") {

            //特殊处理，手工指定 
            $scope.entityFruit.GetDate = $("#timer_FruitGetDate").val();
            if ($scope.entityFruit.GetDate == null || $scope.entityFruit.GetDate == "") {
                //alert("请输入时间");
                layer.msg("请输入时间", 1, 0);
                return false;
            }
            $scope.entityFruit.TeacherID = $scope.entity.ID;

            var url = "Handler/teacherHandler.ashx";
            //参数
            var para = { "entity": MY_JSON.stringify($scope.entityFruit), "action": "InsertOrUpdateOtherInfoDetail", "dataType": dataType };
            $(window).loading("showLoading");
            $.ajax({
                type: 'post',
                url: url,
                data: para,
                dataType: "json",
                success: function (result) {
                    if (result.FinishFlag == 1) {

                        $scope.getEntity();
                        $scope.$digest();
                        //alert("保存成功");
                        layer.msg("保存成功", 1, 1);
                        $("#frmJKY").modal('hide');

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
        } else if (dataType == "training") {
            //特殊处理，手工指定  
            $scope.entityTraining.BeginDate = $("#timer_TrainingBeginDate").val();
            $scope.entityTraining.EndDate = $("#timer_TrainingEndDate").val();
            if ($scope.entityTraining.BeginDate == null || $scope.entityTraining.BeginDate == "") {
                //alert("请输入开始时间");
                layer.msg("请输入开始时间", 1, 0);
                return false;
            }
            if ($scope.entityTraining.EndDate == null || $scope.entityTraining.EndDate == "") {
                //alert("请输入结束时间");
                layer.msg("请输入结束时间", 1, 0);
                return false;
            }
            $scope.entityTraining.TeacherID = $scope.entity.ID;
            var url = "Handler/teacherHandler.ashx";
            //参数
            var para = { "entity": MY_JSON.stringify($scope.entityTraining), "action": "InsertOrUpdateOtherInfoDetail", "dataType": dataType };
            $(window).loading("showLoading");

            $.ajax({
                type: 'post',
                url: url,
                data: para,
                dataType: "json",
                success: function (result) {
                    if (result.FinishFlag == 1) {
                        $scope.getEntity();
                        $scope.$digest();
                        //alert("保存成功");
                        layer.msg("保存成功", 1, 1);
                        $("#frmPXXX").modal('hide');
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
        } else if (dataType == "reward") {

            //特殊处理，手工指定 
            $scope.entityReward.GetDate = $("#timer_RewardGetDate").val();
            if ($scope.entityReward.GetDate == null || $scope.entityReward.GetDate == "") {
                //alert("请输入颁奖日期");
                layer.msg("请输入颁奖日期", 1, 0);
                return false;
            }
            $scope.entityReward.TeacherID = $scope.entity.ID;
            var url = "Handler/teacherHandler.ashx";
            //参数
            var para = { "entity": MY_JSON.stringify($scope.entityReward), "action": "InsertOrUpdateOtherInfoDetail", "dataType": dataType };
            $(window).loading("showLoading");
            $.ajax({
                type: 'post',
                url: url,
                data: para,
                dataType: "json",
                success: function (result) {
                    if (result.FinishFlag == 1) {
                        $scope.getEntity();
                        $scope.$digest();
                        //alert("保存成功");
                        layer.msg("保存成功", 1, 1);
                        $("#frmJLXX").modal('hide');
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
        } else if (dataType == "education") {

            //特殊处理，手工指定 
            $scope.entityEducation.BeginDate = $("#timer_EducationBeginDate").val();
            $scope.entityEducation.EndDate = $("#timer_EducationEndDate").val();


            if ($scope.entityEducation.BeginDate == null || $scope.entityEducation.BeginDate == "") {
                //alert("请输入开始时间");
                layer.msg("请输入开始时间", 1, 0);
                return false;
            }
            $scope.entityEducation.TeacherID = $scope.entity.ID;
            var url = "Handler/teacherHandler.ashx";
            //参数
            var para = { "entity": MY_JSON.stringify($scope.entityEducation), "action": "InsertOrUpdateOtherInfoDetail", "dataType": dataType };
            $(window).loading("showLoading");
            $.ajax({
                type: 'post',
                url: url,
                data: para,
                dataType: "json",
                success: function (result) {
                    if (result.FinishFlag == 1) {
                        $scope.getEntity();
                        $scope.$digest();
                        //alert("保存成功");
                        layer.msg("保存成功", 1, 1);
                        $("#frmXLJX").modal('hide');
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
        } else if (dataType == "practice") {
            //特殊处理，手工指定 
            $scope.entityPractice.BeginDate = $("#timer_PracticeBeginDate").val();
            $scope.entityPractice.EndDate = $("#timer_PracticeEndDate").val();
            if ($scope.entityPractice.BeginDate == null || $scope.entityPractice.BeginDate == "") {
                //alert("请输入开始时间");
                layer.msg("请输入开始时间", 1, 0);
                return false;
            }
            if ($scope.entityPractice.EndDate == null || $scope.entityPractice.EndDate == "") {
                //alert("请输入结束时间");
                layer.msg("请输入结束时间", 1, 0);
                return false;
            }

            $scope.entityPractice.PracticeContent = "";
            $('input[name="PracticeContent"]').each(function () {
                that = $(this);
                if (that.prop("checked")) {
                    $scope.entityPractice.PracticeContent = ";" + $scope.entityPractice.PracticeContent + that.val() + ";";
                }
            });
            $scope.entityPractice.Achievement = "";
            $('input[name="Achievement"]').each(function () {
                that = $(this);
                if (that.prop("checked")) {
                    $scope.entityPractice.Achievement = ";" + $scope.entityPractice.Achievement + that.val() + ";";
                }
            });


            $scope.entityPractice.TeacherID = $scope.entity.ID;
            var url = "Handler/teacherHandler.ashx";
            //参数
            var para = { "entity": MY_JSON.stringify($scope.entityPractice), "action": "InsertOrUpdateOtherInfoDetail", "dataType": dataType };
            $(window).loading("showLoading");

            $.ajax({
                type: 'post',
                url: url,
                data: para,
                dataType: "json",
                success: function (result) {
                    if (result.FinishFlag == 1) {
                        $scope.getEntity();
                        $scope.$digest();
                        //alert("保存成功");
                        layer.msg("保存成功", 1, 1);
                        $("#frmQYSJ").modal('hide');
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
        } else if (dataType == "experience") {
            //特殊处理，手工指定 
            $scope.entityExperience.BeginDate = $("#timer_ExperienceBeginDate").val();
            $scope.entityExperience.EndDate = $("#timer_ExperienceEndDate").val();
            if ($scope.entityExperience.BeginDate == null || $scope.entityExperience.BeginDate == "") {
                //alert("请输入开始时间");
                layer.msg("请输入开始时间", 1, 0);
                return false;
            }
            if ($scope.entityExperience.EndDate == null || $scope.entityExperience.EndDate == "") {
                //alert("请输入结束时间");
                layer.msg("请输入结束时间", 1, 0);
                return false;
            }
            $scope.entityExperience.TeacherID = $scope.entity.ID;

            var url = "Handler/teacherHandler.ashx";
            //参数
            var para = { "entity": MY_JSON.stringify($scope.entityExperience), "action": "InsertOrUpdateOtherInfoDetail", "dataType": dataType };
            $(window).loading("showLoading");

            $.ajax({
                type: 'post',
                url: url,
                data: para,
                dataType: "json",
                success: function (result) {
                    if (result.FinishFlag == 1) {
                        $scope.getEntity();
                        $scope.$digest();
                        //alert("保存成功");
                        layer.msg("保存成功", 1, 1);
                        $("#frmGZJL").modal('hide');
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
        }



    }

    //提高其他信息明细
    $scope.addOtherInfo = function (dataType) {

        if (dataType == "fruit") {
            $("#frmJKY").modal();
            $scope.entityFruit = {};
        } else if (dataType == "training") {
            $("#frmPXXX").modal();
            $scope.entityTraining = {};
        } else if (dataType == "reward") {
            $("#frmJLXX").modal();
            $scope.entityReward = {};
        } else if (dataType == "education") {
            $("#frmXLJX").modal();
            $scope.entityEducation = {};
        } else if (dataType == "practice") {
            $("#frmQYSJ").modal();
            $scope.entityPractice = {};
        } else if (dataType == "experience") {
            $("#frmGZJL").modal();
            $scope.entityExperience = {};
        }


    }
    var table;
    //选择实训室
    $scope.selectTrainingRoom = function () {

        $('#divDialog').modal();
        var CenterID = (($scope.entity == null || $scope.entity.CenterID == "null") ? "" : $scope.entity.CenterID);
        var url = "Handler/sxsHandler.ashx?action=GetList&now=" + new Date().getTime();

        table = $('#tableList').dataTable({
            "bAutoWidth": false,
            "bStateSave": false,//缓存搜索条件
            "bServerSide": true,//是否服务端处理分页
            "bSort": false, //是否启用列排序
            'bFilter': true,  //是否使用内置的过滤功能
            'bLengthChange': false, //是否允许自定义每页显示条数
            'bPaginate': false,  //是否分页
            "bProcessing": true, //当datatable获取数据时候是否显示正在处理提示信息。
            'iDisplayLength': 10, //每页显示10条记录
            "sPaginationType": "bootstrap", //分页样式   full_numbers
            "bDestroy": true,//用于当要在同一个元素上执行新的dataTable绑定时，将之前的那个数据对象清除掉，换以新的对象设置

            //数据列
            "aoColumns": [
                {
                    "sClass": "center", "mDataProp": "ID"
                },
                {
                    "sClass": "center", "mDataProp": "Name"
                },
                {
                    "sClass": "center", "mDataProp": "CenterID"
                }

            ],
            "aoSearchCols": [null, null, { "sSearch": CenterID }],
            "oLanguage": { //国际化配置  
                "sUrl": "/plugins/jquery.DataTables/zn_CH.txt",
                "sSearch": "登录名/职工号/姓名"
            },
            "sAjaxSource": url,
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
            //数据项的属性名，默认为aaData
            "sAjaxDataProp": "List",
            //选择和操作
            "fnRowCallback": function (nRow, aData, iDataIndex) {
                $('td:eq(0),td:eq(2)', nRow).html('');
                var checkbox = $('<input title="选择" type="checkbox" id="check_' + aData.ID + '" name="check_' + aData.ID + '"  roomID="' + aData.ID + '" roomName="' + aData.Name + '" isDefault="' + aData.IsDefault + '"/>');



                checkbox.unbind().on("click", function () {
                    $(this).attr("isDefault", "0");
                    var btnDefault = $(this).parent().parent().find("[btnDefault]");
                    btnDefault.html("设为默认").removeClass("btn-info").addClass("btn-success");
                });

                $('td:eq(0)', nRow).append(checkbox);
                var btnDefault = $('<button type="button" class="btn btn-success" btnDefault>设为默认</button>');
                btnDefault.click(function () {
                    var checkbox = $(this).parent().parent().find("input:checkbox");
                    if (checkbox.attr("isDefault") != "1") {
                        //重置其他
                        $("input:checkbox[isDefault]").attr("isDefault", "0");
                        $("[btnDefault]").html("设为默认").removeClass("btn-info").addClass("btn-success");

                        btnDefault.html("取消默认").removeClass("btn-success").addClass("btn-info");
                        checkbox.attr("isDefault", "1");
                    } else {
                        checkbox.attr("isDefault", "0");
                        btnDefault.html("设为默认").removeClass("btn-info").addClass("btn-success");
                    }

                    //同时勾选
                    if (!checkbox.prop("checked")) {
                        checkbox.prop("checked", "checked");
                    }
                }); 
                $.each($scope.entity.Basic_TrainingRoom_Teacher, function (index, item) {
                    if (item.RoomID == aData.ID) {
                        checkbox.prop("checked", true);
                        if (item.IsDefault == "1") {
                            checkbox.attr("isDefault", "1");
                            btnDefault.html("取消默认").removeClass("btn-success").addClass("btn-info");
                        }

                    }
                });
                $('td:eq(2)', nRow).append(btnDefault);
                return nRow;
            },
            "fnDrawCallback": function () {
                table.prev().hide();
            }

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
    $scope.selectCenter = function (val) {
        table.DataTable().columns(2).search(
            val == null ? "" : val
        ).draw();
    }

    //构造显示实训室名称
    //$scope.DisplayRoomListNames = function (list) {
    //    $("#divTrainingRoomNames").html("");
    //    var names = "";
    //    $.each(list, function (index, item) {
    //        var defaultText = "";
    //        if (item.IsDefault == 1) {
    //            defaultText = "(默认)";
    //        }
    //        if (index != (list.length - 1)) {
    //            names += item.RoomName + defaultText + ",";
    //        } else {
    //            names += item.RoomName + defaultText;
    //        }
    //    });
    //    $("#divTrainingRoomNames").html(names);
    //}
    //选择实训室确定
    //$scope.selectRoomOK = function () {

    //    $scope.entity.Basic_TrainingRoom_Teacher = [];
    //    $('#tableList').closest('table').find('tr > td:first-child input:checkbox')
    //        .each(function (index, item) {
    //            if (this.checked) {
    //                var entity = {};
    //                entity.RoomID = $(this).attr("RoomID");
    //                entity.RoomName = $(this).attr("RoomName");
    //                entity.IsDefault = parseInt($(this).attr("IsDefault"));
    //                $scope.entity.Basic_TrainingRoom_Teacher.push(entity);

    //            }
    //        });
    //    $scope.DisplayRoomListNames($scope.entity.Basic_TrainingRoom_Teacher);
    //    $('#divDialog').modal('hide');
    //}
    //绑定初始数据
    $scope.dataBind();
});

