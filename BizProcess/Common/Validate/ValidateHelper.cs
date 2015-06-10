using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.IO;
using System.Xml; 
using System.Text.RegularExpressions;
using BizProcess.Service;
using OurHelper;
using Newtonsoft.Json;

namespace BizProcess.Common.Validate
{
    public class ValidateHelper
    {
        /// <summary>
        /// 获取列的验证情况
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="entity"></param>
        /// <returns></returns>
        public static List<ValidateColumnHelper> GetColumusValidate<T>(T entity)
        {
            List<ValidateColumnHelper> list = new List<ValidateColumnHelper>();
            System.Reflection.PropertyInfo[] propertyInfos = typeof(T).GetProperties();
            Assembly assembly = Assembly.Load("BizProcess");
            Stream stream = assembly.GetManifestResourceStream("BizProcess.Common.Validate.ValidateHelper.xml");
            XmlDocument xmlDoc = null;
            xmlDoc = new XmlDocument();
            xmlDoc.Load(stream); 
            XmlNode xmlNode = xmlDoc.SelectSingleNode("Tables/" + typeof(T).Name);
            if (xmlNode != null)
            {
                XmlNodeList xnl = xmlNode.ChildNodes;
                if (xnl.Count > 0)
                {
                    foreach (XmlNode node in xnl)
                    {
                        ValidateColumnHelper vch = new ValidateColumnHelper();
                        if (node.Attributes["ColName"] != null)
                        {
                            vch.ColName = node.Attributes["ColName"].Value;
                        }
                        if (node.Attributes["Dis"] != null)
                        {
                            vch.Dis = node.Attributes["Dis"].Value;
                        }
                        if (node.Attributes["IsNotNull"] != null)
                        {
                            vch.IsNotNull = Convert.ToBoolean(node.Attributes["IsNotNull"].Value);
                        }
                        if (node.Attributes["IsNotNullMessage"] != null)
                        {
                            vch.IsNotNullMessage = node.Attributes["IsNotNullMessage"].Value;
                        }
                        if (node.Attributes["MustExists"] != null)
                        {
                            vch.MustExists = node.Attributes["MustExists"].Value;
                        }
                        if (node.Attributes["MustExistsMessage"] != null)
                        {
                            vch.MustExistsMessage = node.Attributes["MustExistsMessage"].Value;
                        }
                        if (node.Attributes["MustNoExists"] != null)
                        {
                            vch.MustNoExists = node.Attributes["MustNoExists"].Value;
                        }
                        if (node.Attributes["MustNoExistsMessage"] != null)
                        {
                            vch.MustNoExistsMessage = node.Attributes["MustNoExistsMessage"].Value;
                        }
                        if (node.Attributes["Regular"] != null)
                        {
                            vch.Regular = node.Attributes["Regular"].Value;
                        }

                        if (node.Attributes["RegularErrorMessage"] != null)
                        {
                            vch.RegularErrorMessage = node.Attributes["RegularErrorMessage"].Value;
                        }
                        list.Add(vch);
                    }
                }
            }
            return list;

        }

