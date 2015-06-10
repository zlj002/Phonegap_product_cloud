

$(function () {
    $('#modelName').html("基础数据");
    $('#cellName').html("实训中心");

    $('#star').raty({
      
        score: 4,
        //hints: ['1', '2', '3', '4', '5'],
        path: "../plugins/raty-2.5.2/demo/img",
        starOff: 'star-off-big.png',
        starOn: 'star-on-big.png',
        size: 24
    });

 

});