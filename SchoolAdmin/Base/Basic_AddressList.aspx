<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="Basic_AddressList.aspx.cs" Inherits=" Base_Basic_AddressList" %> 

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!--ztree-->
    <script src="/plugins/zTree_v3/js/jquery.ztree.core-3.5.min.js"></script>
    <script src="/plugins/zTree_v3/js/jquery.ztree.exedit-3.5.min.js"></script>
    <script src="/plugins/zTree_v3/js/jquery.ztree.core-3.5.min.js"></script>
    <link href="/plugins/zTree_v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />

    <link href="BizCss/Basic_AddressList.css" rel="stylesheet" />
    <script src="BizJS/Basic_AddressList.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <h1>通讯录
                <small><i class="icon-double-angle-right"></i>联系人信息汇总
                </small>
        </h1>
    </div>
    <div id="content">
        <div id="left">
            <ul id="zTree" class="ztree"></ul>

        </div>
        <div id="right">
            <div id="tableList " class="dataTables_wrapper no-footer">
                <table id="ListTb" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid" aria-describedby="tableList_info">
                    <thead>
                        <tr role="row">
                            <th class="center sorting_disabled" rowspan="1" colspan="1">
                                <label>
                                    <input type="checkbox" class="ace" id="cbx_tableList_selectAll">
                                    <span class="lbl"></span>
                                </label>
                            </th>
                            <th class="sorting_disabled center" rowspan="1" colspan="1" style="display: none">架构ID</th>
                            <th class="sorting_disabled center" rowspan="1" colspan="1" style="display: none">用户ID</th>
                            <th class="sorting_disabled center" rowspan="1" colspan="1">姓名</th>
                            <th class="sorting_disabled center" rowspan="1" colspan="1">职务</th>
                            <th class="sorting_disabled center" rowspan="1" colspan="1">所属组织架构&nbsp;/&nbsp;群组</th>
                            <th class="sorting_disabled center" rowspan="1" colspan="1">手机</th>
                            <th class="sorting_disabled center" rowspan="1" colspan="1">邮箱</th>
                            <th class="sorting_disabled center" rowspan="1" colspan="1">操作</th>
                        </tr>
                    </thead>

                    <tbody id="listTbBody" organizetype="0">
                        <tr id="listTr0">
                            <td class=" center">
                                <input rowindex="0" oid="1095" userid="0a2fc124-7f17-40d4-9ac8-d1cb305593ba" title="选择" type="checkbox" id="tableList_check_0" name="tableList_check"></td>
                            <td class=" center" style="display: none;">1095</td>
                            <td class=" center" style="display: none;">0a2fc124-7f17-40d4-9ac8-d1cb305593ba</td>
                            <td style="cursor: pointer;" class="center" id="listName0">23423</td>
                            <td class="center" style="cursor: pointer;" id="listNo0">暂无</td>
                            <td style="cursor: pointer;" class=" center" id="listOrganizeName0">xxxx</td>
                            <td style="cursor: pointer;" class=" center" id="listMobilePhone0">3434343</td>
                            <td style="cursor: pointer;" class=" center" id="listEmail0">暂无</td>
                            <td class=" center" style="display: none;">其他</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center">
                                <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a class="red" style="cursor: pointer" id="delselectedList0"><i class="icon-trash bigger-130"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            </td>
                        </tr>
                        <tr id="listTr1">
                            <td class=" center">
                                <input rowindex="1" oid="1092" userid="ed71b507-0f26-47ae-a01e-90b09864eed8" title="选择" type="checkbox" id="tableList_check_1" name="tableList_check"></td>
                            <td class=" center" style="display: none;">1092</td>
                            <td class=" center" style="display: none;">ed71b507-0f26-47ae-a01e-90b09864eed8</td>
                            <td style="cursor: pointer;" class="center" id="listName1">234234</td>
                            <td class="center" style="cursor: pointer;" id="listNo1">暂无</td>
                            <td style="cursor: pointer;" class=" center" id="listOrganizeName1">vvvvv</td>
                            <td style="cursor: pointer;" class=" center" id="listMobilePhone1">23423423</td>
                            <td style="cursor: pointer;" class=" center" id="listEmail1">暂无</td>
                            <td class=" center" style="display: none;">其他</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center">
                                <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a class="red" style="cursor: pointer" id="delselectedList1"><i class="icon-trash bigger-130"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            </td>
                        </tr>
                        <tr id="listTr2">
                            <td class=" center">
                                <input rowindex="2" oid="1094" userid="aa469c70-c2eb-4807-8134-caa7ab65cc3c" title="选择" type="checkbox" id="tableList_check_2" name="tableList_check"></td>
                            <td class=" center" style="display: none;">1094</td>
                            <td class=" center" style="display: none;">aa469c70-c2eb-4807-8134-caa7ab65cc3c</td>
                            <td style="cursor: pointer;" class="center" id="listName2">3453453</td>
                            <td class="center" style="cursor: pointer;" id="listNo2">暂无</td>
                            <td style="cursor: pointer;" class=" center" id="listOrganizeName2">cccccccc</td>
                            <td style="cursor: pointer;" class=" center" id="listMobilePhone2">ewrtewrwe</td>
                            <td style="cursor: pointer;" class=" center" id="listEmail2">暂无</td>
                            <td class=" center" style="display: none;">其他</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center">
                                <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a class="red" style="cursor: pointer" id="delselectedList2"><i class="icon-trash bigger-130"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            </td>
                        </tr>
                        <tr id="listTr3">
                            <td class=" center">
                                <input rowindex="3" oid="1096" userid="ebc25a91-4a45-4cdc-988b-1a5f2d1d3974" title="选择" type="checkbox" id="tableList_check_3" name="tableList_check"></td>
                            <td class=" center" style="display: none;">1096</td>
                            <td class=" center" style="display: none;">ebc25a91-4a45-4cdc-988b-1a5f2d1d3974</td>
                            <td style="cursor: pointer;" class="center" id="listName3">dfdfd</td>
                            <td class="center" style="cursor: pointer;" id="listNo3">暂无</td>
                            <td style="cursor: pointer;" class=" center" id="listOrganizeName3">fdvfdgdf</td>
                            <td style="cursor: pointer;" class=" center" id="listMobilePhone3">12312312</td>
                            <td style="cursor: pointer;" class=" center" id="listEmail3">暂无</td>
                            <td class=" center" style="display: none;">教职工</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center">
                                <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a class="red" style="cursor: pointer" id="delselectedList3"><i class="icon-trash bigger-130"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            </td>
                        </tr>
                        <tr id="listTr4">
                            <td class=" center">
                                <input rowindex="4" oid="1076" userid="542f37a5-542d-4e71-8479-c7d9a9c3264a" title="选择" type="checkbox" id="tableList_check_4" name="tableList_check"></td>
                            <td class=" center" style="display: none;">1076</td>
                            <td class=" center" style="display: none;">542f37a5-542d-4e71-8479-c7d9a9c3264a</td>
                            <td style="cursor: pointer;" class="center" id="listName4">dsfsdf</td>
                            <td class="center" style="cursor: pointer;" id="listNo4">暂无</td>
                            <td style="cursor: pointer;" class=" center" id="listOrganizeName4">汽修1班</td>
                            <td style="cursor: pointer;" class=" center" id="listMobilePhone4">324234234</td>
                            <td style="cursor: pointer;" class=" center" id="listEmail4">暂无</td>
                            <td class=" center" style="display: none;">教职工</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center">
                                <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a class="red" style="cursor: pointer" id="delselectedList4"><i class="icon-trash bigger-130"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            </td>
                        </tr>
                        <tr id="listTr5">
                            <td class=" center">
                                <input rowindex="5" oid="1076" userid="bfd17a09-7e77-438b-bcef-b2189f9e35e5" title="选择" type="checkbox" id="tableList_check_5" name="tableList_check"></td>
                            <td class=" center" style="display: none;">1076</td>
                            <td class=" center" style="display: none;">bfd17a09-7e77-438b-bcef-b2189f9e35e5</td>
                            <td style="cursor: pointer;" class="center" id="listName5">erterter</td>
                            <td class="center" style="cursor: pointer;" id="listNo5">暂无</td>
                            <td style="cursor: pointer;" class=" center" id="listOrganizeName5">汽修1班</td>
                            <td style="cursor: pointer;" class=" center" id="listMobilePhone5">345345345</td>
                            <td style="cursor: pointer;" class=" center" id="listEmail5">暂无</td>
                            <td class=" center" style="display: none;">学生</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center">
                                <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a class="red" style="cursor: pointer" id="delselectedList5"><i class="icon-trash bigger-130"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            </td>
                        </tr>
                        <tr id="listTr6">
                            <td class=" center">
                                <input rowindex="6" oid="1096" userid="60e5bba5-09dc-4d5f-88fa-e051aca107b6" title="选择" type="checkbox" id="tableList_check_6" name="tableList_check"></td>
                            <td class=" center" style="display: none;">1096</td>
                            <td class=" center" style="display: none;">60e5bba5-09dc-4d5f-88fa-e051aca107b6</td>
                            <td style="cursor: pointer;" class="center" id="listName6">ff</td>
                            <td class="center" style="cursor: pointer;" id="listNo6">暂无</td>
                            <td style="cursor: pointer;" class=" center" id="listOrganizeName6">fdvfdgdf</td>
                            <td style="cursor: pointer;" class=" center" id="listMobilePhone6">34324234</td>
                            <td style="cursor: pointer;" class=" center" id="listEmail6">暂无</td>
                            <td class=" center" style="display: none;">教职工</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center">
                                <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a class="red" style="cursor: pointer" id="delselectedList6"><i class="icon-trash bigger-130"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            </td>
                        </tr>
                        <tr id="listTr7">
                            <td class=" center">
                                <input rowindex="7" oid="1096" userid="eb1bac11-a4e8-4ce7-bedf-a4e1a53a66f3" title="选择" type="checkbox" id="tableList_check_7" name="tableList_check"></td>
                            <td class=" center" style="display: none;">1096</td>
                            <td class=" center" style="display: none;">eb1bac11-a4e8-4ce7-bedf-a4e1a53a66f3</td>
                            <td style="cursor: pointer;" class="center" id="listName7">ff</td>
                            <td class="center" style="cursor: pointer;" id="listNo7">暂无</td>
                            <td style="cursor: pointer;" class=" center" id="listOrganizeName7">fdvfdgdf</td>
                            <td style="cursor: pointer;" class=" center" id="listMobilePhone7">34324234</td>
                            <td style="cursor: pointer;" class=" center" id="listEmail7">暂无</td>
                            <td class=" center" style="display: none;">教职工</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center">
                                <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a class="red" style="cursor: pointer" id="delselectedList7"><i class="icon-trash bigger-130"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            </td>
                        </tr>
                        <tr id="listTr8">
                            <td class=" center">
                                <input rowindex="8" oid="1096" userid="e615bd93-bfdc-4803-a2f7-72679a6f821b" title="选择" type="checkbox" id="tableList_check_8" name="tableList_check"></td>
                            <td class=" center" style="display: none;">1096</td>
                            <td class=" center" style="display: none;">e615bd93-bfdc-4803-a2f7-72679a6f821b</td>
                            <td style="cursor: pointer;" class="center" id="listName8">fghfghgfh</td>
                            <td class="center" style="cursor: pointer;" id="listNo8">暂无</td>
                            <td style="cursor: pointer;" class=" center" id="listOrganizeName8">fdvfdgdf</td>
                            <td style="cursor: pointer;" class=" center" id="listMobilePhone8">45645645645</td>
                            <td style="cursor: pointer;" class=" center" id="listEmail8">暂无</td>
                            <td class=" center" style="display: none;">其他</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center">
                                <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a class="red" style="cursor: pointer" id="delselectedList8"><i class="icon-trash bigger-130"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            </td>
                        </tr>
                        <tr id="listTr9">
                            <td class=" center">
                                <input rowindex="9" oid="1091" userid="3373fd78-75f6-4f8b-bbfb-1641d1c62d89" title="选择" type="checkbox" id="tableList_check_9" name="tableList_check"></td>
                            <td class=" center" style="display: none;">1091</td>
                            <td class=" center" style="display: none;">3373fd78-75f6-4f8b-bbfb-1641d1c62d89</td>
                            <td style="cursor: pointer;" class="center" id="listName9">ggg</td>
                            <td class="center" style="cursor: pointer;" id="listNo9">暂无</td>
                            <td style="cursor: pointer;" class=" center" id="listOrganizeName9">sdfsdfsd</td>
                            <td style="cursor: pointer;" class=" center" id="listMobilePhone9">234234</td>
                            <td style="cursor: pointer;" class=" center" id="listEmail9">暂无</td>
                            <td class=" center" style="display: none;">其他</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center">
                                <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a class="red" style="cursor: pointer" id="delselectedList9"><i class="icon-trash bigger-130"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            </td>
                        </tr>
                        <tr id="listTr10">
                            <td class=" center">
                                <input rowindex="10" oid="1093" userid="94335455-2184-4cf6-a6c8-5c2e14c976da" title="选择" type="checkbox" id="tableList_check_10" name="tableList_check"></td>
                            <td class=" center" style="display: none;">1093</td>
                            <td class=" center" style="display: none;">94335455-2184-4cf6-a6c8-5c2e14c976da</td>
                            <td style="cursor: pointer;" class="center" id="listName10">sdfsdf</td>
                            <td class="center" style="cursor: pointer;" id="listNo10">暂无</td>
                            <td style="cursor: pointer;" class=" center" id="listOrganizeName10">dfvdfvdfvdf</td>
                            <td style="cursor: pointer;" class=" center" id="listMobilePhone10">45345345</td>
                            <td style="cursor: pointer;" class=" center" id="listEmail10">暂无</td>
                            <td class=" center" style="display: none;">家长</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center">
                                <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a class="red" style="cursor: pointer" id="delselectedList10"><i class="icon-trash bigger-130"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            </td>
                        </tr>
                        <tr id="listTr11">
                            <td class=" center">
                                <input rowindex="11" oid="1082" userid="ad5b86af-72bf-4ff1-8e1a-a70358e7186a" title="选择" type="checkbox" id="tableList_check_11" name="tableList_check"></td>
                            <td class=" center" style="display: none;">1082</td>
                            <td class=" center" style="display: none;">ad5b86af-72bf-4ff1-8e1a-a70358e7186a</td>
                            <td style="cursor: pointer;" class="center" id="listName11">sdfsdfsd</td>
                            <td class="center" style="cursor: pointer;" id="listNo11">暂无</td>
                            <td style="cursor: pointer;" class=" center" id="listOrganizeName11">汽修2班</td>
                            <td style="cursor: pointer;" class=" center" id="listMobilePhone11">23423432</td>
                            <td style="cursor: pointer;" class=" center" id="listEmail11">暂无</td>
                            <td class=" center" style="display: none;">其他</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center">
                                <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a class="red" style="cursor: pointer" id="delselectedList11"><i class="icon-trash bigger-130"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            </td>
                        </tr>
                        <tr id="listTr12">
                            <td class=" center">
                                <input rowindex="12" oid="1090" userid="a1587451-3bbc-4ada-b331-942d78754ac3" title="选择" type="checkbox" id="tableList_check_12" name="tableList_check"></td>
                            <td class=" center" style="display: none;">1090</td>
                            <td class=" center" style="display: none;">a1587451-3bbc-4ada-b331-942d78754ac3</td>
                            <td style="cursor: pointer;" class="center" id="listName12">sdfsdfsd</td>
                            <td class="center" style="cursor: pointer;" id="listNo12">暂无</td>
                            <td style="cursor: pointer;" class=" center" id="listOrganizeName12">sdfsdfds</td>
                            <td style="cursor: pointer;" class=" center" id="listMobilePhone12">3243242342</td>
                            <td style="cursor: pointer;" class=" center" id="listEmail12">暂无</td>
                            <td class=" center" style="display: none;">其他</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center">
                                <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a class="red" style="cursor: pointer" id="delselectedList12"><i class="icon-trash bigger-130"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            </td>
                        </tr>
                        <tr id="listTr13">
                            <td class=" center">
                                <input rowindex="13" oid="1097" userid="1bedf4b5-b7df-475e-a6f3-2d7d62795938" title="选择" type="checkbox" id="tableList_check_13" name="tableList_check"></td>
                            <td class=" center" style="display: none;">1097</td>
                            <td class=" center" style="display: none;">1bedf4b5-b7df-475e-a6f3-2d7d62795938</td>
                            <td style="cursor: pointer;" class="center" id="listName13">测试100</td>
                            <td class="center" style="cursor: pointer;" id="listNo13">副校长</td>
                            <td style="cursor: pointer;" class=" center" id="listOrganizeName13">dfdfds</td>
                            <td style="cursor: pointer;" class=" center" id="listMobilePhone13">13524223345</td>
                            <td style="cursor: pointer;" class=" center" id="listEmail13">暂无</td>
                            <td class=" center" style="display: none;">教职工</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center">
                                <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a class="red" style="cursor: pointer" id="delselectedList13"><i class="icon-trash bigger-130"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            </td>
                        </tr>
                        <tr id="listTr14">
                            <td class=" center">
                                <input rowindex="14" oid="1076" userid="478a463f-ee83-4915-a1dd-65cd249e8a6f" title="选择" type="checkbox" id="tableList_check_14" name="tableList_check"></td>
                            <td class=" center" style="display: none;">1076</td>
                            <td class=" center" style="display: none;">478a463f-ee83-4915-a1dd-65cd249e8a6f</td>
                            <td style="cursor: pointer;" class="center" id="listName14">测试110</td>
                            <td class="center" style="cursor: pointer;" id="listNo14">教导主任</td>
                            <td style="cursor: pointer;" class=" center" id="listOrganizeName14">汽修1班</td>
                            <td style="cursor: pointer;" class=" center" id="listMobilePhone14">1381344444</td>
                            <td style="cursor: pointer;" class=" center" id="listEmail14">暂无</td>
                            <td class=" center" style="display: none;">教职工</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center" style="display: none;">暂无</td>
                            <td class=" center">
                                <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">&nbsp;&nbsp;&nbsp;&nbsp;<a class="red" style="cursor: pointer" id="delselectedList14"><i class="icon-trash bigger-130"></i></a>&nbsp;&nbsp;&nbsp;&nbsp;</div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="dataTables_info" id="tableList_info" role="status" aria-live="polite">当前第1页，共159页，共2376条数据</div>
                    </div>
                    <div class="col-sm-6">
                        <div class="dataTables_paginate paging_bootstrap" id="tableList_paginate">
                            <ul class="pagination">
                                <li class="prev abled" id="btn_prev"><a href="#"><i class="icon-double-angle-left"></i></a></li>

                                <li class="next abled" id="btn_next"><a href="#"><i class="icon-double-angle-right"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
