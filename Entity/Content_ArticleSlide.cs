//------------------------------------------------------------------------------
// <auto-generated>
//    此代码是根据模板生成的。
//
//    手动更改此文件可能会导致应用程序中发生异常行为。
//    如果重新生成代码，则将覆盖对此文件的手动更改。
// </auto-generated>
//------------------------------------------------------------------------------

namespace Entity
{
    using System;
    using System.Collections.Generic;
    
    public partial class Content_ArticleSlide
    {
        public string SlideID { get; set; }
        public string ArticleID { get; set; }
        public string SlideFileName { get; set; }
        public string SlideImageUrl { get; set; }
        public string SlideTitle { get; set; }
        public string SlideFileSize { get; set; }
    
        public virtual Content_Article Content_Article { get; set; }
    }
}