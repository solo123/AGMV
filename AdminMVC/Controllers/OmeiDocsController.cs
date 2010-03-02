using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;

using com.Omei.OmeiModel;
using OmeiEDM;

namespace AdminMVC.Controllers
{
    public class OmeiDocsController : Controller
    {
        private OmeiDocumentService _svc = new OmeiDocumentService();

        //
        // GET: /OmeiDocs/
        public ActionResult Index()
        {
            return View(_svc.GetDocumentList());
        }

        //
        // GET: /OmeiDocs/Create
        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /OmeiDocs/Create

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(EDM_OmeiDocument doc)
        {
            if (!ModelState.IsValid)
                return View();

            if (_svc.AddDocument(doc))
                return RedirectToAction("Index");
            else
            {
                ViewData["ErrorMessage"] = _svc.LastError;
                return View();
            }
        }


        //
        // GET: /OmeiDocs/Edit/5
        public ActionResult Edit(string docName)
        {
            return View(_svc.GetDocumentByName(docName));
        }

        //
        // POST: /OmeiDocs/Edit/5
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Edit(EDM_OmeiDocument document)
        {
            if (!ModelState.IsValid)
                return View();

            if (_svc.SaveDocument(document))
                return RedirectToAction("Index");
            else
            {
                ViewData["ErrorMessage"] = _svc.LastError;
                return View(document);
            }
        }
    }
}
