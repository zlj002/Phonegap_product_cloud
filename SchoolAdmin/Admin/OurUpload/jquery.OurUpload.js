//此插件需要 引用 ajaxfileupload.js
//注意上传大文件时开启限制
; (function ($) {
    var initUploadControlHtml5 = function (obj, settings) {
        $("#" + settings.fileElementId).remove();
        var fileControl = $("<input multiple type='file' id='" + settings.fileElementId + "' name='fileupload' class='transparent_class' />");
        obj.after(fileControl);
        fileControl.bind("change", function () {
            //客户端路径
            var files = document.getElementById(settings.fileElementId).files;

            var allFilesGuid = ",";
            if (files.length > 0) {
                for (var i = 0; i < files.length; i++) {
                    var file = files[i];
                    //文件名
                    var fileName = file.name;
                    //文件类型
                    var fileExtension = fileName.substring(fileName.lastIndexOf("."));
                    //唯一编号
                    var fileGuid = newGuid();
                    uploading(settings, fileName, fileExtension, fileGuid);

                    allFilesGuid += fileGuid + ",";
                }
            }



            //开始上传
            $.ajaxFileUpload({
                url: settings.url + (settings.url.indexOf("?") < 0 ? "?" : "&") + "uploadDir=" + settings.uploadDir + "&extensionLim=" + settings.extensionLim + "&fileLengthLim=" + settings.fileLengthLim + "&forbiddenExtensionLim=" + settings.forbiddenExtensionLim + "&fileGuid=" + allFilesGuid,
                secureuri: settings.secureuri,
                fileElementId: settings.fileElementId,
                dataType: settings.dataType,
                success: function (data, status) {
                    if ($.isFunction(settings.success)) {
                        settings.success(obj, data, status, settings);
                        $("#ul" + settings.fileElementId).hide();
                    } else {
                        uploadSuccess(obj, data, status, settings);
                    }
                    UpdateFiles4CustomForm(obj, settings);
                    //重新初始化上传对象
                    initUploadControlHtml5(obj, settings);
                },
                error: function (data, status, e) {
                    uploadError(obj, data, status, e, allFilesGuid);
                    //重新初始化上传对象
                    initUploadControlHtml5(obj, settings);
                }
            });

        });

    };

    //检查浏览器是否支持 html5
    var checkhHtml5 = function () {
        if (typeof (Worker) !== "undefined") {
            return true;
        } else {
            return false;
        }
    };
    //为自定义表单更新已上传的方法
    var UpdateFiles4CustomForm = function (obj, settings) {
        $this = obj;
        $("#" + $this.attr("id") + "Names").val("");
        $("#" + $this.attr("id") + "Paths").val("");
        $("#" + $this.attr("id") + "Sizes").val("");

        $.each($(".aFile", $("#ulfileupload" + $this.attr("id"))), function (index, item) {
            //辅助表单设计器写入hidden 
            if (index == 0) {
                $("#" + $this.attr("id") + "Names").val($(item).attr("NewFileName"));
                $("#" + $this.attr("id") + "Paths").val($(item).attr("FilePath"));
                $("#" + $this.attr("id") + "Sizes").val($(item).attr("FileSize"));
            } else {
                $("#" + $this.attr("id") + "Names").val($("#" + $this.attr("id") + "Names").val() + "," + $(item).attr("NewFileName"));
                $("#" + $this.attr("id") + "Paths").val($("#" + $this.attr("id") + "Paths").val() + "," + $(item).attr("FilePath"));
                $("#" + $this.attr("id") + "Sizes").val($("#" + $this.attr("id") + "Sizes").val() + "," + $(item).attr("FileSize"));
            }

        });
    };
    //生成唯一字符串
    var newGuid = function () {
        var guid = "";
        for (var i = 1; i <= 32; i++) {
            var n = Math.floor(Math.random() * 16.0).toString(16);
            guid += n;
            if ((i == 8) || (i == 12) || (i == 16) || (i == 20))
                guid += "-";
        }
        return guid;
    };
    //获取上传路径
    var getFullPath = function (obj) {
        if (obj) {
            //ie
            if (window.navigator.userAgent.indexOf("MSIE") >= 1) {
                obj.select();
                return document.selection.createRange().text;
            }
                //firefox
            else if (window.navigator.userAgent.indexOf("Firefox") >= 1) {
                if (obj.files) {
                    return obj.files.item(0).getAsDataURL();
                }
                return obj.value;
            }
            return obj.value;
        }
    };
    //获取文件名
    var getFileName = function (path) {
        var pos1 = path.lastIndexOf('/');
        var pos2 = path.lastIndexOf('\\');
        var pos = Math.max(pos1, pos2)
        if (pos < 0) {
            return path;
        }
        else {
            return path.substring(pos + 1);
        }
    };

    //默认方法，未使用
    var privateFunction = function () {
        // 执行代码
    };

    //上传插件初始，并且绑定上传事件
    var initUploadControl = function (obj, settings) {
        $("#" + settings.fileElementId).remove();
        var fileControl = $("<input  type='file' id='" + settings.fileElementId + "' name='fileupload' class='transparent_class' />");
        obj.after(fileControl);
        fileControl.bind("change", function () {
            //客户端路径
            var filePath = getFullPath(document.getElementById(settings.fileElementId));

            //文件名
            var fileName = getFileName(filePath);
            //文件类型
            var fileExtension = fileName.substring(fileName.lastIndexOf("."));
            //唯一编号
            var fileGuid = newGuid();
            uploading(settings, fileName, fileExtension, fileGuid);

            //开始上传
            $.ajaxFileUpload({
                url: settings.url + (settings.url.indexOf("?") < 0 ? "?" : "&") + "uploadDir=" + settings.uploadDir + "&extensionLim=" + settings.extensionLim + "&fileLengthLim=" + settings.fileLengthLim + "&forbiddenExtensionLim=" + settings.forbiddenExtensionLim + "&fileGuid=" + fileGuid,
                secureuri: settings.secureuri,
                fileElementId: settings.fileElementId,
                dataType: settings.dataType,
                success: function (data, status) {
                    if ($.isFunction(settings.success)) {
                        settings.success(obj, data, status, settings);
                        $("#ul" + settings.fileElementId).hide();
                    } else {
                        uploadSuccess(obj, data, status, settings);
                    }
                    UpdateFiles4CustomForm(obj, settings);
                    //重新初始化上传对象
                    initUploadControl(obj, settings);
                },
                error: function (data, status, e) {
                    uploadError(obj, data, status, e, fileGuid);
                    //重新初始化上传对象
                    initUploadControl(obj, settings);
                }
            });

        });

    };

    //上传中
    var uploading = function (settings, fileName, fileExtension, fileGuid) {
        var li = $("<li class='liIconTXT' ></li>");
        switch (fileExtension.toUpperCase()) {
            case ".DOC":
            case ".DOCX":
                li.attr("class", "liIconDoc");
                break;
            case ".XLSX":
            case ".XLS":
                li.attr("class", "liIconXls");
                break;
            case ".PPTX":
            case ".PPT":
                li.attr("class", "liIconPPT");
                break;
            case ".GIF":
            case ".JPG":
            case ".JPEG":
            case ".PNG":
                li.attr("class", "liIconIMG");
                break;
            case ".TXT":
                li.attr("class", "liIconTXT");
                break;
            case ".JS":
                li.attr("class", "liIconJS");
                break;
            default: break;
        }
        var aref = $("<a class='aFile' NewFileName='" + fileName + "' FilePath='' FileSize='' href='#' target='blank' id='" + fileGuid + "'>" + fileName + "</a>");

        aref.appendTo(li);
        var aDeleteRef = $("<a class='cancelFile' id='cancel" + fileGuid + "'>取消</a>");
        aDeleteRef.unbind().click(function () {
            if (confirm("确定取消?")) {
                $(this).parent().remove();
            }
        });
        aDeleteRef.appendTo(li);
        //正在上传
        var divOper = $("<div class='imguploading' id='loading" + fileGuid + "'></div>");
        divOper.appendTo(li);
        $("#ul" + settings.fileElementId).append(li);

    };
    //上传成功
    var uploadSuccess = function (obj, data, status, settings) {

        $.each(data, function (index, item) {
            if (item.UploadStatus == "0") {
                alert(item.ErrorMessage);
                return false;
            }
            if ($("#" + item.FileGuid).size() != 0) {
                //文件连接部分
                $("#" + item.FileGuid).attr("NewFileName", item.NewFileName);
                $("#" + item.FileGuid).attr("FilePath", item.FilePath);
                $("#" + item.FileGuid).attr("FileSize", item.FileSize);
                $("#" + item.FileGuid).attr("href", item.FilePath);
                $("#" + item.FileGuid).text(item.NewFileName + "(" + item.FileSize + "KB)");
                //取消部分
                $("#cancel" + item.FileGuid).text("删除");

                $("#cancel" + item.FileGuid).unbind().click(function () {
                    if (confirm("确定删除?")) {
                        $(this).parent().remove();
                        UpdateFiles4CustomForm(obj, settings);
                    }

                });


                //下载和预览地址 
                $("#loading" + item.FileGuid).removeAttr("class");
                if (item.FilePath != null) {
                    var arefDownload = $("<a  class='aFilePreView' href='" + item.FilePath + "' target='blank'>" + "下载" + "</a>");
                    arefDownload.appendTo($("#loading" + item.FileGuid));
                }

                if (item.HtmlFilePath != null) {
                    var arefPreView = $("<a class='aFilePreView'  href='" + item.HtmlFilePath + "' target='blank'>" + "预览" + "</a>");
                    arefPreView.appendTo($("#loading" + item.FileGuid));
                }
            }
        });
    };
    var uploadError = function (obj, data, status, e, allFilesGuid) {
        var filesGuid = allFilesGuid.split(",");
        for (var i = 0; i < filesGuid.length; i++) {
            var fileGuid = filesGuid[i];
            if (fileGuid != "") {
                var fileName = $("#" + fileGuid).attr("NewFileName");
                alert(fileName + "上传失败，请重试");
                $("#" + fileGuid).parent().remove();
            }
        }
    };
    var methods = {
        //控件初始化
        init: function (options) {
            // 在每个元素上执行方法
            return this.each(function () {
                //当前对象
                var $this = $(this);
                checkhHtml5();

                // 尝试去获取settings，如果不存在，则返回“undefined”
                var settings = $this.data('pluginName');

                // 如果获取settings失败，则根据options和default创建它
                if (typeof (settings) == 'undefined') {

                    var defaults = {
                        //默认上传路径
                        url: '/Admin/OurUpload/SaveByUploadFileData.aspx',

                        secureuri: false,

                        //默认上传文件的控件id
                        fileElementId: "fileupload" + $this.attr("id"),

                        //默认数据类型
                        dataType: "json",

                        //默认上传显示结果的控件id
                        resultDomID: "resultUploadFile" + $this.attr("id"),

                        loddingImgPath: "/OurUpload/images/loading.gif",

                        //上传路径默认上传目录:~/upload/Attachment/yyyy/MM;
                        uploadDir: "",

                        //扩展名，默认值.xls|.xlsx|.jpg|.gif|.bmp|.jpeg|.png|.rar|.zip|.doc|.docx|.txt
                        //已废弃，只设置禁止上传
                        extensionLim: "",

                        //被禁止的扩展名
                        forbiddenExtensionLim: "",

                        //默认最大文件 100M
                        fileLengthLim: "",

                        success: false,
                        error: function (data, status, e) {

                        },

                        onSomeEvent: function () { }

                    }

                    settings = $.extend({}, defaults, options);

                    //创建显示结果
                    var divResult = $("<div id='" + settings.resultDomID + "'></div>");

                    var ul = $("<ul id='ul" + settings.fileElementId + "'></ul>");

                    divResult.append(ul);



                    //为了支持表单设计器，创建3个隐藏控件,一般用户请勿关注 
                    var hdNames = $("<input type='hidden' name='" + $this.attr("name") + "Names' id='" + $this.attr("id") + "Names'/>");
                    var hdPaths = $("<input type='hidden' name='" + $this.attr("name") + "Paths' id='" + $this.attr("id") + "Paths'/>");
                    var hdSizes = $("<input type='hidden' name='" + $this.attr("name") + "Sizes' id='" + $this.attr("id") + "Sizes'/>");
                    ul.append(hdNames);
                    ul.append(hdPaths);
                    ul.append(hdSizes);
                    //**************************************************

                    $this.after(divResult);

                    // 保存我们新创建的settings
                    $this.data('pluginName', settings);
                } else {

                    // 如果我们获取了settings，则将它和options进行合并（这不是必须的，你可以选择不这样做）
                    settings = $.extend({}, settings, options);

                    // 如果你想每次都保存options，可以添加下面代码：
                    //$this.data('pluginName', settings);
                }

                // 执行代码 
                var canhtml5 = checkhHtml5();
                if (canhtml5) {
                    initUploadControlHtml5($this, settings);
                } else {
                    initUploadControl($this, settings);
                }
            });
        },
        //默认方法，未使用
        destroy: function (options) {
            // 在每个元素中执行代码
            return $(this).each(function () {
                var $this = $(this);

                // 执行代码

                // 删除元素对应的数据
                $this.removeData('pluginName');
            });
        },
        //默认方法，未使用
        val: function (options) {

            // 这里的代码通过.eq(0)来获取选择器中的第一个元素的，我们或获取它的HTML内容作为我们的返回值,可以根据情况确定
            var someValue = this.eq(0).html();

            // 返回值
            return someValue;
        },
        initData: function (files) {
            $(this).each(function () {
                var $this = $(this);
                var settings = $this.data('pluginName');
                $.each(files, function (index, item) { 
                    var fileExtension = item.NewFileName.substring(item.NewFileName.lastIndexOf("."));
                    console.log(">>>"+fileExtension+">>>>"+item.NewFileName);
                    var li = $("<li class='liIconTXT' ></li>");
                    switch (fileExtension.toUpperCase()) {
                        case ".DOC":
                        case ".DOCX":
                            li.attr("class", "liIconDoc");
                            break;
                        case ".XLSX":
                        case ".XLS":
                            li.attr("class", "liIconXls");
                            break;
                        case ".PPTX":
                        case ".PPT":
                            li.attr("class", "liIconPPT");
                            break;
                        case ".GIF":
                        case ".JPG":
                        case ".JPEG":
                        case ".PNG":
                            console.log("......");
                            li.attr("class", "liIconIMG");
                            break;
                        case ".TXT":
                            li.attr("class", "liIconTXT");
                            break;
                        case ".JS":
                            li.attr("class", "liIconJS");
                            break;
                        default: break;
                    }
                    var aref = $("<a class='aFile' NewFileName='" + item.NewFileName + "' FilePath='" + item.FilePath + "' FileSize='" + item.FileSize + "' href='#' target='blank' id='" + item.NewFileName + "'>" + item.NewFileName + "</a>");

                    aref.appendTo(li);
                    var aDeleteRef = $("<a class='cancelFile' id='cancel" + item.FileGuid + "'>删除</a>");
                    aDeleteRef.unbind().click(function () {
                        if (confirm("确定删除?")) {
                            $(this).parent().remove();
                        }
                    });
                    aDeleteRef.appendTo(li);
                    $("#ul" + settings.fileElementId).append(li);


                });






            });





        },
        //获取已上传文件列表
        getFiles: function (options) {

            var fileslist = [];

            var flag = true;

            $(this).each(function () {
                var $this = $(this);
                $.each($(".aFile", $("#ulfileupload" + $this.attr("id"))), function (index, item) {
                    $this = $(item);
                    if ($this.attr("FilePath") == "") {
                        alert("文件" + $this.attr("NewFileName") + "正在上传,请稍后");
                        flag = false;
                        return false;
                    }
                    fileslist.push({ NewFileName: $this.attr("NewFileName"), FilePath: $this.attr("FilePath"), FileSize: $this.attr("FileSize") });
                });
                return false;

            });
            if (flag == false) {
                return false;
            }

            return fileslist;


        }

    };

    $.fn.ourUpload = function () {

        var method = arguments[0];

        if (methods[method]) {

            method = methods[method];

            arguments = Array.prototype.slice.call(arguments, 1);

        } else if (typeof (method) == 'object' || !method) {

            method = methods.init;

        } else {

            $.error('Method ' + method + ' does not exist on jQuery.pluginName');

            return this;
        }

        return method.apply(this, arguments);

    }

})(jQuery);