        public static string ValidateObject<T>(T entity, bool isInsert = true)
        {
            StringBuilder resultBuilder = new StringBuilder();
            try
            {
                System.Reflection.PropertyInfo[] propertyInfos = typeof(T).GetProperties();
                List<ValidateColumnHelper> list = GetColumusValidate(entity);
                foreach (var pi in propertyInfos)
                {
                    ValidateColumnHelper vch = list.Where(o => o.ColName == pi.Name).FirstOrDefault();
                    if (vch != null)
                    {

                        var tempValue = pi.GetValue(entity, null);
                        //非空验证
                        if (vch.IsNotNull && tempValue == null)
                        {
                            resultBuilder.AppendFormat(vch.IsNotNullMessage);
                            break;
                        }
                        //非空验证
                        if (vch.IsNotNull==false && tempValue == null)
                        {
                            continue;
                        }

                        if (tempValue != null)
                        {
                            Type t = tempValue.GetType();  // yourType指的是你要判断的类型
                            if (t.IsValueType || t == typeof(System.String))  // 为true，表示是.net的原生类型，即值类型，注意string类型，自定义的struct，class不是值类型
                            {
                                //正则验证,条件--有正则限制，但数据不正确
                                if (!string.IsNullOrEmpty(vch.Regular) && !QuickValidate(vch.Regular, tempValue.ToString()))
                                {
                                    resultBuilder.AppendFormat(vch.RegularErrorMessage);
                                    break;
                                }
                                //必须不存在的验证   格式 MustNoExists="{'TableName':'Basic.SchoolSuperior','Where':' 1=1 and SchoolSuperiorID=#$(this)#'}" 
                                if (!string.IsNullOrEmpty(vch.MustNoExists))
                                {
                                    RelationTable rt = JsonConvert.DeserializeObject<RelationTable>(vch.MustNoExists);
                                    CommonService cs = new CommonService();
                                    string whereTemp = rt.InsertWhere;
                                    if (!isInsert)
                                    {
                                        whereTemp = rt.UpdateWhere;
                                        if (string.IsNullOrEmpty(whereTemp))
                                        {
                                            continue;
                                        }
                                    }

                                    MatchCollection mc = Regex.Matches(whereTemp, @"#.*?#");
                                    foreach (Match item in mc)
                                    {
                                        string m_Item = item.Value; //#xxx#
                                        var t_p = propertyInfos.Where(o => o.Name == m_Item.Replace("#", "")).ToList().FirstOrDefault();
                                        var m_Val = t_p.GetValue(entity, null);
                                        whereTemp = whereTemp.Replace(m_Item, String.Format("'{0}'", m_Val));

                                    }



                                    if (cs.IsExists(rt.TableName, whereTemp))
                                    {
                                        resultBuilder.AppendFormat(vch.MustNoExistsMessage);
                                        break;
                                    }

                                }

                                //必须存在的验证    格式 MustExists="{'TableName':'Basic.SchoolSuperior','Where':' 1=1 and SchoolSuperiorID=#$(this)#'}"
                                if (!string.IsNullOrEmpty(vch.MustExists))
                                {
                                    RelationTable rt = JsonConvert.DeserializeObject<RelationTable>(vch.MustExists);
                                    CommonService cs = new CommonService();
                                    string whereTemp = rt.InsertWhere;
                                    if (!isInsert)
                                    {
                                        whereTemp = rt.UpdateWhere;
                                        if (string.IsNullOrEmpty(whereTemp))
                                        {
                                            continue;
                                        }
                                    }

                                    MatchCollection mc = Regex.Matches(whereTemp, @"#.*?#");
                                    foreach (Match item in mc)
                                    {
                                        string m_Item = item.Value; //#xxx#
                                        var t_p = propertyInfos.Where(o => o.Name == m_Item.Replace("#", "")).ToList().FirstOrDefault();
                                        var m_Val = t_p.GetValue(entity, null);
                                        whereTemp = whereTemp.Replace(m_Item, String.Format("'{0}'", m_Val));

                                    }
                                    if (!cs.IsExists(rt.TableName, whereTemp))
                                    {
                                        resultBuilder.AppendFormat(vch.MustExistsMessage);
                                        break;
                                    }
                                }

                            }
                        }
                    }
                }
            }
            catch (Exception e)
            {
                resultBuilder.AppendFormat("数据验证出错" + e.Message);
            }
            return resultBuilder.ToString();
        }

        /// <summary> 
        /// 快速验证一个字符串是否符合指定的正则表达式。 
        /// </summary> 
        /// <param name="_express">正则表达式的内容。</param> 
        /// <param name="_value">需验证的字符串。</param> 
        /// <returns>是否合法的bool值。</returns> 
        public static bool QuickValidate(string _express, string _value)
        {
            if (_value == null) return false;
            System.Text.RegularExpressions.Regex myRegex = new System.Text.RegularExpressions.Regex(_express);
            return myRegex.IsMatch(_value);
        }
        /// <summary> 
        /// 判断是否是数字，包括小数和整数。 需要QuickValidate方法
        /// </summary> 
        /// <param name="_value">需验证的字符串。</param> 
        /// <returns>是否合法的bool值。</returns> 
        public static bool IsNumber(string _value)
        {
            //数字的正则表达式
            string regex = @"^(0|([1-9]+[0-9]*))(.[0-9]+)?$";
            return QuickValidate(regex, _value);
        }
        /// <summary> 
        /// 判断是否电子邮箱。 需要QuickValidate方法
        /// </summary> 
        /// <param name="_value">需验证的字符串。</param> 
        /// <returns>是否合法的bool值。</returns> 
        public static bool IsEmail(string _value)
        {
            //电子邮箱的正则表达式
            string regex = @"^([a-z0-9A-Z]+[-|\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\.)+[a-zA-Z]{2,}$";
            return QuickValidate(regex, _value);
        }
        /// <summary> 
        /// 判断是否是手机号码现在的手机号码增加了150,153,156,158,159，157，188，189。 需要QuickValidate方法
        /// </summary> 
        /// <param name="_value">需验证的字符串。</param> 
        /// <returns>是否合法的bool值。</returns> 
        public static bool IsMobilePhone(string _value)
        {
            //手机号码的正则表达式
            string regex = @"^(13[0-9]|15[0-9]|18[0-9])\d{8}$";
            return QuickValidate(regex, _value);
        }
        /// <summary>
        /// 判断字符串是否以字母开头以字母开头，长度在5-20之间，只能包含字符、数字和下划线

