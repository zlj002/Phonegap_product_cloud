using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OurHelper;
using BizProcess.Interface;
using BizProcess.Service;
using Entity;
using System.Web.Script.Serialization;
using System.IO;
using System.Security.Permissions;
using System.Data;
using System.Data.OleDb;
using System.Text;
using System.Collections;
using System.Xml;
using Newtonsoft.Json;
using Aliyun.OpenServices.OpenStorageService;
using BizProcess.Common.Aliyun;

namespace OurUpload.Upload
{
    public partial class SaveByUploadFileData : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string m_FileType = Request.QueryString["FT"];
            if (!string.IsNullOrEmpty(m_FileType))
            {
                UploadExcle();
            }
            else
            {
                UploadFiles();
            }

        }
        /// <summary>
        /// 上传一般文件
        /// </summary>
        protected void UploadFiles()
        {

            /***********************建议此段代码请了解源码后修改*****************************/
            FileUploadHelper fuHelper = new FileUploadHelper();

            //上传目录
            object uploadDir = Request.QueryString["uploadDir"];
            if (uploadDir != null && !string.IsNullOrEmpty(uploadDir.ToString()))
            {
                fuHelper.UploadDir = uploadDir.ToString();
            }

            //文件大小限制
            object fileLengthLim = Request.QueryString["fileLengthLim"];
            if (fileLengthLim != null && !string.IsNullOrEmpty(fileLengthLim.ToString()))
            {
                fuHelper.FileLengthLim = Convert.ToInt32(fileLengthLim.ToString());
            }
            //禁止的后缀名,最新添加
            object forbiddenExtensionLim = Request.QueryString["forbiddenExtensionLim"];
            if (forbiddenExtensionLim != null && !string.IsNullOrEmpty(forbiddenExtensionLim.ToString()))
            {
                fuHelper.ForbiddenExtensionLim = forbiddenExtensionLim.ToString();
            }
            object fileGuid = Request.QueryString["fileGuid"];
            if (fileGuid != null && !string.IsNullOrEmpty(fileGuid.ToString()))
            {
                fuHelper.FileGuid = fileGuid.ToString();
            }
            else
            {
                fuHelper.FileGuid = Guid.NewGuid().ToString();
            }
            HttpFileCollection files = Request.Files;

            object optionationType = Request.QueryString["optionationType"];
            if (optionationType != null && !string.IsNullOrEmpty(optionationType.ToString()))
            {
                object userNO = Request.QueryString["userNO"];
                if (optionationType.ToString().ToUpper() == "headerImage".ToUpper() && userNO != null && !string.IsNullOrEmpty(userNO.ToString()))
                {
                    fuHelper.FileRenameMethod = 1;
                }
            }
            string result = fuHelper.SaveAs(files);

            //上云
            List<ResultMessage> resultList = JsonConvert.DeserializeObject<List<ResultMessage>>(result);
            foreach (var item in resultList)
            {
                if (!string.IsNullOrEmpty(item.FilePath))
                {
                    //修改为上传至阿里云oss
                    ObjectMetadata meta = new ObjectMetadata();
                    meta.ContentType = "image/jpeg";
                    string key = "MobileCloud/SchoolAdmin/" + new PageBase().CurrentSchoolID + "/" + item.FilePath.TrimStart('/');
                    FileStream fsForWrite = new FileStream(System.Web.HttpContext.Current.Server.MapPath(item.FilePath), FileMode.Open);
                    string aliFilePath = OssHelper.FileToOss(key, fsForWrite, meta);
                    fsForWrite.Close();
                    fsForWrite.Dispose();

                    //删除服务器端
                    File.Delete(MapPath(item.FilePath));
                    item.FilePath = aliFilePath;
                    if (!string.IsNullOrEmpty(item.ImageThumbnailUrl))
                    {
                        key = "MobileCloud/SchoolAdmin/" + new PageBase().CurrentSchoolID + "/" + item.ImageThumbnailUrl.TrimStart('/');
                        fsForWrite = new FileStream(System.Web.HttpContext.Current.Server.MapPath(item.ImageThumbnailUrl), FileMode.Open);
                        string aliImageThumbnailUrl = OssHelper.FileToOss(key, fsForWrite, meta);
                        fsForWrite.Close();
                        fsForWrite.Dispose();

                        //删除服务器端
                        File.Delete(MapPath(item.ImageThumbnailUrl));
                        item.ImageThumbnailUrl = aliImageThumbnailUrl;
                    }
                }
            }
            result = JsonConvert.SerializeObject(resultList);
            Response.Write(result);
            Response.End();
            /***********************建议此段代码请了解源码后修改*****************************/
        }


        class ResultMessage
        {
            public string NewFileName { get; set; }//新文件名
            public string FilePath { get; set; }//上传之后，相对网站的路径信息
            public decimal FileSize { get; set; }//文件大小, 单位 KB 
            public int UploadStatus { get; set; }//上传状态 0--失败，1--成功

            public string ErrorMessage { get; set; }//失败时的错误信息

            public string HtmlFilePath { get; set; }//上传之后将可以在线预览的文件转存为html文件提供用户在线预览

            public string FileExtension { get; set; }//文件后缀

            public string FileGuid { get; set; }//文件唯一编号

            /// <summary>
            /// 图片缩略图地址
            /// </summary>
            public string ImageThumbnailUrl { get; set; }

        }

        /// <summary>
        /// 上传excel
        /// </summary>
        protected void UploadExcle()
        {
            string msg = string.Empty;
            string error = string.Empty;
            //接收上传文件
            HttpFileCollection files = Request.Files;
            HttpPostedFile httpPostedFile = files[0];
            if (files.Count > 0)
            {
                //上传文件的名字 
                string fileName = Path.GetFileName(httpPostedFile.FileName);

                string tempDir = "/Upload/Attachment/" + DateTime.Now.Year + "/" + DateTime.Now.Month + "/";
                if (!Directory.Exists(Server.MapPath(tempDir)))
                {
                    Directory.CreateDirectory(tempDir);
                }
                string tmpFileName = Server.MapPath(tempDir) + fileName;
                //new FileIOPermission(FileIOPermissionAccess.AllAccess, tmpFileName).Assert();
                //上传文件
                httpPostedFile.SaveAs(tmpFileName);

                try
                {

                    //提示信息
                    string message = string.Empty;
                    //excel的数据写入到数据库

                    message = SaveDataToDb(tmpFileName);
                    if (!String.IsNullOrEmpty(message))
                    {
                        msg = "导入失败!\r\n";
                        msg += message;
                        error = msg;
                    }
                    else
                    {
                        msg = "批量导入成功";
                    }
                }
                catch (OleDbException exp)
                {
                    msg = "导入失败";
                    error = string.Format("读取文件出错，请检查文件格式及内容，详细信息:{0}", exp.Message);
                }
                catch (Exception ex)
                {
                    msg = "导入失败";
                    error = ex.Message;
                    //error = "导入内容格式错误，请下载模重新填写数据导入！";
                }
                finally
                {
                }

            }
            if (files.Count > 0)
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                var result = new { error, msg };
                string res = serializer.Serialize(result);
                Response.Write(res);
                Response.End();
            }
        }


        /// <summary>
        /// 保存excel
        /// </summary>
        /// <param name="fullfilename"></param>
        /// <returns></returns>
        public string SaveDataToDb(string fullfilename)
        {
            HttpContext context = HttpContext.Current;

            string msg = "";

            DataTable dt = ReadExcel(fullfilename);
            if (dt != null && dt.Rows.Count > 0)
            {
                switch (Request.QueryString["FT"])
                {

                    case "Basic_TeacherInfo":
                        msg = SaveBasic_TeacherInfo(dt, context);
                        break;

                    default:
                        break;
                }
            }
            else
            {
                msg = "Excel文件中没有数据，请仔细检查文件数据格式后重新上传！";
            }

            return msg;

        }
        /// <summary>
        /// 读取excle
        /// </summary>
        /// <param name="xlspath"></param>
        /// <returns></returns>
        public System.Data.DataTable ReadExcel(string xlspath)
        {
            return ReadExcel(xlspath, "Sheet1", "*");
        }
        /// <summary>
        /// 读取excel[支持word2003/2007及以上版本]：完整物理路径，要读取的sheet名称，读取的字段(*)
        /// </summary>
        public System.Data.DataTable ReadExcel(string xlspath, string sheetname, string fields)
        {
            try
            {
                System.Data.DataTable dt = new System.Data.DataTable();
                string hz = System.IO.Path.GetExtension(xlspath);
                //excel 1997-2003
                string connectionString = "Provider=Microsoft.Jet.OleDb.4.0; Data Source=" + xlspath + "; Extended Properties='Excel 8.0; HDR=YES; IMEX=1';";// Extended Properties='Excel 8.0; HDR=YES; IMEX=1';
                if (hz == ".xlsx")//excel2007
                    connectionString = "Provider=Microsoft.ACE.OLEDB.12.0; Data Source=" + xlspath + "; Extended Properties='Excel 12.0; HDR=YES; IMEX=1';";// Extended Properties='Excel 8.0; HDR=YES; IMEX=1';

                using (OleDbConnection Connection = new OleDbConnection(connectionString))
                {
                    Connection.Open();

                    using (OleDbCommand command = new OleDbCommand())
                    {
                        command.Connection = Connection;
                        command.CommandText = "SELECT " + fields + " FROM [" + sheetname + "$]";
                        using (OleDbDataAdapter adapter = new OleDbDataAdapter())
                        {
                            adapter.SelectCommand = command;
                            adapter.Fill(dt);
                        }

                    }
                    Connection.Close();
                    Connection.Dispose();
                }
                File.Delete(xlspath);
                return dt;
            }
            catch (Exception e)
            {
                throw e;
            }

        }
        private string ExcelNotNullVal(DataTable dt, string[] NotNullFileds)
        {
            System.Text.StringBuilder error = new StringBuilder();
            try
            {

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    for (int j = 0; j < NotNullFileds.Length; j++)
                    {
                        if (dt.Rows[i][NotNullFileds[j]] == null)
                        {
                            error.Append("第[" + (i + 2) + "]行" + NotNullFileds[j] + "不存在此列\r\n");
                        }
                        else
                        {
                            string temp = dt.Rows[i][NotNullFileds[j]].ToString();
                            if (string.IsNullOrEmpty(temp))
                            {
                                error.Append("第[" + (i + 2) + "]行" + NotNullFileds[j] + "不能为空\r\n");
                            }
                            else if (temp.Length > 30)
                            {
                                error.Append("第[" + (i + 2) + "]行" + NotNullFileds[j] + "不得超过30字符\r\n");
                            }
                        }
                    }
                }
                if (dt.Rows.Count == 0)
                {
                    error.Append("Excel文件中不包含任何数据，请检查\r\n");
                }
            }
            catch (Exception excp)
            {
                error.Append(excp.Message + "\r\n");
            }
            return error.ToString();
        }
        private string[] GetNotNullFileds(HttpContext context)
        {
            System.Text.StringBuilder error = new StringBuilder();
            ArrayList list = new ArrayList();
            //读取xml获得列映射信息


            try
            {




                string xmlPath = context.Server.MapPath("TableMapping.config");
                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.Load(xmlPath);
                XmlNodeList xnl = xmlDoc.SelectSingleNode("TableMapping/" + context.Request.QueryString["FT"]).ChildNodes;
                foreach (XmlNode node in xnl)
                {
                    if (node.Attributes["IsNotNull"] != null && node.Attributes["IsNotNull"].Value.ToLower() == "true")
                    {
                        list.Add(node.Attributes["ExcelCol"].Value);
                    }
                }

            }
            catch (Exception)
            {

                throw;
            }
            string[] Fileds = (string[])list.ToArray(typeof(string));
            return Fileds;
        }
        private string ExcelDataTypeVal(DataTable dt, HttpContext context)
        {
            System.Text.StringBuilder error = new StringBuilder();
            Hashtable htCols = new Hashtable();
            //读取xml获得列映射信息

            string xmlPath = context.Server.MapPath("TableMapping.config");
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.Load(xmlPath);
            XmlNodeList xnl = xmlDoc.SelectSingleNode("TableMapping/" + context.Request.QueryString["FT"]).ChildNodes;
            foreach (XmlNode node in xnl)
            {
                htCols[node.Attributes["ExcelCol"].Value] = node.Attributes["DataType"].Value;
            }
            ArrayList list = new ArrayList();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    DataColumn dc = dt.Columns[j];
                    if (htCols.Contains(dc.ColumnName))
                    {
                        string DataType = htCols[dc.ColumnName].ToString();
                        switch (DataType.ToUpper())
                        {
                            case "STRING":
                                if (dt.Rows[i][j].ToString().GetType() != typeof(System.String) && dt.Rows[i][j].GetType() != typeof(System.DBNull))
                                {
                                    error.Append("第[" + (i + 2) + "]行数据[" + dc.ColumnName + "]为[" + dt.Rows[i][j] + "]的数据格式不正确，应为文本格式,请检查excel数据！\r\n");
                                }
                                break;
                            case "DATETIME":
                                DateTime dateresult;
                                if (!DateTime.TryParse(dt.Rows[i][j].ToString(), out dateresult) && dt.Rows[i][j].GetType() != typeof(System.DBNull))
                                {
                                    error.Append("第[" + (i + 2) + "]行数据[" + dc.ColumnName + "]为[" + dt.Rows[i][j] + "]的数据格式不正确,应为日期格式，请检查excel数据！\r\n");
                                }
                                break;
                            case "INT":
                                int intresult;
                                if (!int.TryParse(dt.Rows[i][j].ToString(), out intresult) && dt.Rows[i][j].GetType() != typeof(System.DBNull))
                                {
                                    error.Append("第[" + (i + 2) + "]行数据[" + dc.ColumnName + "]为[" + dt.Rows[i][j] + "]的数据格式不正确,应为数字格式，请检查excel数据！\r\n");
                                }
                                break;
                            case "DECIMAL":
                                decimal decimalresult;
                                if (!Decimal.TryParse(dt.Rows[i][j].ToString(), out decimalresult) && dt.Rows[i][j].GetType() != typeof(System.DBNull))
                                {
                                    error.Append("第[" + (i + 2) + "]行数据[" + dc.ColumnName + "]为[" + dt.Rows[i][j] + "]的数据格式不正确,应为数字格式，请检查excel数据！\r\n");
                                }
                                break;
                            case "BOOLEAN":
                                if ((dt.Rows[i][j].ToString() != "1" && dt.Rows[i][j].ToString() != "0") && dt.Rows[i][j].GetType() != typeof(System.DBNull))
                                {
                                    error.Append("第[" + (i + 2) + "]行数据[" + dc.ColumnName + "]为[" + dt.Rows[i][j] + "]的数据格式不正确,应为0或1格式，请检查excel数据！\r\n");
                                }
                                break;
                            default:
                                break;
                        }
                    }
                }
            }

            return error.ToString();
        }
        public string SaveBasic_TeacherInfo(DataTable dt, HttpContext context)
        {
            //对dt数据验证
            System.Text.StringBuilder error = new StringBuilder();
            //非空验证
            error.Append(ExcelNotNullVal(dt, GetNotNullFileds(context)));
            //数据类型验证
            error.Append(ExcelDataTypeVal(dt, context));
            //验证唯一性 
            List<Basic_TeacherInfo> list = new List<Basic_TeacherInfo>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var UserAccount = dt.Rows[i][0].ToString().Trim();
                var Name = dt.Rows[i][1].ToString().Trim();
                var MobileNumber = dt.Rows[i][2].ToString().Trim();

                var teacher = new Basic_TeacherInfo();
                teacher.SchoolID = new PageBase().CurrentSchoolID;
                teacher.Name = Name;
                teacher.EmployeeID = UserAccount;
                teacher.MobileNumber = MobileNumber;
                list.Add(teacher);
            }


            IBasic_TeacherManagerService teacherService = new Basic_TeacherManagerService();
            teacherService.ImportTeachers(list);


            return error.ToString();

        }
    }



}