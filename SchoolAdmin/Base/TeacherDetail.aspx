<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="TeacherDetail.aspx.cs" Inherits="Cloud_Server.Teacher.Detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../plugins/timeline/css/style.css" rel="stylesheet" />
    <script src="BizJS/TeacherDetail.js"></script>
 
    <style type="text/css">
        .auto-style1 {
            width: 180px;
            height: 174px;
        }
    </style>
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
        <li class="active"><a href="#ti_1" role="tab" data-toggle="tab"><i class="green icon-home bigger-110"></i>教师基本信息</a></li>
        <li><a href="#ti_2" role="tab" data-toggle="tab">教科研成果</a></li>
        <li><a href="#ti_3" role="tab" data-toggle="tab">培训信息</a></li>
        <li><a href="#ti_4" role="tab" data-toggle="tab">奖励信息</a></li>
        <li><a href="#ti_5" role="tab" data-toggle="tab">学历进修经历</a></li>
        <li><a href="#ti_6" role="tab" data-toggle="tab">企业实践经历</a></li>
        <li><a href="#ti_7" role="tab" data-toggle="tab">工作经历</a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
        <div class="tab-pane active" id="ti_1">
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-heading">个人基本信息</div>
                <table border="1" align="center" style="width: 100%">

                    <tr>
                        <td width="15%"><font class="c1">姓名：</font></td>
                        <td width="35%">
                            <input type="text" value="张老师" />
                        </td>
                        <td width="15%" rowspan="6">照片：</td>
                        <td width="35%" rowspan="6" style="text-align:center;">
                            <img alt="" class="auto-style1" src="../img/master.jpg" /></td>
                    </tr>

                    <tr>
                        <td width="160"><font class="c1">性别：</font></td>
                        <td width="200">
                            <input type="text" value="男" /></td>
                    </tr>

                    <tr>
                        <td><font class="c1">出生日期：</font></td>
                        <td>
                            <input class="Wdate" type="text" onclick="WdatePicker()" /></td>
                    </tr>

                    <tr>
                        <td><font class="c1">年龄：</font></td>
                        <td>
                            <input type="text" value="33" /></td>
                    </tr>
                    <tr>
                        <td><font class="c1">政治面貌：</font></td>
                        <td>
                            <input type="text" /></td>
                    </tr>
                    <tr>
                        <td style="height: 35px;"><font class="c1">联系人：</font></td>
                        <td>
                            <input type="text" /></td>
                    </tr>
                    <tr>
                        <td style="height: 35px;"><font class="c1">健康状况：</font></td>
                        <td>
                            <input type="text" /></td>
                        <td><font class="c1">身份证号：</font></td>
                        <td>
                            <input type="text" /></td>
                    </tr>
                    <tr>
                        <td>籍贯<font class="c1">：</font></td>
                        <td>
                            <input type="text"  value="汉族" /></td>
                        <td><font class="c1">邮政编码：</font></td>
                        <td>
                            <input type="text" /></td>
                    </tr>
                    <tr>
                        <td>民族<font class="c1">：</font></td>
                        <td>
                            <input type="text" /></td>
                        <td><font class="c1">电子邮件：</font></td>
                        <td>
                            <input type="text" /></td>
                    </tr>
                    <tr>
                        <td style="height: 35px;"><font class="c1">通讯地址：</font></td>
                        <td colspan="3">
                            <input type="text" style="width: 100%;" /></td>
                    </tr>
                    <tr>
                        <td style="height: 35px;"><font class="c1">家庭地址：</font></td>
                        <td colspan="3">
                            <input type="text" style="width: 100%;" /></td>
                    </tr>
                </table>
            </div>
            <div class="panel panel-default">
                <!-- Default panel contents -->
                <div class="panel-heading">职业教育信息</div>
                <table border="1" align="center" style="width: 100%">

                    <tr>
                        <td width="160"><font class="c1">所属学校：</font></td>
                        <td colspan="5">
                            <input type="text" style="width: 100%" value="上海交通学校" />
                        </td>

                    </tr>
                    <tr>
                        <td><font class="c1">教师岗位类型：</font></td>
                        <td>
                            <input type="text" /></td>
                        <td><font class="c1">教师性质：</font></td>
                        <td colspan="3">
                            <input type="text" style="width: 100%" /></td>
                    </tr>
                    <tr>
                        <td><font class="c1">学历：</font></td>
                        <td>
                            <input type="text" /></td>
                        <td><font class="c1">学位：</font></td>
                        <td colspan="3">
                            <input type="text" style="width: 100%" /></td>
                    </tr>
                    <tr>
                        <td><font class="c1">第一外语：</font></td>
                        <td>
                            <input type="text" /></td>
                        <td><font class="c1">掌握程度：</font></td>
                        <td colspan="3">
                            <input type="text" style="width: 100%" /></td>
                    </tr>
                    <tr>
                        <td style="height: 35px;"><font class="c1">第二外语：</font></td>
                        <td>
                            <input type="text" /></td>
                        <td><font class="c1">掌握程度：</font></td>
                        <td colspan="3">
                            <input type="text" style="width: 100%" /></td>
                    </tr>
                    <tr>
                        <td style="height: 35px;"><font class="c1">主要任教专业：</font></td>
                        <td>
                            <input type="text" /></td>
                        <td><font class="c1">任教学科：</font></td>
                        <td colspan="3">
                            <input type="text" style="width: 100%" /></td>
                    </tr>
                    <tr>
                        <td style="height: 35px;"><font class="c1">职业资格证书：</font></td>
                        <td>
                            <input type="text" style="width: 100%;" /></td>
                        <td style="height: 35px;"><font class="c1">职业技能等级：</font></td>
                        <td>
                            <input type="text" /></td>
                        <td style="height: 35px;"><font class="c1">获得日期：</font></td>
                        <td>
                            <input class="Wdate" type="text" onclick="WdatePicker()" /></td>
                    </tr>
                    <tr>
                        <td style="height: 35px;"><font class="c1">专业技术职称：</font></td>
                        <td>
                            <input type="text" style="width: 100%" /></td>
                        <td><font class="c1">获得日期：</font></td>
                        <td colspan="3" style="text-align: left;">
                            <input class="Wdate" type="text" onclick="WdatePicker()" /></td>

                    </tr>
                    <tr>
                        <td style="height: 35px;"><font class="c1">职教工作年限：</font></td>
                        <td>
                            <input type="text" style="width: 100%;" /></td>
                        <td style="height: 35px;"><font class="c1">班主任工作年限：</font></td>
                        <td colspan="3" style="text-align: left;">
                            <input type="text" /></td>
                    </tr>
                    <tr>
                        <td style="height: 35px;"><font class="c1">行业/执业资格证书：</font></td>
                        <td>
                            <input type="text" style="width: 100%;" /></td>
                        <td style="height: 35px;"><font class="c1">证书等级：</font></td>
                        <td>
                            <input type="text" /></td>
                        <td style="height: 35px;"><font class="c1">获得日期：</font></td>
                        <td>
                            <input class="Wdate" type="text" onclick="WdatePicker()" /></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="tab-pane" id="ti_2">
             <ul class="event_year">
                <li class="current">
                    <label for="keyan_2013">2013</label></li>
                <li>
                    <label for="keyan_2012">2012</label></li>

            </ul>

            <ul class="event_list">
                <div>
                    <h3 id="keyan_2013">2013</h3>
                    <li>
                        <span>9月</span>
                        <p><span>发表《汽车发动机拆装手册》</span></p>
                    </li>

                </div>

                <div>
                    <h3 id="keyan_2012">2012</h3>
                    <li>
                        <span>9月</span>
                        <p><span>参与编制新版汽车教学教材</span></p>
                    </li>
                   <li>
                        <span>12月</span>
                        <p><span>发表《关于汽车专业建设的总结》</span></p>
                    </li>
                </div>

            </ul>

            <div class="clearfix"></div>
        </div>
        <div class="tab-pane" id="ti_3">
           <ul class="event_year">
                <li class="current">
                    <label for="peixun_2013">2013</label></li>
                <li>
                    <label for="peixun_2012">2012</label></li>

            </ul>

            <ul class="event_list">
                <div>
                    <h3 id="peixun_2013">2013</h3>
                    <li>
                        <span>9月</span>
                        <p><span>全国电子化信息培训班</span></p>
                    </li>

                </div>

                <div>
                    <h3 id="peixun_2012">2012</h3>
                    <li>
                        <span>9月</span>
                        <p><span>全国汽车专业技能培训第二期</span></p>
                    </li>
                </div>

            </ul>

            <div class="clearfix"></div>
        </div>
        <div class="tab-pane" id="ti_4">
            <ul class="event_year">
                <li class="current">
                    <label for="jiangli_2013">2013</label></li>
                <li>
                    <label for="jiangli_2012">2012</label></li>

            </ul>

            <ul class="event_list">
                <div>
                    <h3 id="jiangli_2013">2013</h3>
                    <li>
                        <span>9月</span>
                        <p><span>上海市劳动模范</span></p>
                    </li>

                </div>

                <div>
                    <h3 id="jiangli_2012">2012</h3>
                    <li>
                        <span>9月</span>
                        <p><span>上海市优秀讲师</span></p>
                    </li>
                </div>

            </ul>

            <div class="clearfix"></div>
        </div>
        <div class="tab-pane" id="ti_5">
            <ul class="event_year">
                <li class="current">
                    <label for="xueli_2013">2013</label></li>
                <li>
                    <label for="xueli_2012">2012</label></li>

            </ul>

            <ul class="event_list">
                <div>
                    <h3 id="xueli_2013">2013</h3>
                    <li>
                        <span>9月</span>
                        <p><span>上海大学汽车系</span></p>
                    </li>

                </div>

                <div>
                    <h3 id="xueli_2012">2012</h3>
                    <li>
                        <span>9月</span>
                        <p><span>美国斯坦福大学游学</span></p>
                    </li>
                </div>

            </ul>

            <div class="clearfix"></div>
        </div>
        <div class="tab-pane" id="ti_6">
            <ul class="event_year">
                <li class="current">
                    <label for="shijian_2013">2013</label></li>
                <li>
                    <label for="shijian_2012">2012</label></li>

            </ul>

            <ul class="event_list">
                <div>
                    <h3 id="shijian_2013">2013</h3>
                    <li>
                        <span>5月</span>
                        <p><span>上海通用汽车</span></p>
                    </li>

                </div>

                <div>
                    <h3 id="shijian_2012">2012</h3>
                    <li>
                        <span>9月</span>
                        <p><span>上海大众汽车</span></p>
                    </li>
                </div>

            </ul>

            <div class="clearfix"></div>
        </div>
        <div class="tab-pane" id="ti_7">
            <ul class="event_year">
                <li class="current">
                    <label for="wk_2013">2013</label></li>
                <li>
                    <label for="wk_2005">2005</label></li>
                 <li>
                    <label for="wk_2000">2000</label></li>
            </ul>

            <ul class="event_list">
                <div>
                    <h3 id="wk_2013">2013</h3>
                 
                     <li>
                        <span>2月</span>
                        <p><span>担任汽车实训中心的管理工作</span></p>
                    </li>
                </div>

                <div>
                    <h3 id="wk_2005">2005</h3>
                    <li>
                        <span>5月</span>
                        <p><span>负责实训的教学工作</span></p>
                    </li>
                     <li>
                        <span>9月</span>
                        <p><span>担任班主任的管理工作</span></p>
                    </li>
                </div>

                <div>
                    <h3 id="wk_2000">2000</h3>
                    <li>
                        <span>9月</span>
                        <p><span>进入上海交通学校，负责理论教学工作。</span></p>
                    </li>
                </div>

            </ul>

            <div class="clearfix"></div>
        </div>
    </div>
    <br />
     
        <div class="row-fluid wizard-actions">
		    <a  id="btnCancel" class="btn btn-prev" href="TeacherList.aspx">
			    <i  class="icon-remove"></i>
			    取消
		    </a>

<a id="btnOK" class="btn   btn-primary" href="TeacherList.aspx">
	<i class="icon-ok"></i>
	确定
</a>
	    </div>


    <script src="../plugins/My97DatePicker/WdatePicker.js"></script>
    <script src="../plugins/timeline/js/jquery.min_v1.0.js"></script>
    <script type="text/javascript">
        $(function () {
            $('label').click(function () {
                $('.event_year>li').removeClass('current');
                $(this).parent('li').addClass('current');
                var year = $(this).attr('for');
                $('#' + year).parent().prevAll('div').slideUp(800);
                $('#' + year).parent().slideDown(800).nextAll('div').slideDown(800);
            });
        });
    </script>
</asp:Content>
