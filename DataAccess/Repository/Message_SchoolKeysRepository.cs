using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataAccess.Base.Repository;
using Entity;
using DataAccess.Interface;

namespace DataAccess.Repository
{
    public class Message_SchoolKeysRepository : RootRepositoryBase<Message_SchoolKeys>, IMessage_SchoolKeysRepository
    {
        /// <summary>
        /// 默认构造
        /// </summary> 
        public Message_SchoolKeysRepository()
        {
        }
        /// <summary>
        /// 指定学校id构造
        /// </summary>
        /// <param name="schoolID"></param>
        public Message_SchoolKeysRepository(string schoolID)
        {
            SchoolID = schoolID;
        }

        public Message_SchoolKeys GetSchoolKeysBySchoolIDAndKey(string schoolID, string key)
        {
            Dictionary<string, object> param = new Dictionary<string, object>();
            param.Add("SchoolID", schoolID);
            param.Add("SchoolKey", key);
            return GetEntityByColNamesAndColValues(param);


        }
    }
}
