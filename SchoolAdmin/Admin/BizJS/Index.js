var app = angular.module("app", []);
app.controller("Index", function ($scope) {
    var myChart;
    var equipChart;
    $scope.isTrue = true;
    $scope.showMsgForExplorer = function () {
        var msg = "";
        var userAgent = navigator.userAgent,
				rMsie = /(msie\s|trident.*rv:)([\w.]+)/,
				rFirefox = /(firefox)\/([\w.]+)/,
				rOpera = /(opera).+version\/([\w.]+)/,
				rChrome = /(chrome)\/([\w.]+)/,
				rSafari = /version\/([\w.]+).*(safari)/;
        var ua = userAgent.toLowerCase();
        function uaMatch(ua) {
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
        var browserMatch = uaMatch(userAgent.toLowerCase());
        var match = rChrome.exec(ua);
        if (match != null) {
            $scope.isTrue = true;
        }
        else {
            if (!browserMatch.browser)
            {
                msg = "检测到您的浏览器不是Chrome ";
            }
            else{
                msg = "检测到您的浏览器为" + browserMatch.browser + ":" + browserMatch.version;
            }
            $("#msg").html(msg);
            $scope.isTrue = false;
        }
        $scope.msg = msg;
        
        
    }
    //初始化各实训室资产比例图像报表
    //begin
    $scope.chart = function () {
        require(
                   [
                       'echarts',
                       'echarts/chart/bar',// 使用柱状图就加载bar模块，按需加载
                        'echarts/chart/line'
                   ],
             function (ec) {
                 if (myChart != undefined) {
                     myChart.clear();
                 }
                 myChart = ec.init(document.getElementById("proportion"));
                 //各实训室资产比例图像报表
                 $scope.getTrainingProportionByYear();
             }
        )
    }
    $scope.getTrainingProportionByYear = function () {
        var url = "/Admin/Report/Handler/AssetsCollect.ashx";
        var param = { "action": "GETYEARLIST" };
        //参数
        $.ajax({
            type: 'Post',
            url: url,
            data: param,
            dataType: "json",
            beforeSend: function (XMLHttpRequest) {
                $(window).loading("showLoading");
            },
            success: function (result) {
                if (result.FinishFlag != "1") {
                    layer.alert("服务器配置异常", 0);
                }
                var year = new Date().getFullYear();
                if (result.aaData.length > 0) {
                    year = result.aaData[0].ID;
                }
                param = { "action": "ECHARTBAR", "Year": year };
                //参数
                $.ajax({
                    type: 'Post',
                    url: url,
                    data: param,
                    dataType: "json",
                    beforeSend: function (XMLHttpRequest) {
                        $(window).loading("showLoading");
                    },
                    success: function (result) {
                        if (result.FinishFlag != "1") {
                            layer.alert("服务器配置异常", 0);
                        }
                        var Map = result.Map;
                        var legendData = result.legendData;
                        var yAxisData = result.yAxisData;
                        var seriesData = [];
                        for (var i = 0; i < legendData.length; i++) {
                            var p = legendData[i];
                            for (var j = 0; j < Map.length; j++) {

                                if (Map[j][p] != undefined && Map[j][p].length > 0) {
                                    var obj = {
                                        name: legendData[i],
                                        type: 'bar',
                                        stack: '总量',
                                        itemStyle: { normal: { label: { show: true, position: 'insideRight' } } },
                                        data: Map[j][p]
                                    }
                                    seriesData.push(obj);
                                }
                            }
                        }

                        $scope.createEchart(legendData, yAxisData, seriesData,year);
                        $scope.$digest();

                        $(window).loading("hideLoading");

                    },
                    error: function (error) {
                        $(window).loading("hideLoading");
                        layer.alert("服务器配置异常", 0);
                    }
                });
                $(window).loading("hideLoading");

            },
            error: function (error) {
                $(window).loading("hideLoading");
                layer.alert("服务器配置异常", 0);
            }
        });
    }
    $scope.createEchart = function (legendData, yAxisData, seriesData,year) {

        
        option = {
            grid: {
                x: 130
            },
            title: {
                text: '各实训室资金比例(元)',
                subtext: year + '年',
                x: 'center'
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            legend: {
                data: legendData,
                x: 'left'
            },
            toolbox: {
                show: true,
                feature: {
                    mark: { show: true },
                    dataView: { show: true, readOnly: false },
                    magicType: { show: true, type: ['line', 'bar', 'stack', 'tiled'] },// type: ['line', 'bar', 'stack', 'tiled'] },
                    restore: { show: true },
                    saveAsImage: { show: true }
                }
            },
            calculable: true,
            xAxis: [
                {
                    type: 'value'
                }
            ],
            yAxis: [
                {
                    type: 'category',
                    data: yAxisData
                }
            ],
            series: seriesData
        };
        myChart.setOption(option, true);
        myChart.refresh();

    }
    //end

    //获取设备数量
    //begin
    $scope.chartForEquip = function () {
        require(
                   [
                       'echarts',
                       'echarts/chart/pie',// 使用柱状图就加载pie模块，按需加载
                        'echarts/chart/line'
                   ],
             function (ec) {
                 if (equipChart != undefined) {
                     equipChart.clear();
                 }
                 equipChart = ec.init(document.getElementById("main"));
                 //各实训室资产比例图像报表
                 $scope.getEquipNum();
             }
        )
    }
    $scope.getEquipNum = function () {
       
        var url = "Handler/IndexHandler.ashx";
        var param = { "action": "GETEQUIPNUM"};
        //参数
        $.ajax({
            type: 'Post',
            url: url,
            data: param,
            dataType: "json",
            beforeSend: function (XMLHttpRequest) {
                $(window).loading("showLoading");
            },
            success: function (result) {
                if (result.FinishFlag != "1") {
                    layer.alert("服务器配置异常", 0);
                }
                var aaData = result.aaData;
                var legendData = result.DeviceTypes;
                var seriesData = [];
                for (var i = 0; i < aaData.length; i++) {
                    var obj = { value: aaData[i].TotalAmount, name: aaData[i].DeviceType };
                    seriesData.push(obj);
                }

                $scope.createEquipNumEchart(legendData,seriesData);
                $scope.$digest();

                $(window).loading("hideLoading");

            },
            error: function (error) {
                $(window).loading("hideLoading");
                layer.alert("服务器配置异常", 0);
            }
        });
    }
    $scope.createEquipNumEchart=function(legendData,seriesData)
    {
        option = {
            title: {
                text: '设备组成',
                //subtext: '2014年',
                x: 'center'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                x: 'left',
                data: legendData
            },
            toolbox: {
                show: true,
                feature: {
                    mark: { show: true },
                    dataView: { show: true, readOnly: false },
                    restore: { show: true },
                    saveAsImage: { show: true }
                }
            },
            calculable: true,
            series: [
                {
                    name: '所占比例',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: seriesData
                }
            ]
        };
        // 为echarts对象加载数据 
        equipChart.setOption(option);
        equipChart.refresh();
    }
    //end
    //获取待办列表
    $scope.Cangku=function() {
        var url = "/Admin/Assets/Handler/wareHouseHandler.ashx";
        $.post(url, { "action": "GETLISTBYMANAGERID" },
            function (result) {
                if (result.FinishFlag == 1) {
                    allHouslist = result.List;
                    var HouIds = "";
                    for (var i = 0; i < allHouslist.length; i++) {
                        HouIds += allHouslist[i].ID+",";
                    }
                    if(HouIds!="")
                    $scope.getTask(HouIds);
                }
                else {
                    alert(result.FinishMessage);
                }
            }, "json");
    };
    //获取待办列表
    $scope.getTask = function (ids) {
        var url = "Handler/IndexHandler.ashx";
        var param = { "action": "GETTASKLIST" ,"ids":ids};
        //参数
        $.ajax({
            type: 'Post',
            url: url,
            data: param,
            dataType: "json",
            beforeSend: function (XMLHttpRequest) {
                $(window).loading("showLoading");
            },
            success: function (result) {
                if (result.FinishFlag != "1") {
                    layer.alert("服务器配置异常", 0);
                }
                $scope.entitys = result.aaData;
               
                $scope.$digest();

                $(window).loading("hideLoading");

            },
            error: function (error) {
                $(window).loading("hideLoading");
                layer.alert("服务器配置异常", 0);
            }
        });
    }

    $scope.getRoomInfoNum = function () {
        var url = "Handler/IndexHandler.ashx";
        var param = { "action": "GETROOMINFONUM" };
        //参数
        $.ajax({
            type: 'Post',
            url: url,
            data: param,
            dataType: "json",
            beforeSend: function (XMLHttpRequest) {
                $(window).loading("showLoading");
            },
            success: function (result) {
                if (result.FinishFlag != "1") {
                    layer.alert("服务器配置异常", 0);
                }
                $scope.RoomInfo = result.aaData;

                $scope.$digest();

                $(window).loading("hideLoading");

            },
            error: function (error) {
                $(window).loading("hideLoading");
                layer.alert("服务器配置异常", 0);
            }
        });
    }
    $scope.GetTotalInfo = function () {
        
        var url = "/Admin/Assets/Handler/registerHandler.ashx?action=GETTOTALINFO&now=" + new Date().getDate();


         $.ajax({
            type: 'get',
            url: url,
            //data: param,
            dataType: "json",
            success: function (result) {
                $scope.AssetsInfo = result;
                $scope.$digest();
            }
        });
    }
    $scope.bind = function () {
       // $scope.showMsgForExplorer();
        $scope.chart();
        $scope.chartForEquip();
        $scope.Cangku();
        $scope.getRoomInfoNum();
        $scope.GetTotalInfo();
    }
    $scope.bind();
})