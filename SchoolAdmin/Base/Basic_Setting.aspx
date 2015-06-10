<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="Basic_Setting.aspx.cs" Inherits="Cloud_Server.Basic_Setting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="BizJS/Basic_Setting.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="div_manager">
        <div class="page-header">
            <h1>设置
                <small><i class="icon-double-angle-right"></i>管理和分配权限
                </small>
            </h1>
        </div>
        <div>
            <img src="../img/venusoft.jpg" />
            <span style="font-size: 18px; font-weight: bold; margin-left: 10px;">晨星团队</span>
            <button id="btn_editSchoolBaseInfo" type="button" class="btn btn-white" style="margin-left: 50px; background-color: #F0F0F0 !important;">修改</button>
        </div>
        <hr />
        <div style="width: 100%;">
            <div style="width: 100%;">
                <h3 style="display: inline;">权限管理</h3>
                <button id="btn_manager" type="button" class="btn btn-white" style="margin: 0 0 0 50px; background-color: #F0F0F0 !important;">管理</button>
            </div>
            <div style="margin-top: 30px; color: #777;">
                创建并管理所有分级管理员帐号。
            </div>
        </div>
    </div>
    <div id="div_edit" style="display: none;">
        <div class="page-header">
            <button class="btn" type="button" id="btn_editManagerCancel">返回</button>
        </div>
        <div style="width: 100%;">
            <div id="div_editManagerLeft" style="width: 30%; font-size: 14px; margin-top: 20px; float: left;">
                <div style="height: 30px;">
                    <a style="cursor: pointer;">新建管理组</a>
                </div>
                <hr />
                <ul id="zTree" class="ztree"></ul>
            </div>
            <div id="div_editManagerRight" style="width: 70%; float: left; padding-left: 100px;">
                <div>
                    <p style="font-size: 14px; font-weight: bolder;">管理组名</p>
                    <p>系统管理组</p>
                </div>
                <div style="margin-top: 50px;">
                    <div>
                        <span style="font-size: 14px; font-weight: bolder;">管理员</span>
                        <a style="cursor: pointer; margin-left: 80px;" id="btn_editManager">修改</a>
                    </div>
                    <div>
                        <table style="float: left; background-color: #91b8d0; height: 30px; color: white; margin: 10px 0 2px 0;">
                            <tbody>
                                <tr>
                                    <td style="padding-left: 10px; padding-right: 10px;">吴翰哲</td>
                                </tr>
                            </tbody>
                        </table>
                        <table style="float: left; background-color: #91b8d0; height: 30px; color: white; margin: 10px 0 3px 2px;">
                            <tbody>
                                <tr>
                                    <td style="padding-left: 10px; padding-right: 10px;">沈寅辉</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
    </div>






    <div class="modal fade in" id="EditManager" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
        <div class="modal-dialog" style="width: 650px;">
            <div class="modal-content">
                <div class="modal-header" style="background-color: #F1F1F1;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" style="width: 110px; margin: 0 auto;">选择管理员</h4>
                    <input type="text" id="hid_search" style="width: 0px  ! important; height: 0px  ! important; border: none; background-color: #F1F1F1; float: left;">
                </div>
                <div style="width: 100%; overflow: auto;">
                    <div style="border-bottom: 1px solid #eee; text-align: center; padding: 10px 0 10px 0;">
                        <div style="width: 90%; min-height: 40px; max-height: 80px; border: 1px solid #e5e5e5; margin: 0 auto; border-radius: 5px; overflow: auto;" id="div_tagsContainer">
                            <input type="text" style="height: 40px; width: 100%; border: 0px;" id="txt_search" placeholder="点击这里输入搜索内容，按回车进行搜索...">
                        </div>
                        <ul id="ul_search" style="display: none;">
                             
                        </ul>
                    </div>
                </div>
                <div style="height: 40px; border-bottom: 1px solid #eee; padding: 10px 0 0 0;">

                    <ul id="selectSendTypeUL" style="list-style: none;">
                        <li style="border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: blue; width: 35px;" id="sendMessageType_Members"><a style="color: #8E8E8E;">成&nbsp;&nbsp;员 </a></li>

                    </ul>
                </div>
                <div style="width: 100%; border-top: 1px solid #eee; height: 350px; overflow: auto;">
                    <div id="SendType_Members" style="display: block;">
                        <div style="width: 40%; height: 100%; border-right: 1px solid #eee; float: left;">
                            <ul id="z_Tree" class="ztree">
                            </ul>
                        </div>
                        <div style="width: 60%; height: 100%; float: left;">

                            <div id="tableList_wrapper" class="dataTables_wrapper no-footer">
                                <table id="detailTb" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="tableList_info">
                                    <thead>
                                        <tr role="row">
                                            <th class="sorting_disabled center" rowspan="1" colspan="1" style="background-color: white !important;">姓名</th>
                                            <th class="sorting_disabled center" rowspan="1" colspan="1" style="background-color: white !important;">所属组织架构</th>
                                            <th class="sorting_disabled center" rowspan="1" colspan="1" style="background-color: white !important;">手机号码</th>
                                            <th class="center sorting_disabled" rowspan="1" colspan="1" style="background-color: white !important;">
                                                <label>
                                                    <input type="checkbox" class="ace">
                                                    <span class="lbl"></span>
                                                </label>
                                            </th>
                                        </tr>
                                    </thead>

                                    <tbody id="listTbBody">
                                        <tr role="row" rowindex="0" userid="2c26c300-36ae-4d5a-884a-3e96cc0231aa" class="">
                                            <td class=" center" style="background-color: white !important;">陆菲莉</td>
                                            <td class=" center" style="background-color: white;">部门2</td>
                                            <td class=" center" style="background-color: white;">17702110788</td>
                                            <td class=" center" style="background-color: white !important;">
                                                <input title="选择" type="checkbox" id="cbk_member2c26c300-36ae-4d5a-884a-3e96cc0231aa"></td>
                                        </tr>
                                        <tr role="row" rowindex="1" userid="09a00937-0a80-4bb5-8497-545eb4017204" class="">
                                            <td class=" center" style="background-color: white !important;">沈晓毅</td>
                                            <td class=" center" style="background-color: white;">部门1</td>
                                            <td class=" center" style="background-color: white;">18049805517</td>
                                            <td class=" center" style="background-color: white !important;">
                                                <input title="选择" type="checkbox" id="cbk_member09a00937-0a80-4bb5-8497-545eb4017204"></td>
                                        </tr>
                                        <tr role="row" rowindex="2" userid="702ced1e-cd90-4d15-8dbe-818b583d8ef1" class="">
                                            <td class=" center" style="background-color: white !important;">沈寅辉</td>
                                            <td class=" center" style="background-color: white;">晨星测试</td>
                                            <td class=" center" style="background-color: white;">18049805517</td>
                                            <td class=" center" style="background-color: white !important;">
                                                <input title="选择" type="checkbox" id="cbk_member702ced1e-cd90-4d15-8dbe-818b583d8ef1"></td>
                                        </tr>
                                        <tr role="row" rowindex="3" userid="f23a96d8-0fec-4cbc-8ba6-25140b6f8a0e" class="">
                                            <td class=" center" style="background-color: white !important;">吴翰哲</td>
                                            <td class=" center" style="background-color: white;">晨星测试</td>
                                            <td class=" center" style="background-color: white;">13524110391</td>
                                            <td class=" center" style="background-color: white !important;">
                                                <input title="选择" type="checkbox" id="cbk_memberf23a96d8-0fec-4cbc-8ba6-25140b6f8a0e"></td>
                                        </tr>
                                        <tr role="row" rowindex="4" userid="37c6964e-fe8c-47fe-a8ec-d36549927c16" class="">
                                            <td class=" center" style="background-color: white !important;">小黄</td>
                                            <td class=" center" style="background-color: white;">部门1</td>
                                            <td class=" center" style="background-color: white;">13918082307</td>
                                            <td class=" center" style="background-color: white !important;">
                                                <input title="选择" type="checkbox" id="cbk_member37c6964e-fe8c-47fe-a8ec-d36549927c16"></td>
                                        </tr>
                                        <tr role="row" rowindex="5" userid="7c1bb767-0664-4af3-b0d1-2831f18c80af" class="">
                                            <td class=" center" style="background-color: white !important;">张令军</td>
                                            <td class=" center" style="background-color: white;">晨星测试</td>
                                            <td class=" center" style="background-color: white;">18217286527</td>
                                            <td class=" center" style="background-color: white !important;">
                                                <input title="选择" type="checkbox" id="cbk_member7c1bb767-0664-4af3-b0d1-2831f18c80af"></td>
                                        </tr>
                                        <tr role="row" rowindex="6" userid="5d9a75bd-704b-460f-ac6e-7a386c9b137f" class="">
                                            <td class=" center" style="background-color: white !important;">张三</td>
                                            <td class=" center" style="background-color: white;">部门1</td>
                                            <td class=" center" style="background-color: white;">18918190664</td>
                                            <td class=" center" style="background-color: white !important;">
                                                <input title="选择" type="checkbox" id="cbk_member5d9a75bd-704b-460f-ac6e-7a386c9b137f"></td>
                                        </tr>
                                        <tr role="row" rowindex="7" userid="c0708adf-fe59-4bc6-bd5a-767309592776" class="">
                                            <td class=" center" style="background-color: white !important;">张一二1</td>
                                            <td class=" center" style="background-color: white;">中层干部</td>
                                            <td class=" center" style="background-color: white;">111111111</td>
                                            <td class=" center" style="background-color: white !important;">
                                                <input title="选择" type="checkbox" id="cbk_memberc0708adf-fe59-4bc6-bd5a-767309592776"></td>
                                        </tr>
                                        <tr role="row" rowindex="8" userid="1844ba28-06ec-46cd-9f73-3f818e85b869" class="">
                                            <td class=" center" style="background-color: white !important;">张一二10</td>
                                            <td class=" center" style="background-color: white;">中层干部</td>
                                            <td class=" center" style="background-color: white;">111111111</td>
                                            <td class=" center" style="background-color: white !important;">
                                                <input title="选择" type="checkbox" id="cbk_member1844ba28-06ec-46cd-9f73-3f818e85b869"></td>
                                        </tr>
                                        <tr role="row" rowindex="9" userid="7fba082c-5138-445e-8ed9-eebf84cdae0d" class="">
                                            <td class=" center" style="background-color: white !important;">张一二100</td>
                                            <td class=" center" style="background-color: white;">中层干部</td>
                                            <td class=" center" style="background-color: white;">111111111</td>
                                            <td class=" center" style="background-color: white !important;">
                                                <input title="选择" type="checkbox" id="cbk_member7fba082c-5138-445e-8ed9-eebf84cdae0d"></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="dataTables_info" id="tableList_info" role="status" aria-live="polite">当前第1页，共215页，共2144位成员</div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="dataTables_paginate paging_bootstrap">
                                            <ul class="pagination">
                                                <li class="prev abled" id="btn_listprev"><a href="#"><i class="icon-double-angle-left"></i></a></li>
                                                <li class="next abled" id="btn_listnext"><a href="#"><i class="icon-double-angle-right"></i></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-success" id="btnSave">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </div>


        </div>
    </div>


    <div class="modal fade in" id="EditSchoolBaseInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
        <div class="modal-dialog" style="width: 650px;">
            <div class="modal-content">
                <div class="modal-header" style="background-color: #F1F1F1;">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title" style="width: 150px; margin: 0 auto;">修改学校基本信息</h4>
                </div>
                <div style="width: 100%; border-top: 1px solid #eee; height: 250px; overflow: auto;">
                    <div style="width: 227px; height: 152px; margin: 20px auto; text-align: center;">
                        <input type="file" id="file_shcoolImg" name="file" style="position: absolute; left: 250px; z-index: 100; cursor: pointer; width: 120px; height: 120px; opacity: 0;" />
                        <img src="../img/venusoft.jpg" style="width: 120px; height: 120px;" />
                        <span style="text-align: center; position: absolute; width: 120px; height: 24px; line-height: 24px; bottom: 0; left: 254px; top: 174px; background-color: #000; opacity: .6; color: #fff;">编辑</span>
                        <p style="margin-top: 5px; color: #777;">推荐尺寸为640x640，大小不超过2M</p>
                    </div>
                    <div style="width: 80%; margin: 20px auto; text-align: center;">
                        <label>学校名称</label>
                        <input type="text" style="width: 230px; margin-left: 10px;" value="晨星软件" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" id="btnSaveSchoolBaseInfo">保存修改</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </div>


        </div>
    </div>
</asp:Content>
