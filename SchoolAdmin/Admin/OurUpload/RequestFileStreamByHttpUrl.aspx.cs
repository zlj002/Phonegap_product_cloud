using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OurHelper;
using System.IO;
using System.Text;

namespace OurUpload.OurUpload
{
    public partial class RequestFileStreamByHttpUrl : System.Web.UI.Page
    {
        //允许预览的扩展名
        string fileExts = ".DOCX|.DOC|.XLSX|.XLS|.PPTX|.PPT|.TXT";
        //存放临时文件的目录
        string relativeDir = "/Upload/Attachment/HtmlTemp/";

        //此临时文件夹需要后期处理删除的文件夹
        //string physicalDir = MapPath(relativeDir);
        //if (Directory.Exists(physicalDir))
        //{
        //    Directory.Delete(physicalDir, true);
        //} 
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                initJavascript();
            }


        }

        private void ToHtml()
        {
            //目标文件，远程Url以流形式返回或者本地文件
            string rawFileUrl = Request.QueryString["rawFileUrl"];
            //目标另存为文件的文件名,需要带上扩展名哦
            string rawFileName = Request.QueryString["rawFileName"];
            if (string.IsNullOrEmpty(rawFileUrl) || string.IsNullOrEmpty(rawFileName))
            {
                this.labInfo.Text = "需要提供目标文件的地址（参数名 rawFileUrl）和文件名称（参数名 rawFileName）才可以预览";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "OurPreview", "ViewWindow();$('#loading-mask').fadeOut();", true);
            }
            else
            {
                rawFileUrl = HttpUtility.UrlDecode(rawFileUrl);
                rawFileName = HttpUtility.UrlDecode(rawFileName);

                this.hfileName.InnerText = rawFileName;

                if (rawFileName.Split('.').Length < 2)
                {
                    this.labInfo.Text = "需要目标文件的完整文件名称（例如： test.doc）才可以预览";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "OurPreview", "ViewWindow();$('#loading-mask').fadeOut();", true);

                }

                //仅文件名
                string rawFileTemp = rawFileUrl.Substring(rawFileUrl.LastIndexOf('/') + 1);

                string fileName = rawFileTemp.Substring(0, rawFileTemp.LastIndexOf('.'));

                //扩展名(包含点)
                string extName = rawFileName.Substring(rawFileName.LastIndexOf('.'));
                if (fileExts.IndexOf(extName.ToUpper()) < 0)
                {

                    this.labInfo.Text = "此文件类型暂不支持预览";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "OurPreview", "ViewWindow();$('#loading-mask').fadeOut();", true);
                }
                try
                {

                    //当前地址栏域名
                    string host = HttpContext.Current.Request.Url.Host;
                    //当前地址栏端口
                    int port = HttpContext.Current.Request.Url.Port;
                    string currentUrl = host + ":" + port;
                    //如果目标地址和当前url地址相同则为， 本地文件，本地是直接文件地址，做html处理即可，否则 为远程文件
                    //远程文件需要服务器先从远程服务器down文件，然后再做html处理

                    if (rawFileUrl.IndexOf(currentUrl) > -1 || rawFileUrl.IndexOf("http://") < 0)
                    {//本地文件
                        //本地文件地址带文件和扩展名
                        string fileUrl = rawFileUrl.Substring(rawFileUrl.IndexOf(currentUrl) + 1);
                        //即将生成的html文件
                        string willHtml = relativeDir.TrimEnd('/') + fileUrl.Substring(0, fileUrl.LastIndexOf('.')) + ".html";
                        if (File.Exists(MapPath(willHtml)))//生成之前检查是否已经转换过
                        {
                            downloadBtn.NavigateUrl = rawFileUrl;
                            win.Attributes["src"] = willHtml;
                        }
                        else
                        {
                            string physicalDir = MapPath(relativeDir.TrimEnd('/') + fileUrl.Substring(0, fileUrl.LastIndexOf('/')));
                            if (!Directory.Exists(physicalDir))
                            {
                                Directory.CreateDirectory(physicalDir);
                            }
                            fileUrl = MapPath(fileUrl);
                            switch (extName.ToUpper())
                            {
                                case ".DOCX":
                                case ".DOC":
                                    ConvertToHtmlHelper.WordToHtml(fileUrl, physicalDir, fileName);
                                    break;
                                case ".XLSX":
                                case ".XLS":
                                    ConvertToHtmlHelper.ExcelToHtml(fileUrl, physicalDir, fileName);
                                    break;
                                case ".PPTX":
                                case ".PPT":
                                    ConvertToHtmlHelper.PPTToHtml(fileUrl, physicalDir, fileName);
                                    break;
                                case ".TXT":
                                    ConvertToHtmlHelper.TXTToHtml(fileUrl, physicalDir, fileName);
                                    break;

                                default: break;
                            }


                            downloadBtn.NavigateUrl = rawFileUrl;
                            win.Attributes["src"] = willHtml;
                        }

                    }
                    else//远程文件
                    {

                        //去除http前缀后的完整路径
                        string remotePathNoPre = rawFileUrl.Replace("http://", "").Replace(":", "/");
                        string willHtml = relativeDir.TrimEnd('/') + "/" + remotePathNoPre;
                        willHtml = willHtml.Replace(extName, ".html");
                        if (File.Exists(MapPath(willHtml)))//生成之前检查是否已经转换过
                        {
                            downloadBtn.NavigateUrl = rawFileUrl;
                            win.Attributes["src"] = willHtml;
                        }
                        else
                        {
                            string physicalDir = MapPath(relativeDir.TrimEnd('/') + "/" + remotePathNoPre.Substring(0, remotePathNoPre.LastIndexOf('/')));
                            if (!Directory.Exists(physicalDir))
                            {
                                Directory.CreateDirectory(physicalDir);
                            }
                            string willRawFileName = fileName + extName;

                            DownFile(rawFileUrl, physicalDir + "\\" + willRawFileName);
                            //如果需要转存html开始转存
                            switch (extName.ToUpper())
                            {
                                case ".DOCX":
                                case ".DOC":
                                    ConvertToHtmlHelper.WordToHtml(physicalDir + "\\" + willRawFileName, physicalDir, fileName);

                                    break;
                                case ".XLSX":
                                case ".XLS":
                                    ConvertToHtmlHelper.ExcelToHtml(physicalDir + "\\" + willRawFileName, physicalDir, fileName);
                                    break;
                                case ".PPTX":
                                case ".PPT":
                                    ConvertToHtmlHelper.PPTToHtml(physicalDir + "\\" + willRawFileName, physicalDir, fileName);
                                    break;
                                case ".TXT":
                                    ConvertToHtmlHelper.TXTToHtml(physicalDir + "\\" + willRawFileName, physicalDir, fileName);
                                    break;
                                default: break;
                            }
                            downloadBtn.NavigateUrl = rawFileUrl;
                            win.Attributes["src"] = willHtml;
                        }


                    }
                }
                catch (Exception e)
                {

                    this.labInfo.Text = "预览出错，错误信息" + e.Message;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "OurPreview", "ViewWindow();$('#loading-mask').fadeOut();", true);

                }
            }

        }

        /// <summary>   
        /// 下载文件   
        /// </summary>   
        /// <param name="URL">网址</param>   
        /// <param name="Filename">文件名</param>    
        public static void DownFile(string URL, string Filename)
        {
            System.Net.HttpWebRequest Myrq = (System.Net.HttpWebRequest)System.Net.HttpWebRequest.Create(URL); //从URL地址得到一个WEB请求   
            System.Net.HttpWebResponse myrp = (System.Net.HttpWebResponse)Myrq.GetResponse(); //从WEB请求得到WEB响应   
            long totalBytes = myrp.ContentLength; //从WEB响应得到总字节数    
            System.IO.Stream st = myrp.GetResponseStream(); //从WEB请求创建流（读）   
            System.IO.Stream so = new System.IO.FileStream(Filename, System.IO.FileMode.Create); //创建文件流（写）   
            long totalDownloadedByte = 0; //下载文件大小   
            byte[] by = new byte[1024];
            int osize = st.Read(by, 0, (int)by.Length); //读流   
            while (osize > 0)
            {
                totalDownloadedByte = osize + totalDownloadedByte; //更新文件大小   

                so.Write(by, 0, osize); //写流    
                osize = st.Read(by, 0, (int)by.Length); //读流   
            }
            so.Close(); //关闭流   
            st.Close(); //关闭流   
        }


        /// <summary>
        /// 页面加载中效果
        /// </summary>
        public void initJavascript()
        {
            string ua = HttpContext.Current.Request.UserAgent.ToLower();
            if (HttpContext.Current.Session["Ourpreviewfirst"] == null)
            {

                StringBuilder sb = new StringBuilder();
                sb.Append("<div id='loading-mask' style='position: absolute; top: 0px; left: 0px; width: 100%;height: 100%; background: #D2E0F2; z-index: 20000'>");
                sb.Append("<div id='pageloading' style='position: absolute; top: 50%; left: 50%; margin: -120px 0px 0px -120px;text-align: center; border: 2px solid #8DB2E3; width: 200px; height: 40px; font-size: 14px;padding: 10px; font-weight: bold; background: #fff; color: #15428B;'>");
                sb.Append("<img src='images/pageloading.gif' align='absmiddle' id='imgloading'/>");
                sb.Append("正在加载中,请稍候...");
                sb.Append("</div>");
                sb.Append("</div>");

                HttpContext.Current.Session["Ourpreviewfirst"] = "first";
                HttpContext.Current.Response.Write(sb.ToString() + "<script>document.getElementById('imgloading').onload=function(){location.replace('" + HttpContext.Current.Request.Url.ToString() + "');}</script>");
                HttpContext.Current.Response.Flush();
                HttpContext.Current.Response.End();
            }
            else
            {
                HttpContext.Current.Session["Ourpreviewfirst"] = null;

                ToHtml();
            }
        }
    }
}