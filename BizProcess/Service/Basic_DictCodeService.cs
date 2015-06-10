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
    public class Basic_DictCodeService: BaseService<Basic_DictCode>, IBasic_DictCodeService
    {
        IBasic_DictCodeRepository subRepository;
        public Basic_DictCodeService()
        {
            subRepository = new Basic_DictCodeRepository();
            base.repository = subRepository;
        }
    }
}
