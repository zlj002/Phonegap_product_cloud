using OurHelper;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration.Install;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using System.Xml;

namespace WinService
{
    [RunInstaller(true)]
    public partial class ProjectInstaller : System.Configuration.Install.Installer
    {
        String WinServiceName = "";
        String WinServiceDisplayName = "";
        String WinServiceDescription = "";

        public ProjectInstaller()
        {
            InitializeComponent();
            //设置配置信息
            InitConfig();
            this.AfterInstall += new InstallEventHandler(ProjectInstaller_Committed);
        }
        private void ProjectInstaller_Committed(object sender, InstallEventArgs e)
        {
            System.ServiceProcess.ServiceController controller = new System.ServiceProcess.ServiceController(WinServiceName); //参数为服务的名字
            controller.Start();
        }
        //设置配置信息
        private void InitConfig()
        {
            string strAssemblyFilePath = Assembly.GetExecutingAssembly().Location;
            string AppPath = Path.GetDirectoryName(strAssemblyFilePath);
            XmlNode node = XMLHelper.GetXmlNodeByXpath(AppPath + "\\Config\\Services.xml", "Services");


            if (node != null)
            {
                WinServiceName = node.Attributes["WinServiceName"] == null ? "" : node.Attributes["WinServiceName"].Value;
                WinServiceDisplayName = node.Attributes["WinServiceDisplayName"] == null ? "" : node.Attributes["WinServiceDisplayName"].Value;
                WinServiceDescription = node.Attributes["WinServiceDescription"] == null ? "" : node.Attributes["WinServiceDescription"].Value;

                if (!string.IsNullOrEmpty(WinServiceName))
                {//服务名称
                    this.serviceInstaller1.ServiceName = WinServiceName;
                }
                if (!string.IsNullOrEmpty(WinServiceDisplayName))
                {//显示名称
                    this.serviceInstaller1.DisplayName = WinServiceDisplayName;
                }
                if (!string.IsNullOrEmpty(WinServiceDescription))
                {//显示名称
                    this.serviceInstaller1.Description = WinServiceDescription;
                }

                this.serviceInstaller1.DelayedAutoStart = false;
            }
        }
    }
}