        /// </summary>
        /// <param name="_value">需验证的字符串</param>
        /// <returns>是否合法的bool值</returns>
        public static bool IsOkNameOrPwd(string _value)
        {
            //以字母开头以字母开头，长度在5-20之间，只能包含字符、数字和下划线的正则表达式

            string regex = @"^[a-zA-Z][a-zA-Z0-9_]{4,15}$";
            return QuickValidate(regex, _value);
        }
        /// <summary>
        /// 判断是否是电话号码

        /// </summary>
        /// <param name="_value">需验证的字符串</param>
        /// <returns>是否合法的bool值</returns>
        public static bool IsPhone(string _value)
        {
            //电话号码正则表达式（支持手机号码，3-4位区号，7-8位直播号码，1－4位分机号） 
            string regex = @"((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)";
            return QuickValidate(regex, _value);
        }

        /// <summary>
        /// 是否是密码

        /// </summary>
        /// <param name="_value"></param>
        /// <returns></returns>
        public static bool IsPwd(string _value)
        {
            //密码正则表达式必须是输入字母、数字、下划线组成的6~20的字符串
            string regex = @"^(\w){6,20}$";
            return QuickValidate(regex, _value);
        }


        /// <summary>
        /// 字符串中必须是 字母，数字，下划线组成的指定长度
        /// </summary>
        /// <param name="_value"></param>
        /// <returns></returns>
        public static bool IsLegalString(string _value, int minLength, int maxLength)
        {
            //密码正则表达式必须是输入字母、数字、下划线组成的最小值~最大值的字符串

            string regex = @"^(\w){" + minLength + "," + maxLength + "}$";
            return QuickValidate(regex, _value);
        }

        /// <summary>
        /// 是否是日期 yyyy-MM-dd/yyyy-MM-d
        /// </summary>
        /// <param name="_value"></param>
        /// <returns></returns>
        public static bool IsDate(string _value)
        {
            string regex = @"^((\d{2}(([02468][048])|([13579][26]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|([1-2][0-9])))))|(\d{2}(([02468][1235679])|([13579][01345789]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\s(((0?[1-9])|(1[0-2]))\:([0-5][0-9])((\s)|(\:([0-5][0-9])\s))([AM|PM|am|pm]{2,2})))?$";
            return QuickValidate(regex, _value);
        }
    }
    /// <summary>
    /// 表之间的关系，用于检查必须存在或者必须不存在
    /// </summary>
    public class RelationTable
    {
        /// <summary>
        /// 表名
        /// </summary>
        public string TableName { get; set; }
        /// <summary>
        /// 新增条件
        /// </summary>
        public string InsertWhere { get; set; }
        /// <summary>
        /// 更新条件
        /// </summary>
        public string UpdateWhere { get; set; }

    }
    public class ValidateColumnHelper
    {
        /// <summary>
        /// 字段名 
        /// </summary>
        public string ColName { get; set; }

        /// <summary>
        /// 字段描述
        /// </summary>
        public string Dis { get; set; }

        /// <summary>
        /// 在某表中必须不能存在
        /// </summary>
        public string MustNoExists { get; set; }

        /// <summary>
        /// 在某表中必须不能存在的信息提示 
        /// </summary>
        public string MustNoExistsMessage { get; set; }

        /// <summary>
        /// 在某表中必须存在
        /// </summary>
        public string MustExists { get; set; }

        /// <summary>
        /// 在某表中必须存在的信息提示 
        /// </summary>
        public string MustExistsMessage { get; set; }

        /// <summary>
        /// 是否为拒绝为空 
        /// </summary>
        public bool IsNotNull { get; set; }

        /// <summary>
        /// 不能为空的的提示
        /// </summary>
        public string IsNotNullMessage { get; set; }

        /// <summary>
        /// 正则表达式 
        /// </summary>
        public string Regular { get; set; }

        /// <summary>
        /// 正则匹配错误信息
        /// </summary>
        public string RegularErrorMessage { get; set; }
    }
}
