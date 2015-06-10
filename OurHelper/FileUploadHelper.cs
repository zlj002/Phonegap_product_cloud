using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.IO;
using System.Web.Script.Serialization;

namespace OurHelper
{
    public class FileUploadHelper
    {
        /// <summary>
        /// 已废弃

        /// </summary>
        private string extensionLim = ".xls|.xlsx|.jpg|.gif|.bmp|.jpeg|.png|.rar|.zip|.doc|.docx|.txt";

        /// <summary>
        /// 允许的扩展名，默认值（注意，已废弃，默认只控制禁止上传的文件后缀）

        /// </summary>
        public string ExtensionLim
        {
            get { return extensionLim; }
            set { extensionLim = value; }
        }


        private int fileLengthLim = 400;//单位是M，400M

        /// <summary>
        /// 最大限制默认 默认是 100MB
        /// </summary>
        public int FileLengthLim
        {
            get { return fileLengthLim; }
            set { fileLengthLim = value; }
        }


        private string uploadDir = "~/upload/Attachment/" + DateTime.Now.Year.ToString() + "/" + DateTime.Now.Month.ToString();  //上传目录:/upload/yyyy/MM;

        /// <summary>
        /// 上传路径 默认上传目录:/upload/yyyy/MM;
        /// </summary>
        public string UploadDir
        {
            get { return uploadDir; }
            set { uploadDir = value; }
        }


        private int fileRenameMethod = 0;//文件重命名方法，0：使用原名，1：时间+三位随机数


        /// <summary>
        /// 新文件命名方式 文件重命名方法，0：使用原名，1：时间+三位随机数

        /// </summary>
        public int FileRenameMethod
        {
            get { return fileRenameMethod; }
            set { fileRenameMethod = value; }
        }




        private string forbiddenExtensionLim = ".asp|.aspx|.php|.aspx|.ashx|.jsp";
        /// <summary>
        /// 禁止上传文件的文件类型
        /// </summary>
        public string ForbiddenExtensionLim
        {
            get { return forbiddenExtensionLim; }
            set { forbiddenExtensionLim = value; }
        }


        private string fileGuid;
        /// <summary>
        /// 文件唯一编号
        /// </summary>
        public string FileGuid
        {
            get { return fileGuid; }
            set { fileGuid = value; }
        }
         
