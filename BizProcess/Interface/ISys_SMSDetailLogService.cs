using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BizProcess.Base.Interface;
using Entity;

namespace BizProcess.Interface
{
    public interface ISys_SMSDetailLogService : IBaseService<Sys_SMSDetailLog>
    {
        //根据短信发送记录ID查看明细
        List<Sys_SMSDetailLog> GetListBySMSlogID(ref int totalCount, ref int pageIndex, ref int pageSize, string SMSLogID, string senderUserID);
    }
}
