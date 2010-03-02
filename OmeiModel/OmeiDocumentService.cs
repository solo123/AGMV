using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using OmeiEDM;
namespace com.Omei.OmeiModel
{
    public class OmeiDocumentService : OmeiServiceBase
    {
        private OmeiDocumentEntity _ent = new OmeiDocumentEntity();

        /// <summary>
        /// 获取Omei文档列表
        /// </summary>
        /// <returns></returns>
        public IEnumerable<EDM_OmeiDocument> GetDocumentList()
        {
            return _ent.EDM_OmeiDocumentSet.OrderBy(d=>d.docName).ToList();
        }

        /// <summary>
        /// 读取Omei文档详细内容
        /// </summary>
        /// <param name="documentName"></param>
        /// <returns></returns>
        public EDM_OmeiDocument GetDocumentByName(string documentName)
        {
            EDM_OmeiDocument doc =
                (from d in _ent.EDM_OmeiDocumentSet
                 where d.docName == documentName
                 select d).First();
            return doc;
        }

        /// <summary>
        /// 保存Omei文档
        /// </summary>
        /// <param name="document"></param>
        /// <returns></returns>
        public bool SaveDocument(EDM_OmeiDocument document)
        {
            if (document == null || string.IsNullOrEmpty(document.docName))
            {
                base.LastError = "保存时没有文档ID。";
                return false;
            }

            try
            {
                var doc = GetDocumentByName(document.docName);
                _ent.ApplyPropertyChanges(doc.EntityKey.EntitySetName, document);
                _ent.SaveChanges();
                return true;
            }
            catch (Exception exp)
            {
                base.LastError = exp.InnerException.Message;
                return false;
            }
        }

        /// <summary>
        /// 添加新文档
        /// </summary>
        /// <param name="document"></param>
        /// <returns></returns>
        public bool AddDocument(EDM_OmeiDocument document)
        {
            try
            {
                _ent.AddToEDM_OmeiDocumentSet(document);
                _ent.SaveChanges();
                return true;
            }
            catch (Exception exp)
            {
                base.LastError = exp.InnerException.Message;
                return false;
            }
        }


    }
}
