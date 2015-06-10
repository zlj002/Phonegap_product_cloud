<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeFile="Basic_NewsManager.aspx.cs" Inherits="Cloud_Server.Base.Basic_NewsManager" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="BizCss/style.css" rel="stylesheet" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <p>
        <a class="btn btn-primary " name="btn_gzzd_add" href="Basic_NewsInfo.aspx">
            <i class="icon-instagram"></i>添加
        </a>

        <a class="btn btn-warning  ">
            <i class="icon-edit"></i>修改
        </a>

        <a class="btn  btn-danger  ">
            <i class="icon-remove"></i>删除
        </a>
    </p>
    <hr />
    <div class="imglist">
        <ul style="width: 1176px;">

            <li style="margin-right: 72px;">
                <div class="details" style="height:310px;">
                    <div class="check">
                        <span class="checkall">
                            <input id="rptList2_chkId_0" type="checkbox" name="rptList2$ctl01$chkId"></span> 
                    </div>
                    <div class="pic">                       
                         <img src="../img/new.png" data-original="/upload/201210/22/201210221028328511.jpg" style="height:160px;width:200px;">s
                    </div>
                    <i class="absbg"></i>
                    <h1 style="padding-top:1px;"><span><a href="Basic_NewsInfo.aspx">需求疲软 4GB DDR3内存纷纷跌破百元大关</a></span></h1>
                    <div class="remark">
                        TrendForce旗下内存调研机构DRAMeXchange的最新数据显示，今年PC整<em>机</em>的出货量高峰已经过去，十月份的笔记本出货量逐步下滑，DRAM内存需求和价格也持续走低，4GB DDR3内存条平均价格下滑了1.54％，仅为16美元，最低的更是只要15.75美元，换成2Gb内存颗粒仅仅只<span class="auto-style1"><strong>有0.83美</strong></span>元，…
                    </div>
                    <div class="tools">
                        <a id="rptList2_lbtnIsMsg_0" title="设置评论" class="msg" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsMsg','')"></a>
                        <a id="rptList2_lbtnIsTop_0" title="设置置顶" class="top" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsTop','')"></a>
                        <a id="rptList2_lbtnIsRed_0" title="设置推荐" class="red" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsRed','')"></a>
                        <a id="rptList2_lbtnIsHot_0" title="设置热门" class="hot" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsHot','')"></a>
                        <a id="rptList2_lbtnIsSlide_0" title="设置幻灯片" class="pic" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsSlide','')"></a>
                        <input name="rptList2$ctl01$txtSortId" type="text" value="0" id="rptList2_txtSortId_0" class="sort" onkeypress="return (/[\d]/.test(String.fromCharCode(event.keyCode)));">
                    </div>
                    <div class="foot">
                        <p class="time">2012-10-20 12:54:21</p>
                        <a href="Basic_NewsInfo.aspx" title="编辑" class="edit">编辑</a>
                    </div>
                </div>
            </li>

          
                        <li style="margin-right: 72px;">
                <div class="details" style="height:310px;">
                    <div class="check">
                        <span class="checkall">
                            <input id="rptList2_chkId_0" type="checkbox" name="rptList2$ctl01$chkId"></span> 
                    </div>
                    <div class="pic">
                         <img src="../img/new.png" data-original="/upload/201210/22/201210221028328511.jpg" style="height:160px;width:200px;">s
                    </div>
                    <i class="absbg"></i>
                    <h1 style="padding-top:1px;"><span><a href="Basic_NewsInfo.aspx">需求疲软 4GB DDR3内存纷纷跌破百元大关</a></span></h1>
                    <div class="remark">
                        TrendForce旗下内存调研机构DRAMeXchange的最新数据显示，今年PC整<em>机</em>的出货量高峰已经过去，十月份的笔记本出货量逐步下滑，DRAM内存需求和价格也持续走低，4GB DDR3内存条平均价格下滑了1.54％，仅为16美元，最低的更是只要15.75美元，换成2Gb内存颗粒仅仅只<span class="auto-style1"><strong>有0.83美</strong></span>元，…
                    </div>
                    <div class="tools">
                        <a id="rptList2_lbtnIsMsg_0" title="设置评论" class="msg" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsMsg','')"></a>
                        <a id="rptList2_lbtnIsTop_0" title="设置置顶" class="top" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsTop','')"></a>
                        <a id="rptList2_lbtnIsRed_0" title="设置推荐" class="red" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsRed','')"></a>
                        <a id="rptList2_lbtnIsHot_0" title="设置热门" class="hot" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsHot','')"></a>
                        <a id="rptList2_lbtnIsSlide_0" title="设置幻灯片" class="pic" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsSlide','')"></a>
                        <input name="rptList2$ctl01$txtSortId" type="text" value="0" id="rptList2_txtSortId_0" class="sort" onkeypress="return (/[\d]/.test(String.fromCharCode(event.keyCode)));">
                    </div>
                    <div class="foot">
                        <p class="time">2012-10-20 12:54:21</p>
                        <a href="Basic_NewsInfo.aspx" title="编辑" class="edit">编辑</a>
                    </div>
                </div>
            </li>

                        <li style="margin-right: 72px;">
                <div class="details" style="height:310px;">
                    <div class="check">
                        <span class="checkall">
                            <input id="rptList2_chkId_0" type="checkbox" name="rptList2$ctl01$chkId"></span> 
                    </div>
                    <div class="pic">
                         <img src="../img/new.png" data-original="/upload/201210/22/201210221028328511.jpg" style="height:160px;width:200px;">s
                    </div>
                    <i class="absbg"></i>
                    <h1 style="padding-top:1px;"><span><a href="Basic_NewsInfo.aspx">需求疲软 4GB DDR3内存纷纷跌破百元大关</a></span></h1>
                    <div class="remark">
                        TrendForce旗下内存调研机构DRAMeXchange的最新数据显示，今年PC整<em>机</em>的出货量高峰已经过去，十月份的笔记本出货量逐步下滑，DRAM内存需求和价格也持续走低，4GB DDR3内存条平均价格下滑了1.54％，仅为16美元，最低的更是只要15.75美元，换成2Gb内存颗粒仅仅只<span class="auto-style1"><strong>有0.83美</strong></span>元，…
                    </div>
                    <div class="tools">
                        <a id="rptList2_lbtnIsMsg_0" title="设置评论" class="msg" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsMsg','')"></a>
                        <a id="rptList2_lbtnIsTop_0" title="设置置顶" class="top" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsTop','')"></a>
                        <a id="rptList2_lbtnIsRed_0" title="设置推荐" class="red" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsRed','')"></a>
                        <a id="rptList2_lbtnIsHot_0" title="设置热门" class="hot" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsHot','')"></a>
                        <a id="rptList2_lbtnIsSlide_0" title="设置幻灯片" class="pic" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsSlide','')"></a>
                        <input name="rptList2$ctl01$txtSortId" type="text" value="0" id="rptList2_txtSortId_0" class="sort" onkeypress="return (/[\d]/.test(String.fromCharCode(event.keyCode)));">
                    </div>
                    <div class="foot">
                        <p class="time">2012-10-20 12:54:21</p>
                        <a href="Basic_NewsInfo.aspx" title="编辑" class="edit">编辑</a>
                    </div>
                </div>
            </li>


                        <li style="margin-right: 72px;">
                <div class="details" style="height:310px;">
                    <div class="check">
                        <span class="checkall">
                            <input id="rptList2_chkId_0" type="checkbox" name="rptList2$ctl01$chkId"></span> 
                    </div>
                    <div class="pic">
                         <img src="../img/new.png" data-original="/upload/201210/22/201210221028328511.jpg" style="height:160px;width:200px;">s
                    </div>
                    <i class="absbg"></i>
                    <h1 style="padding-top:1px;"><span><a href="Basic_NewsInfo.aspx">需求疲软 4GB DDR3内存纷纷跌破百元大关</a></span></h1>
                    <div class="remark">
                        TrendForce旗下内存调研机构DRAMeXchange的最新数据显示，今年PC整<em>机</em>的出货量高峰已经过去，十月份的笔记本出货量逐步下滑，DRAM内存需求和价格也持续走低，4GB DDR3内存条平均价格下滑了1.54％，仅为16美元，最低的更是只要15.75美元，换成2Gb内存颗粒仅仅只<span class="auto-style1"><strong>有0.83美</strong></span>元，…
                    </div>
                    <div class="tools">
                        <a id="rptList2_lbtnIsMsg_0" title="设置评论" class="msg" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsMsg','')"></a>
                        <a id="rptList2_lbtnIsTop_0" title="设置置顶" class="top" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsTop','')"></a>
                        <a id="rptList2_lbtnIsRed_0" title="设置推荐" class="red" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsRed','')"></a>
                        <a id="rptList2_lbtnIsHot_0" title="设置热门" class="hot" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsHot','')"></a>
                        <a id="rptList2_lbtnIsSlide_0" title="设置幻灯片" class="pic" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsSlide','')"></a>
                        <input name="rptList2$ctl01$txtSortId" type="text" value="0" id="rptList2_txtSortId_0" class="sort" onkeypress="return (/[\d]/.test(String.fromCharCode(event.keyCode)));">
                    </div>
                    <div class="foot">
                        <p class="time">2012-10-20 12:54:21</p>
                        <a href="Basic_NewsInfo.aspx" title="编辑" class="edit">编辑</a>
                    </div>
                </div>
            </li>


                        <li style="margin-right: 72px;">
                <div class="details" style="height:310px;">
                    <div class="check">
                        <span class="checkall">
                            <input id="rptList2_chkId_0" type="checkbox" name="rptList2$ctl01$chkId"></span> 
                    </div>
                    <div class="pic">
                         <img src="../img/new.png" data-original="/upload/201210/22/201210221028328511.jpg" style="height:160px;width:200px;">s
                    </div>
                    <i class="absbg"></i>
                    <h1 style="padding-top:1px;"><span><a href="Basic_NewsInfo.aspx">需求疲软 4GB DDR3内存纷纷跌破百元大关</a></span></h1>
                    <div class="remark">
                        TrendForce旗下内存调研机构DRAMeXchange的最新数据显示，今年PC整<em>机</em>的出货量高峰已经过去，十月份的笔记本出货量逐步下滑，DRAM内存需求和价格也持续走低，4GB DDR3内存条平均价格下滑了1.54％，仅为16美元，最低的更是只要15.75美元，换成2Gb内存颗粒仅仅只<span class="auto-style1"><strong>有0.83美</strong></span>元，…
                    </div>
                    <div class="tools">
                        <a id="rptList2_lbtnIsMsg_0" title="设置评论" class="msg" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsMsg','')"></a>
                        <a id="rptList2_lbtnIsTop_0" title="设置置顶" class="top" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsTop','')"></a>
                        <a id="rptList2_lbtnIsRed_0" title="设置推荐" class="red" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsRed','')"></a>
                        <a id="rptList2_lbtnIsHot_0" title="设置热门" class="hot" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsHot','')"></a>
                        <a id="rptList2_lbtnIsSlide_0" title="设置幻灯片" class="pic" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsSlide','')"></a>
                        <input name="rptList2$ctl01$txtSortId" type="text" value="0" id="rptList2_txtSortId_0" class="sort" onkeypress="return (/[\d]/.test(String.fromCharCode(event.keyCode)));">
                    </div>
                    <div class="foot">
                        <p class="time">2012-10-20 12:54:21</p>
                        <a href="Basic_NewsInfo.aspx" title="编辑" class="edit">编辑</a>
                    </div>
                </div>
            </li>

                        <li style="margin-right: 72px;">
                <div class="details" style="height:310px;">
                    <div class="check">
                        <span class="checkall">
                            <input id="rptList2_chkId_0" type="checkbox" name="rptList2$ctl01$chkId"></span> 
                    </div>
                    <div class="pic">
                         <img src="../img/new.png" data-original="/upload/201210/22/201210221028328511.jpg" style="height:160px;width:200px;">s
                    </div>
                    <i class="absbg"></i>
                    <h1 style="padding-top:1px;"><span><a href="Basic_NewsInfo.aspx">需求疲软 4GB DDR3内存纷纷跌破百元大关</a></span></h1>
                    <div class="remark">
                        TrendForce旗下内存调研机构DRAMeXchange的最新数据显示，今年PC整<em>机</em>的出货量高峰已经过去，十月份的笔记本出货量逐步下滑，DRAM内存需求和价格也持续走低，4GB DDR3内存条平均价格下滑了1.54％，仅为16美元，最低的更是只要15.75美元，换成2Gb内存颗粒仅仅只<span class="auto-style1"><strong>有0.83美</strong></span>元，…
                    </div>
                    <div class="tools">
                        <a id="rptList2_lbtnIsMsg_0" title="设置评论" class="msg" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsMsg','')"></a>
                        <a id="rptList2_lbtnIsTop_0" title="设置置顶" class="top" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsTop','')"></a>
                        <a id="rptList2_lbtnIsRed_0" title="设置推荐" class="red" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsRed','')"></a>
                        <a id="rptList2_lbtnIsHot_0" title="设置热门" class="hot" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsHot','')"></a>
                        <a id="rptList2_lbtnIsSlide_0" title="设置幻灯片" class="pic" href="javascript:__doPostBack('rptList2$ctl01$lbtnIsSlide','')"></a>
                        <input name="rptList2$ctl01$txtSortId" type="text" value="0" id="rptList2_txtSortId_0" class="sort" onkeypress="return (/[\d]/.test(String.fromCharCode(event.keyCode)));">
                    </div>
                    <div class="foot">
                        <p class="time">2012-10-20 12:54:21</p>
                        <a href="Basic_NewsInfo.aspx" title="编辑" class="edit">编辑</a>
                    </div>
                </div>
            </li>








        </ul>

    </div>
</asp:Content>
