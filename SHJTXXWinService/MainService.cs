using BizProcess.Interface;
using BizProcess.Service;
using OurHelper;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.Timers;

namespace WinService
{
    public partial class MainService : ServiceBase
    {
        public System.Timers.Timer aTimer = new System.Timers.Timer();//启动WCF 服务的计时器，以便可以安装启动调试
        public MainService()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            aTimer.Elapsed += new ElapsedEventHandler(OnTimer);
            aTimer.Interval = 10000; //5秒 后启动 wcf服务
            aTimer.Enabled = true;
        }
        /// <summary>
        /// 执行任务
        /// </summary>
        public void ExeTask()
        {
            FixedRateTimer OneTask = new FixedRateTimer(TimeSpan.FromSeconds(0), TimeSpan.FromSeconds(60), task =>
            {
                try
                {
                    //写要做的任务：

                    //推送流程提醒
                    //WorkFlow_TaskUsersService service = new WorkFlow_TaskUsersService();
                    //service.SendWorkFlow();
              
                }
                catch
                {

                }
            }, null, false);
            OneTask.Start();
        }
        private void OnTimer(object sender, ElapsedEventArgs e)
        {
            aTimer.Stop();//一次性创建服务 
            try
            {
                ExeTask();
            }
            catch (Exception ee)
            {
            }
        }
        protected override void OnStop()
        {
        }
    }
}
