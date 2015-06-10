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
    public class CommonService: BaseService<CommonEntity>, ICommonService
    {
        ICommonRepository subRepository;
        public CommonService()
        {
            subRepository = new CommonRepository();
            base.repository = subRepository;
        }
    }
}