        /// <summary>
        /// 返回结果信息类 
        /// </summary>
        [Serializable]
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

        }
        public string SaveAs(HttpFileCollection files)
        {
            List<ResultMessage> resultMessage = new List<ResultMessage>();

            try
            {
                string[] allFilesGuid = FileGuid.Split(new char[]{','},StringSplitOptions.RemoveEmptyEntries);
                if (allFilesGuid.Length != files.Count) 
                {
                    throw new Exception("选择文件个数和唯一字符串个数不一致");
                }


                for (int k = 0; k < files.Count; k++)
                {

                    ResultMessage rm = new ResultMessage();
                    //接收上传文件 
                    HttpPostedFile htmlFile = files[k];
                    string originalFilePath = "";//上传文件的路径 
                    string originalFileName = "";//上传文件的文件名，不带扩展名
                    string fileExtension = "";//上传文件的扩展名
                    string fileName = "";//上传后的新文件名


                    originalFilePath = htmlFile.FileName;

                    if (string.IsNullOrEmpty(originalFilePath))
                    {
                        rm.UploadStatus = 0;
                        rm.ErrorMessage = "失败，文件名称为空";
                        resultMessage.Add(rm);
                        continue;
                    }

                    originalFileName = Path.GetFileNameWithoutExtension(originalFilePath);
                    fileExtension = Path.GetExtension(originalFilePath);
                    //if (extensionLim.IndexOf(fileExtension.ToLower()) < 0)
                    //{
                    //    rm.UploadStatus = 0;
                    //    rm.ErrorMessage = "不能上传该类型文件(" + originalFilePath + ")，您只能上传以下文件：" + extensionLim;
                    //    resultMessage.Add(rm);
                    //    continue;
                    //}
                    if (string.IsNullOrEmpty(fileExtension))
                    {
                        fileExtension = ".jpg";
                    }
                    if (forbiddenExtensionLim.IndexOf(fileExtension.ToLower()) >= 0)
                    {
                        rm.UploadStatus = 0;
                        rm.ErrorMessage = "不能上传该类型文件(" + fileExtension + ")，以下文件类型将被禁止：" + forbiddenExtensionLim;
                        resultMessage.Add(rm);
                        continue;
                    }

                    if ((htmlFile.ContentLength / 1024) / 1024 > fileLengthLim)
                    {
                        rm.UploadStatus = 0;
                        rm.ErrorMessage = "上传的文件(" + originalFilePath + ")大小为" + (htmlFile.ContentLength / 1024) / 1024 + "M,大于最大限制：" + fileLengthLim + "M";
                        resultMessage.Add(rm);
                        continue;

                    }
                    string saveDir = HttpContext.Current.Server.MapPath(uploadDir);
                    if (!Directory.Exists(saveDir))
                    {
                        Directory.CreateDirectory(saveDir);
                    }
                    if (fileRenameMethod == 0)//已原文件名存储,存在递加
                    {
                        //使用原文件名，如果文件名已存在，就在文件名后加序号 
                        fileName = originalFileName + fileExtension;
                        if (File.Exists(saveDir + @"\" + fileName))
                        {
                            int i = 1;
                            while (File.Exists(saveDir + @"\" + originalFileName + "_" + i.ToString() + fileExtension))
                            {
                                i++;
                            }
                            fileName = originalFileName + "_" + i.ToString() + fileExtension;
                        }
                    }
                    else if (fileRenameMethod == 1)//当前时间毫秒数+3位随机数
                    {
                        //使用时间+随机数重命名文件
                        string strDateTime = DateTime.Now.ToString("yyMMddhhmmssfff");//取得时间字符串

                        Random ran = new Random();
                        string strRan = Convert.ToString(ran.Next(100, 999));//生成三位随机数

                        fileName = strDateTime + strRan + fileExtension;


                    }
                    string savePath = saveDir + @"\" + fileName;
                    htmlFile.SaveAs(saveDir + @"\" + fileName);

                    if (uploadDir.Substring(0, 1) == "~")
                    {
                        uploadDir = uploadDir.Substring(1, uploadDir.Length - 1);
                    }

                    //try//如果未安装office，或者权限未分配，应捕获
                    //{
                    //如果需要转存html开始转存
                    switch (fileExtension.ToUpper())
                    {
                        case ".DOCX":
                        case ".DOC":
                            rm.HtmlFilePath = "/OurUpload/RequestFileStreamByHttpUrl.aspx?rawFileUrl=" + HttpUtility.UrlEncode(uploadDir.TrimEnd('/') + "/" + fileName) + "&rawFileName=" + HttpUtility.UrlEncode(fileName);
                            break;
                        case ".XLSX":
                        case ".XLS":
                            rm.HtmlFilePath = "/OurUpload/RequestFileStreamByHttpUrl.aspx?rawFileUrl=" + HttpUtility.UrlEncode(uploadDir.TrimEnd('/') + "/" + fileName) + "&rawFileName=" + HttpUtility.UrlEncode(fileName);
                            break;
                        case ".PPTX":
                        case ".PPT":
                            rm.HtmlFilePath = "/OurUpload/RequestFileStreamByHttpUrl.aspx?rawFileUrl=" + HttpUtility.UrlEncode(uploadDir.TrimEnd('/') + "/" + fileName) + "&rawFileName=" + HttpUtility.UrlEncode(fileName);
                            break;
                        case ".TXT":
                            rm.HtmlFilePath = "/OurUpload/RequestFileStreamByHttpUrl.aspx?rawFileUrl=" + HttpUtility.UrlEncode(uploadDir.TrimEnd('/') + "/" + fileName) + "&rawFileName=" + HttpUtility.UrlEncode(fileName);
                            break;
                        default: break;
                    }
                    //}
                    //catch (Exception e)
                    //{

                    //}


                    string filePath = uploadDir.TrimEnd('/') + "/" + fileName; //上传之后的文件的 路径（网站路径根目录开始，绝不返给回客户物理路径）

                    rm.UploadStatus = 1;
                    rm.FilePath = filePath;
                    rm.NewFileName = fileName;
                    rm.FileSize = Convert.ToDecimal((Convert.ToDecimal(htmlFile.ContentLength) / 1024).ToString("f2"));
                    rm.FileExtension = fileExtension.ToUpper();
                    //rm.FileGuid = FileGuid;
                    rm.FileGuid=allFilesGuid[k];
                    resultMessage.Add(rm);
                }
            }
            catch (Exception e)
            {
                ResultMessage rm = new ResultMessage();
                rm.UploadStatus = 0;
                rm.ErrorMessage = "捕捉到错误" + e.Message;
                resultMessage.Add(rm);
            }
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(resultMessage);

        }
    }
}
