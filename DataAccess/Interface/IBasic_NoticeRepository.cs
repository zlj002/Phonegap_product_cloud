﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using DataAccess.Base.Interface;

namespace DataAccess.Interface
{
    public interface IBasic_NoticeRepository : IRepository<Basic_Notice>
    {
        /// <summary>
        /// 根据当前用户获取通知公告
        /// </summary>
        /// <returns></returns>
        List<Basic_Notice> GetListByReceiveUserID(string receiveUserID, ref int totalCount, ref int pageIndex, ref int pageSize);

        /// <summary>
        /// 根据ID获取通知公告
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        Basic_Notice GetNoticeByID(string ID);
    }
}
