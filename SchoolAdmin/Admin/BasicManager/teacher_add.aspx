<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Main.Master" AutoEventWireup="true" CodeFile="teacher_add.aspx.cs" Inherits="Admin_BasicManager_teacher_add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!--jquery datatable-->
    <script src="/plugins/jquery.DataTables/DataTables-master/media/js/jquery.dataTables.js"></script>
    <script src="/plugins/ace/assets/js/jquery.dataTables.bootstrap.js"></script>
    <!--感应下拉-->
    <link href="/plugins/ace/assets/css/chosen.css" rel="stylesheet" />
    <script src="/plugins/ace/assets/js/chosen.jquery.min.js"></script>

    <!--上传插件-->
    <script src="../OurUpload/ajaxfileupload.js"></script>
    <script src="../OurUpload/jquery.OurUpload.js"></script>
    <link href="../OurUpload/Style/OurUpload.css" rel="stylesheet" />
    <!--时间js-->
    <script src="/plugins/My97DatePicker/WdatePicker.js"></script>
    <link href="/plugins/My97DatePicker/skin/default/datepicker.css" rel="stylesheet" />

    <link href="/plugins/My97DatePicker/skin/ourWdatePicker.css" rel="stylesheet" />
    <!--时间轴的样式-->
    <link href="/plugins/timeline/css/style.css" rel="stylesheet" />

    <!--本页js-->
    <script src="BizJS/teacher_add.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div ng-app="app" ng-controller="page">
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" role="tablist" style="height: 32px;">
            <li class="active"><a href="#ti_1" role="tab" data-toggle="tab"><i class="green icon-home bigger-110"></i>教师基本信息</a></li>
            <li ng-show="entity.ID != null"><a href="#ti_2" role="tab" data-toggle="tab">教科研成果</a></li>
            <li ng-show="entity.ID != null"><a href="#ti_3" role="tab" data-toggle="tab">培训信息</a></li>
            <li ng-show="entity.ID != null"><a href="#ti_4" role="tab" data-toggle="tab">奖励信息</a></li>
            <li ng-show="entity.ID != null"><a href="#ti_5" role="tab" data-toggle="tab">学历进修经历</a></li>
            <li ng-show="entity.ID != null"><a href="#ti_6" role="tab" data-toggle="tab">企业实践经历</a></li>
            <li ng-show="entity.ID != null"><a href="#ti_7" role="tab" data-toggle="tab">工作经历</a></li>
        </ul>
        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane active" id="ti_1">
                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <div class="panel-heading">个人基本信息</div>
                    <input type="hidden" ng-model="entity.ID" />
                    <table border="1" align="center" style="width: 100%">

                        <tr>
                            <td width="15%"><font color="red">*</font><font class="c1">姓名：</font></td>
                            <td width="35%">
                                <input type="text" ng-model="entity.Name" style="width: 75px;" />
                                <font color="red">*</font><font class="c1">手机号：</font>
                                <input type="text" ng-model="entity.MobileNumber" style="width: 100px;" />
                            </td>
                            <td width="15%" rowspan="6">照片：</td>
                            <td width="35%" rowspan="6" style="text-align: center;">
                                <div class="col-sm-10">
                                    <div style="width: 150px; height: 150px; text-align: center;">

                                        <img onerror="javascript:this.src='/images/NoImage.jpg';" src="/images/NoImage.jpg';" style="width: 150px; height: 150px;" id="image" ng-src="{{entity.PhotoUrl}}" ng-model="entity.PhotoUrl" />

                                        <span style="text-align: center; position: absolute; width: 150px; height: 24px; line-height: 24px; bottom: 0; left: 10px; background-color: #000; opacity: 0.6; color: #fff;" id="btnSelectFile">编辑</span>

                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td width="160"><font color="red">*</font><font class="c1">职工号：</font></td>
                            <td width="200">
                                <input type="text" ng-model="entity.EmployeeID" /><font color="red">可以作为手机端登录名</font>
                            </td>

                        </tr>
                        <tr>
                            <td width="160"><font color="red">*</font><font class="c1">性别：</font></td>
                            <td width="200">
                                <select ng-model="entity.Sex" class="chosen-select">
                                    <option value="">请选择</option>
                                    <option value="1">男</option>
                                    <option value="0">女</option>
                                </select>
                            </td>

                        </tr>

                        <tr>
                            <td><font color="red">*</font><font class="c1">出生日期：</font></td>
                            <td>
                                <input id="timer_Birthday" ng-model="entity.Birthday" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="Wdate" type="text" readonly="readonly" /></td>
                        </tr>

                        <tr>
                            <td><font color="red">*</font><font class="c1">年龄：</font></td>
                            <td>
                                <input type="text" ng-model="entity.Age" /></td>
                        </tr>
                        <tr>
                            <td><font color="red">*</font><font class="c1">政治面貌：</font></td>
                            <td>
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in politicalList" ng-model="entity.Political" id="optPolitical" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 35px;"><font class="c1">联系电话：</font></td>
                            <td>
                                <input type="text" ng-model="entity.Telephone" /></td>
                        </tr>
                        <tr>
                            <td style="height: 35px;"><font color="red">*</font><font class="c1">健康状况：</font></td>
                            <td>
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in healthyList" ng-model="entity.Healthy" id="optHealthyList" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                            <td><font color="red">*</font><font class="c1">身份证号：</font></td>
                            <td>
                                <input type="text" ng-model="entity.IDCard" /></td>
                        </tr>
                        <tr>
                            <td><font color="red">*</font>籍贯<font class="c1">：</font></td>
                            <td>
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in nativePlaceList" ng-model="entity.NativePlace" id="optNativePlaceList" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                            <td><font color="red">*</font><font class="c1">邮政编码：</font></td>
                            <td>
                                <input type="text" ng-model="entity.ZipCode" /></td>
                        </tr>
                        <tr>
                            <td><font color="red">*</font>民族<font class="c1">：</font></td>
                            <td>
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in ethnicList" ng-model="entity.Ethnic" id="optEthnicList" class="chosen-select">
                                    <option value="">请选择</option>
                                </select></td>
                            <td><font color="red">*</font><font class="c1">电子邮件：</font></td>
                            <td>
                                <input type="text" ng-model="entity.Email" /></td>
                        </tr>
                        <tr>
                            <td style="height: 35px;"><font color="red">*</font><font class="c1">通讯地址：</font></td>
                            <td colspan="3">
                                <input type="text" style="width: 100%;" ng-model="entity.PostalAddress" /></td>
                        </tr>
                        <tr>
                            <td style="height: 35px;"><font class="c1">家庭地址：</font></td>
                            <td colspan="3">
                                <input type="text" style="width: 100%;" ng-model="entity.HomeAddress" /></td>
                        </tr>
                    </table>
                </div>
                <div class="panel panel-default">
                    <!-- Default panel contents -->
                    <div class="panel-heading">职业教育信息</div>
                    <table border="1" align="center" style="width: 100%">

                        <%-- <tr>
                            <td><font class="c1"><span style="color:red;">*</span>所属实训中心：</font></td>
                            <td colspan="1">
                                <select ng-options="currOption.ID as currOption.Name for currOption in centerList" ng-model="entity.CenterID" id="optCenterList">
                                    <option value="">请选择</option>
                                </select>

                            </td>
                            <td width="160"><span style="color: red;"></span><font class="c1">所属实训室：</font></td>
                            <td colspan="3">
                                <div id="divTrainingRoomNames"></div>
                                <a id="btnSelectTrainingRoom" class="btn   btn-success" ng-click="selectTrainingRoom()">选择实训室
                                </a>
                            </td>
                        </tr>--%>
                        <tr>
                            <td><span style="color: red;">*</span><font class="c1">教师岗位类型：</font></td>
                            <td>

                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in jobTypeList" ng-model="entity.JobType" id="optJobTypeList" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                                &nbsp;<span style="color: red;">*</span><font class="c1">授课类型：</font>
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in sklxList" ng-model="entity.TeachingType" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                            <td><span style="color: red;">*</span><font class="c1">教师性质：</font></td>
                            <td colspan="3">
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in teacherPropertyList" ng-model="entity.TeacherProperty" id="optTeacherPropertyList" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><span style="color: red;">*</span><font class="c1">学历：</font></td>
                            <td>
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in educationList" ng-model="entity.Education" id="optEducationList" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                            <td><font class="c1">学位：</font></td>
                            <td colspan="3">
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in degreeList" ng-model="entity.Degree" id="optDegreeList" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td><font class="c1">第一外语：</font></td>
                            <td>

                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in languageList" ng-model="entity.FirstLanguage" id="optLanguageList" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                            <td><font class="c1">掌握程度：</font></td>
                            <td colspan="3">

                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in levelAttainedList" ng-model="entity.FirstExtent" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 35px;"><font class="c1">第二外语：</font></td>
                            <td>
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in languageList" ng-model="entity.SecondLanguage" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                            <td><font class="c1">掌握程度：</font></td>
                            <td colspan="3">
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in levelAttainedList" ng-model="entity.SecondExtent" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 35px;"><font class="c1"><span style="color:red;">*</span>主要任教专业：</font></td>
                            <td>

                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in teachSpecialtyList" ng-model="entity.TeachSpecialty" id="optTeachSpecialtyList" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                            <td><font class="c1"><span style="color:red;">*</span>任教学科：</font></td>
                            <td colspan="3">

                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in disciplineList" ng-model="entity.Discipline" id="optDisciplineList" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6"><span style="color: red;">*</span>职业资格证书：<input type="text" ng-model="entity.Certificate1" />
                                职业技能等级:
                          
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in zyjnLevelList" ng-model="entity.Level1" id="optLevelList" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                                获得日期:<input class="Wdate" id="timer_GetDate1" type="text" onclick="WdatePicker()" ng-model="entity.GetDate1" readonly="readonly" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">职业资格证书：<input type="text" ng-model="entity.Certificate2" />
                                职业技能等级:
                        
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in zyjnLevelList" ng-model="entity.Level2" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                                获得日期:<input class="Wdate" id="timer_GetDate2" type="text" onclick="WdatePicker()" ng-model="entity.GetDate2" readonly="readonly" />

                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">职业资格证书：<input type="text" ng-model="entity.Certificate3" />
                                职业技能等级:
                          
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in zyjnLevelList" ng-model="entity.Level3" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                                获得日期:<input class="Wdate" id="timer_GetDate3" type="text" onclick="WdatePicker()" ng-model="entity.GetDate3" readonly="readonly" />
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                        </tr>
                        <tr>
                            <td><font class="c1"><span style="color:red;">*</span>专业技术职称：</font></td>
                            <td>
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in technicalTitleList" ng-model="entity.TechnicalTitle" id="optTechnicalTitleList" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                            </td>
                            <td><font class="c1">获得日期：</font></td>
                            <td colspan="3">
                                <input class="Wdate" id="timer_TechnicalGetDate" type="text" onclick="WdatePicker()" ng-model="entity.TechnicalGetDate" readonly="readonly" /></td>
                        </tr>
                        <tr>
                            <td style="height: 35px;"><font class="c1">职教工作年限：</font></td>
                            <td>
                                <input type="text" style="width: 35%;" ng-model="entity.WorkYears" />年</td>
                            <td style="height: 35px;"><font class="c1">班主任工作年限：</font></td>
                            <td colspan="3" style="text-align: left;">
                                <input type="text" style="width: 25%;" ng-model="entity.ManagerYears" />年</td>
                        </tr>
                        <tr>
                            <td colspan="6"><font class="c1">行业/执业资格证书：</font>
                                <input type="text" ng-model="entity.Certificate4" />
                                证书等级：
                         
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in levelList" ng-model="entity.Level4" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>

                                获得日期：<input class="Wdate" id="timer_GetDate4" type="text" onclick="WdatePicker()" ng-model="entity.GetDate4" readonly="readonly" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6"><font class="c1">行业/执业资格证书：</font>
                                <input type="text" ng-model="entity.Certificate5" />
                                证书等级：
                         
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in levelList" ng-model="entity.Level5" class="chosen-select">
                                    <option value="">请选择</option>
                                </select>
                                获得日期：<input class="Wdate" id="timer_GetDate5" type="text" onclick="WdatePicker()" ng-model="entity.GetDate5" readonly="readonly" />
                            </td>
                        </tr>
                        <tr>
                            <td><font class="c1"><span style="color:red;">*</span>职务：</font></td>
                            <td>
                                <input type="text" ng-model="entity.Position" />
                            </td>
                            <td><font class="c1">是否担任班主任：</font></td>
                            <td colspan="3">是<input type="radio" name="ys1" ng-model="entity.IsManager" value="1" />否<input type="radio" name="ys1" ng-model="entity.IsManager" value="0" />

                            </td>
                        </tr>
                        <tr>
                            <td>专长：</td>
                            <td colspan="4">
                                <textarea class="col-lg-1" style="width: 250px; height: 100px;" ng-model="entity.Forte"></textarea></td>
                        </tr>
                    </table>


                </div>
                <div class="row-fluid wizard-actions">
                    <a id="btnOK" class="btn   btn-primary" ng-click="submit()">
                        <i class="icon-ok"></i>
                        确定
                    </a>
                    <a id="btnCancel" class="btn btn-prev" ng-click="cancel();">
                        <i class="icon-remove"></i>
                        取消
                    </a>


                </div>
            </div>
            <div class="tab-pane timebk" id="ti_2">
                <div ng-show="entity.FruitList.length==0" class="noevent">暂无数据</div>
                <ul class="event_year">
                    <li ng-class="{'current':$index==0}" ng-repeat="entity in entity.FruitList">
                        <label class="year" for="fruit_{{entity.Year}}">{{entity.Year}}</label></li>

                </ul>

                <ul class="event_list">
                    <div ng-repeat="entity in entity.FruitList">
                        <h3 id="fruit_{{entity.Year}}">{{entity.Year}}</h3>
                        <li ng-repeat="data in entity.Data">
                            <span>{{data.Month}}</span>
                            <p>
                                <span class="eventName">{{data.Name}}
                                    &nbsp;&nbsp;&nbsp;<a class="eventOperationDel" dataid="{{data.ID}}" datatype="fruit">删除</a>&nbsp;&nbsp;&nbsp;<a class="eventOperationUpdate" dataid="{{data.ID}}" datatype="fruit">编辑</a>
                                </span>
                            </p>

                        </li>
                    </div>

                </ul>
                <div class="clearfix"><a class="btn btn-primary btn-xs" ng-click="addOtherInfo('fruit')">添 加</a></div>

            </div>
            <div class="tab-pane timebk" id="ti_3">
                <div ng-show="entity.TrainingList.length==0" class="noevent">暂无数据</div>
                <ul class="event_year">
                    <li ng-class="{'current':$index==0}" ng-repeat="entity in entity.TrainingList">
                        <label class="year" for="training_{{entity.Year}}">{{entity.Year}}</label></li>

                </ul>

                <ul class="event_list">
                    <div ng-repeat="entity in entity.TrainingList">
                        <h3 id="training_{{entity.Year}}">{{entity.Year}}</h3>
                        <li ng-repeat="data in entity.Data">
                            <span>{{data.Month}}</span>
                            <p>
                                <span class="eventName">{{data.Name}}
                                    &nbsp;&nbsp;&nbsp;<a class="eventOperationDel" dataid="{{data.ID}}" datatype="training">删除</a>&nbsp;&nbsp;&nbsp;<a class="eventOperationUpdate" dataid="{{data.ID}}" datatype="training">编辑</a>
                                </span>
                            </p>

                        </li>
                    </div>

                </ul>

                <div class="clearfix"><a class="btn btn-primary btn-xs" ng-click="addOtherInfo('training')">添 加</a></div>
            </div>
            <div class="tab-pane timebk" id="ti_4">
                <div ng-show="entity.RewardList.length==0" class="noevent">暂无数据</div>
                <ul class="event_year">
                    <li ng-class="{'current':$index==0}" ng-repeat="entity in entity.RewardList">
                        <label class="year" for="reward_{{entity.Year}}">{{entity.Year}}</label></li>

                </ul>

                <ul class="event_list">
                    <div ng-repeat="entity in entity.RewardList">
                        <h3 id="reward_{{entity.Year}}">{{entity.Year}}</h3>
                        <li ng-repeat="data in entity.Data">
                            <span>{{data.Month}}</span>
                            <p>
                                <span class="eventName">{{data.Name}}
                                    &nbsp;&nbsp;&nbsp;<a class="eventOperationDel" dataid="{{data.ID}}" datatype="reward">删除</a>&nbsp;&nbsp;&nbsp;<a class="eventOperationUpdate" dataid="{{data.ID}}" datatype="reward">编辑</a>
                                </span>
                            </p>

                        </li>
                    </div>

                </ul>

                <div class="clearfix"><a class="btn btn-primary btn-xs" ng-click="addOtherInfo('reward')">添 加</a></div>
            </div>
            <div class="tab-pane timebk" id="ti_5">
                <div ng-show="entity.EducationList.length==0" class="noevent">暂无数据</div>
                <ul class="event_year">
                    <li ng-class="{'current':$index==0}" ng-repeat="entity in entity.EducationList">
                        <label class="year" for="education_{{entity.Year}}">{{entity.Year}}</label></li>

                </ul>

                <ul class="event_list">
                    <div ng-repeat="entity in entity.EducationList">
                        <h3 id="education_{{entity.Year}}">{{entity.Year}}</h3>
                        <li ng-repeat="data in entity.Data">
                            <span>{{data.Month}}</span>
                            <p>
                                <span class="eventName">{{data.SchoolName}}
                                    &nbsp;&nbsp;&nbsp;<a class="eventOperationDel" dataid="{{data.ID}}" datatype="education">删除</a>&nbsp;&nbsp;&nbsp;<a class="eventOperationUpdate" dataid="{{data.ID}}" datatype="education">编辑</a>
                                </span>
                            </p>

                        </li>
                    </div>

                </ul>

                <div class="clearfix"><a class="btn btn-primary btn-xs" ng-click="addOtherInfo('education')">添 加</a></div>
            </div>
            <div class="tab-pane timebk" id="ti_6">
                <div ng-show="entity.PracticeList.length==0" class="noevent">暂无数据</div>
                <ul class="event_year">
                    <li ng-class="{'current':$index==0}" ng-repeat="entity in entity.PracticeList">
                        <label class="year" for="practice_{{entity.Year}}">{{entity.Year}}</label></li>

                </ul>

                <ul class="event_list">
                    <div ng-repeat="entity in entity.PracticeList">
                        <h3 id="practice_{{entity.Year}}">{{entity.Year}}</h3>
                        <li ng-repeat="data in entity.Data">
                            <span>{{data.Month}}</span>
                            <p>
                                <span class="eventName">{{data.CompanyName}}
                                    &nbsp;&nbsp;&nbsp;<a class="eventOperationDel" dataid="{{data.ID}}" datatype="practice">删除</a>&nbsp;&nbsp;&nbsp;<a class="eventOperationUpdate" dataid="{{data.ID}}" datatype="practice">编辑</a>
                                </span>
                            </p>

                        </li>
                    </div>

                </ul>

                <div class="clearfix"><a class="btn btn-primary btn-xs" ng-click="addOtherInfo('practice')">添 加</a></div>
            </div>
            <div class="tab-pane timebk" id="ti_7">
                <div ng-show="entity.ExperienceList.length==0" class="noevent">暂无数据</div>

                <ul class="event_year">
                    <li ng-class="{'current':$index==0}" ng-repeat="entity in entity.ExperienceList">
                        <label class="year" for="experience_{{entity.Year}}">{{entity.Year}}</label></li>

                </ul>

                <ul class="event_list">
                    <div ng-repeat="entity in entity.ExperienceList">
                        <h3 id="experience_{{entity.Year}}">{{entity.Year}}</h3>
                        <li ng-repeat="data in entity.Data">
                            <span>{{data.Month}}</span>
                            <p>
                                <span class="eventName">{{data.CompanyName}}
                                    &nbsp;&nbsp;&nbsp;<a class="eventOperationDel" dataid="{{data.ID}}" datatype="experience">删除</a>&nbsp;&nbsp;&nbsp;<a class="eventOperationUpdate" dataid="{{data.ID}}" datatype="experience">编辑</a>
                                </span>
                            </p>

                        </li>
                    </div>

                </ul>

                <div class="clearfix">
                    <a class="btn btn-primary btn-xs" ng-click="addOtherInfo('experience')">添 加
                    </a>
                </div>
            </div>
        </div>

        <!--选择实训室-->
        <div class="modal fade" id="divDialog" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false" data-backdrop="static">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">实训室</h4>
                    </div>
                    <div class="modal-body">
                        实训中心<select ng-options="currOption.ID as currOption.Name for currOption in centerList" ng-model="entity.CenterID" id="optSelectCenter" ng-change="selectCenter(entity.CenterID)">
                            <option value="">请选择</option>
                        </select>

                        <table id="tableList" class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th class="center">
                                        <label>
                                            <input type="checkbox" class="ace" />
                                            <span class="lbl"></span>
                                        </label>
                                    </th>
                                    <th>名称</th>
                                    <th style="width: 300px;">设置默认</th>
                                </tr>
                            </thead>

                        </table>


                    </div>
                    <div class="modal-footer">

                        <button type="button" ng-disabled="myform.$invalid" class="btn btn-success" ng-click="selectRoomOK();">确定</button>
                    </div>
                </div>
            </div>
        </div>

        <%--教科研成果窗口--%>
        <div id="frmJKY" class="modal">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 700px; height: 500px;">
                    <div class="modal-header" data-target="#modal-step-contents">
                        <div class="page-header" style="border: none; padding-bottom: 1px;">
                            <h1>新增教科研成果 
                            </h1>
                        </div>
                    </div>
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <input type="hidden" ng-model="entityFruit.ID" />
                            <input type="hidden" ng-model="entityFruit.TeacherID" />
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>教研成果：</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" placeholder="输入教研成果名称" style="width: 400px;" ng-model="entityFruit.Name" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>级别：</label>
                            <div class="col-sm-9">
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in kyjbList" ng-model="entityFruit.FruitLevel">
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">角色：</label>
                            <div class="col-sm-9">
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in hjjsList" ng-model="entityFruit.Role">
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>时间：</label>
                            <div class="col-sm-9">
                                <input class="Wdate" id="timer_FruitGetDate" type="text" onclick="WdatePicker()" ng-model="entityFruit.GetDate" readonly="readonly" style="height: 35px;" />
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-3 control-label">备注：</label>
                            <div class="col-sm-9">
                                <textarea style="width: 400px; height: 100px;" ng-model="entityFruit.Remark"></textarea>
                            </div>
                        </div>



                        <div class="modal-footer wizard-actions">
                            <a class="btn btn-sm" data-dismiss="modal">
                                <i class="icon-remove"></i>
                                取 消
                            </a>

                            <a class="btn btn-sm btn-primary" ng-click="sumitOtherInfoDetail('fruit');">
                                <i class="icon-ok"></i>
                                确 定
                            </a>
                        </div>
                    </form>
                </div>
            </div>


        </div>

        <%--培训信息窗口--%>
        <div id="frmPXXX" class="modal">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 700px; height: 500px;">
                    <div class="modal-header" data-target="#modal-step-contents">
                        <div class="page-header" style="border: none; padding-bottom: 1px;">
                            <h1>新增培训信息 
                            </h1>
                        </div>
                    </div>

                    <form class="form-horizontal" role="form">

                        <input type="hidden" ng-model="entityTraining.ID" />
                        <input type="hidden" ng-model="entityTraining.TeacherID" />
                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>培训项目：</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" placeholder="输入培训项目名称" style="width: 400px;" ng-model="entityTraining.Name" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>培训机构：</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" placeholder="输入培训机构名称" style="width: 400px;" ng-model="entityTraining.Organization" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>培训性质：</label>
                            <div class="col-sm-9">
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in pxxzList" ng-model="entityTraining.TrainingType">
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>



                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>培训时间：</label>
                            <div class="col-sm-9">
                                <input class="Wdate" id="timer_TrainingBeginDate" type="text" onclick="WdatePicker()" ng-model="entityTraining.BeginDate" readonly="readonly" style="height: 35px;" />
                                &nbsp;&nbsp;至&nbsp;&nbsp; 
                                <input class="Wdate" id="timer_TrainingEndDate" type="text" onclick="WdatePicker()" ng-model="entityTraining.EndDate" readonly="readonly" style="height: 35px;" />
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-3 control-label">备注：</label>
                            <div class="col-sm-9">
                                <textarea style="width: 400px; height: 100px;" ng-model="entityTraining.Remark"></textarea>
                            </div>
                        </div>

                    </form>


                    <div class="modal-footer wizard-actions">
                        <a class="btn btn-sm" data-dismiss="modal">
                            <i class="icon-remove"></i>
                            取 消
                        </a>

                        <a class="btn btn-sm btn-primary" ng-click="sumitOtherInfoDetail('training');">
                            <i class="icon-ok"></i>
                            确 定
                        </a>
                    </div>
                </div>
            </div>


        </div>

        <%--奖励信息窗口--%>
        <div id="frmJLXX" class="modal">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 700px; height: 600px;">
                    <div class="modal-header" data-target="#modal-step-contents">
                        <div class="page-header" style="border: none; padding-bottom: 1px;">
                            <h1>新增奖励信息
                <small><i class="icon-double-angle-right"></i>&nbsp;添加新的奖励信息
                </small>
                            </h1>
                        </div>
                    </div>

                    <form class="form-horizontal" role="form">

                        <input type="hidden" ng-model="entityReward.ID" />
                        <input type="hidden" ng-model="entityReward.TeacherID" />
                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>获奖项目：</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" placeholder="输入获奖项目名称" style="width: 400px;" ng-model="entityReward.Name" />
                            </div>
                        </div>



                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>奖励级别：</label>
                            <div class="col-sm-9">

                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in jljbList" ng-model="entityReward.RewardLevel">
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-3 control-label">获奖类别：</label>
                            <div class="col-sm-9">
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in hjlbList" ng-model="entityReward.RewardType">
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">获奖角色：</label>
                            <div class="col-sm-9">
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in hjjsList" ng-model="entityReward.Role">
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>奖励名称：</label>
                            <div class="col-sm-9">
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in jlmcList" ng-model="entityReward.RewardName">
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-3 control-label">颁奖单位：</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" placeholder="如果需要填写多个单位，请用分隔号（；）隔开" style="width: 400px;" ng-model="entityReward.Company" />
                            </div>

                        </div>


                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>颁奖日期：</label>
                            <div class="col-sm-9">
                                <input class="Wdate" id="timer_RewardGetDate" type="text" onclick="WdatePicker()" ng-model="entityReward.GetDate" readonly="readonly" style="height: 35px;" />
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-3 control-label">备注：</label>
                            <div class="col-sm-9">
                                <textarea style="width: 400px; height: 100px;" ng-model="entityReward.Remark"></textarea>
                            </div>
                        </div>

                    </form>


                    <div class="modal-footer wizard-actions">
                        <a class="btn btn-sm" data-dismiss="modal">
                            <i class="icon-remove"></i>
                            取 消
                        </a>

                        <a class="btn btn-sm btn-primary" ng-click="sumitOtherInfoDetail('reward');">
                            <i class="icon-ok"></i>
                            确 定
                        </a>
                    </div>
                </div>
            </div>


        </div>

        <%--学历进修信息窗口--%>
        <div id="frmXLJX" class="modal">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 700px; height: 500px;">
                    <div class="modal-header" data-target="#modal-step-contents">
                        <div class="page-header" style="border: none; padding-bottom: 1px;">
                            <h1>新增学历信息 
                            </h1>
                        </div>
                    </div>

                    <form class="form-horizontal" role="form">

                        <input type="hidden" ng-model="entityEducation.ID" />
                        <input type="hidden" ng-model="entityEducation.TeacherID" />
                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>学历：</label>
                            <div class="col-sm-9">
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in educationList" ng-model="entityEducation.Name">
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>



                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>时间：</label>
                            <div class="col-sm-9">
                                <input class="Wdate" id="timer_EducationBeginDate" type="text" onclick="WdatePicker()" ng-model="entityEducation.BeginDate" readonly="readonly" style="height: 35px; width: 100px;" />
                                &nbsp;&nbsp;至&nbsp;&nbsp;
                                <input class="Wdate" id="timer_EducationEndDate" type="text" onclick="WdatePicker()" ng-model="entityEducation.EndDate" readonly="readonly" style="height: 35px; width: 100px;" />（结束时间不填表示至今） 
                            </div>
                        </div>



                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>进修学校：</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" placeholder="输入进修学校名称" style="width: 400px;" ng-model="entityEducation.SchoolName" />
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>所修专业：</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" placeholder="输入所修专业" style="width: 400px;" ng-model="entityEducation.SpecialtyName" />
                            </div>
                        </div>




                        <div class="form-group">
                            <label class="col-sm-3 control-label">备注：</label>
                            <div class="col-sm-9">
                                <textarea style="width: 400px; height: 100px;" ng-model="entityEducation.Remark"></textarea>
                            </div>
                        </div>

                    </form>


                    <div class="modal-footer wizard-actions">
                        <a class="btn btn-sm" data-dismiss="modal">
                            <i class="icon-remove"></i>
                            取 消
                        </a>

                        <a class="btn btn-sm btn-primary" ng-click="sumitOtherInfoDetail('education');">
                            <i class="icon-ok"></i>
                            确 定
                        </a>
                    </div>
                </div>
            </div>


        </div>

        <%--企业实践经历窗口--%>
        <div id="frmQYSJ" class="modal">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 700px; height: 600px;">
                    <div class="modal-header" data-target="#modal-step-contents">
                        <div class="page-header" style="border: none; padding-bottom: 1px;">
                            <h1>新增企业实践信息 
                            </h1>
                        </div>
                    </div>

                    <form class="form-horizontal" role="form">
                        <input type="hidden" ng-model="entityPractice.ID" />
                        <input type="hidden" ng-model="entityPractice.TeacherID" />
                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>企业名称：</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" placeholder="输入企业名称" style="width: 400px;" ng-model="entityPractice.CompanyName" />
                            </div>
                        </div>



                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>时间：</label>
                            <div class="col-sm-9">
                                <input class="Wdate" id="timer_PracticeBeginDate" type="text" onclick="WdatePicker()" ng-model="entityPractice.BeginDate" readonly="readonly" style="height: 35px;" />
                                &nbsp;&nbsp;至&nbsp;&nbsp;
                                <input class="Wdate" id="timer_PracticeEndDate" type="text" onclick="WdatePicker()" ng-model="entityPractice.EndDate" readonly="readonly" style="height: 35px;" />
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-3 control-label">工作日天数：</label>
                            <div class="col-sm-9">
                                <input type="number" class="form-control" style="width: 70px;" ng-model="entityPractice.WorkingDays" id="text_PracticeWorkingDays" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">非工作日天数：</label>
                            <div class="col-sm-9">
                                <input type="number" class="form-control" style="width: 70px;" ng-model="entityPractice.NotWorkingDays" id="text_PracticeNotWorkingDays" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">累计天数：</label>
                            <div class="col-sm-9" id="div_PracticeTotalWorkingDays">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">实践内容：</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="现场观摩" name="PracticeContent" />现场观摩 &nbsp;&nbsp;<input type="checkbox" value="顶岗实习" name="PracticeContent" />顶岗实习&nbsp;&nbsp;<input type="checkbox" value="参与企业产品开发或技术改造" name="PracticeContent" />参与企业产品开发或技术改造&nbsp;&nbsp;<input type="checkbox" value="其他" name="PracticeContent" />其他
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">实践成果：</label>
                            <div class="col-sm-9">
                                <input type="checkbox" value="个人总结" name="Achievement" />个人总结 &nbsp;&nbsp;<input type="checkbox" value="企业鉴定意见" name="Achievement" />企业鉴定意见&nbsp;&nbsp;<input type="checkbox" value="开发产品" name="Achievement" />开发产品&nbsp;&nbsp;<input type="checkbox" value="科研论文" name="Achievement" />科研论文&nbsp;&nbsp;<input type="checkbox" value="其他" name="Achievement" />其他
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label">备注：</label>
                            <div class="col-sm-9">
                                <textarea style="width: 400px; height: 100px;" ng-model="entityPractice.Remark"></textarea>
                            </div>
                        </div>

                    </form>


                    <div class="modal-footer wizard-actions">
                        <a class="btn btn-sm" data-dismiss="modal">
                            <i class="icon-remove"></i>
                            取 消
                        </a>

                        <a class="btn btn-sm btn-primary" ng-click="sumitOtherInfoDetail('practice');">
                            <i class="icon-ok"></i>
                            确 定
                        </a>
                    </div>
                </div>
            </div>


        </div>

        <%--工作经历窗口--%>
        <div id="frmGZJL" class="modal">
            <div class="modal-dialog">
                <div class="modal-content" style="width: 700px; height: 500px;">
                    <div class="modal-header" data-target="#modal-step-contents">
                        <div class="page-header" style="border: none; padding-bottom: 1px;">
                            <h1>新增工作经历信息
                <small><i class="icon-double-angle-right"></i>&nbsp;添加新的工作经历信息
                </small>
                            </h1>
                        </div>
                    </div>

                    <form class="form-horizontal" role="form">

                        <input type="hidden" ng-model="entityExperience.ID" />
                        <input type="hidden" ng-model="entityExperience.TeacherID" />
                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>工作类型：</label>
                            <div class="col-sm-9">
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in gzlxList" ng-model="entityExperience.WorkType">
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>



                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>时间：</label>
                            <div class="col-sm-9">

                                <input class="Wdate" id="timer_ExperienceBeginDate" type="text" onclick="WdatePicker()" ng-model="entityExperience.BeginDate" readonly="readonly" style="height: 35px;" />
                                &nbsp;&nbsp;至&nbsp;&nbsp;
                                <input class="Wdate" id="timer_ExperienceEndDate" type="text" onclick="WdatePicker()" ng-model="entityExperience.EndDate" readonly="readonly" style="height: 35px;" />
                            </div>
                        </div>


                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>工作单位：</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" style="width: 400px;" ng-model="entityExperience.CompanyName" />
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3 control-label"><span style="color: red;">*</span>行业：</label>
                            <div class="col-sm-9">
                                <select ng-options="currOption.DictCode as currOption.DictCodeName for currOption in hyList" ng-model="entityExperience.Industry">
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>




                        <div class="form-group">
                            <label class="col-sm-3 control-label">备注：</label>
                            <div class="col-sm-9">
                                <textarea style="width: 400px; height: 100px;" ng-model="entityExperience.Remark"></textarea>
                            </div>
                        </div>

                    </form>


                    <div class="modal-footer wizard-actions">
                        <a class="btn btn-sm" data-dismiss="modal">
                            <i class="icon-remove"></i>
                            取 消
                        </a>

                        <a class="btn btn-sm btn-primary" ng-click="sumitOtherInfoDetail('experience');">
                            <i class="icon-ok"></i>
                            确 定
                        </a>
                    </div>
                </div>
            </div>


        </div>
    </div>
</asp:Content>

