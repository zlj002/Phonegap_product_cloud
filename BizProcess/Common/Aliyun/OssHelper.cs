using Aliyun.OpenServices.OpenStorageService;
using BizProcess.Interface;
using BizProcess.Service;
using Entity;
using Entity.CustomEntity;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BizProcess.Common.Aliyun
{
    /// <summary>
    /// author lorinzhang@163.com
    /// </summary>
    public class OssHelper
    {
        /// <summary>
        /// 本项目中文件上云
        /// </summary>
        /// <param name="fileName">文件名，可以带路径，存在则覆盖</param>
        /// <param name="imageContent">内容</param>
        /// <param name="meta">原数据描述</param>
        /// <returns></returns>
        public static string FileToOss(string fileName, Stream imageContent, ObjectMetadata meta)
        {
            try
            {
                //aliyun id
                var aliyunkeyid = string.Empty;
                ISys_ConfigService configService = new Sys_ConfigService();
                Sys_Config configEntity = configService.GetEntityByColNameAndColValue("ID", ConstantEntity.Aliyun.aliyunkeyid.ToString());
                if (configEntity != null)
                {
                    aliyunkeyid = configEntity.Value;
                }
                else
                {
                    throw new Exception("阿里云keyid未配置");
                }
                //aliyun secret
                var aliyunkeysecret = string.Empty;
                configEntity = configService.GetEntityByColNameAndColValue("ID", ConstantEntity.Aliyun.aliyunkeysecret.ToString());
                if (configEntity != null)
                {
                    aliyunkeysecret = configEntity.Value;
                }
                else
                {
                    throw new Exception("阿里云aliyunkeysecret未配置");
                }
                //aliyun bucketname
                var bucketname = string.Empty;
                configEntity = configService.GetEntityByColNameAndColValue("ID", ConstantEntity.Aliyun.bucketname.ToString());
                if (configEntity != null)
                {
                    bucketname = configEntity.Value;
                }
                else
                {
                    throw new Exception("阿里云bucketname未配置");
                }
                //图片域地址
                var imageDomain = string.Empty;
                configEntity = configService.GetEntityByColNameAndColValue("ID", ConstantEntity.Aliyun.imageDomain.ToString());
                if (configEntity != null)
                {
                    imageDomain = configEntity.Value;
                }
                else
                {
                    throw new Exception("图片域地址未配置");
                }
                OssClient client = new OssClient(aliyunkeyid, aliyunkeysecret);


                PutObjectResult putResult = client.PutObject(bucketname, fileName, imageContent, meta);
                var resulturl = imageDomain.TrimEnd('/') + "/" + fileName;
                 
                return resulturl;
            }
            catch (Exception ex)
            {
                throw new Exception("更新至阿里云出错" + ex.Message);
            }
        }
    }
}
