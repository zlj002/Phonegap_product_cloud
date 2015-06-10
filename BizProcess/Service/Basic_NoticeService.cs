using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Entity;
using BizProcess.Interface;
using BizProcess.Base.Service;
using DataAccess.Repository;
using DataAccess.Interface;

namespace BizProcess.Service
{
    public class Basic_NoticeService : BaseService<Basic_Notice>, IBasic_NoticeService
    {
        IBasic_NoticeRepository subRepository;

        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_NoticeService()
        {
            subRepository = new Basic_NoticeRepository();
            base.repository = subRepository;
        }
        /// <summary>
        /// 默认构造
        /// </summary>
        public Basic_NoticeService(string schoolID)
        {
            base.SchoolID = schoolID;
            subRepository = new Basic_NoticeRepository(base.SchoolID);
            base.repository = subRepository;
        }

        public List<Basic_Notice> GetListByReceiveUserID(string receiveUserID, ref int totalCount, ref int pageIndex, ref int pageSize)
        {
            return subRepository.GetListByReceiveUserID(receiveUserID, ref totalCount, ref pageIndex, ref pageSize);
        }


        public Basic_Notice GetNoticeByID(string ID)
        {
            return subRepository.GetNoticeByID(ID);
        }
    }
}
