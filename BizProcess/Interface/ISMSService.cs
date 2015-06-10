using BizProcess.Base.Interface;
using Entity;
using Entity.CustomEntity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BizProcess.Interface
{
    public interface ISMSService
    {
        //发送短信
        string SendSMSMessage(string userString, string passwordString, string[] mobiles, string content, string planTime, string filename);


        //查询短信总余量
        string GetRemainderSmsCount(string userName,string password);
    }
}
