$(
    //--Start柱状图-----
function () {

    var data1 = [{ name: 'olive', value: 50 }, { name: 'only', value: 120 }, { name: 'momo', value: 70 }];
    var data2 = ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'];
    var option = ECharts.ChartOptionTemplates.Bar(data1, data2, "访问量");

    var container = $("#div1")[0];

    opt = ECharts.ChartConfig(container, option);

    ECharts.Charts.RenderChart(opt);

}
);
//--End柱状图-----

//--Start仪表盘--

$(

function () {

    var data = [{ name: '完成率', value: 80 }];

    var option = ECharts.ChartOptionTemplates.Gauge(data, "业务指标");

    var container = $("#div2")[0];

    opt = ECharts.ChartConfig(container, option);

    ECharts.Charts.RenderChart(opt);

}

);
//--End仪表盘--




//--Start饼状图
$(

function () {

    var data = [{ name: 'olive', value: 50 }, { name: 'only', value: 120 }, { name: 'momo', value: 80 }];

    var option = ECharts.ChartOptionTemplates.Pie(data);

    var container = $("#div4")[0];

    opt = ECharts.ChartConfig(container, option);

    ECharts.Charts.RenderChart(opt);

}

);
//--End饼状图


//--Start曲线图
$(function () {
    var data_XQ = [156, 266, 89,306,244,420,184];
    var option = ECharts.ChartOptionTemplates.Line(data_XQ, "本周用户数图", "");

    var container = $("#div3")[0];

    opt = ECharts.ChartConfig(container, option);

    ECharts.Charts.RenderChart(opt);
});
//--End曲线图