

$(function () {
    $('#modelName').html("基础数据");
    $('#cellName').html("实训中心");

    $('#star1').raty({
        readOnly: true,
        score: 4,
        //hints: ['1', '2', '3', '4', '5'],
        path: "../plugins/raty-2.5.2/demo/img",      
        starOff: 'star-off-big.png',    
        starOn: 'star-on-big.png',
        size: 24
    });

    $('#star2').raty({
        readOnly: true,
        score: 4,
        //hints: ['1', '2', '3', '4', '5'],
        path: "../plugins/raty-2.5.2/demo/img",
        starOff: 'star-off-big.png',
        starOn: 'star-on-big.png',
        size: 24
    });

    $('#star3').raty({
        readOnly: true,
        score: 5,
        //hints: ['1', '2', '3', '4', '5'],
        path: "../plugins/raty-2.5.2/demo/img",
        starOff: 'star-off-big.png',
        starOn: 'star-on-big.png',
        size: 24
    });
    $('#star4').raty({
        readOnly: true,
        score: 0,
        //hints: ['1', '2', '3', '4', '5'],
        path: "../plugins/raty-2.5.2/demo/img",
        starOff: 'star-off-big.png',
        starOn: 'star-on-big.png',
        size: 24
    });

});