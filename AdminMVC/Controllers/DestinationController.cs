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
    public class DestinationController : Controller
    {
        private DestinationService _svc = new DestinationService();

        //
        // GET: /Destination/

        public ActionResult Index()
        {
            return View(_svc.ListDestinations());
        }

        //
        // GET: /Destination/Details/5

        public ActionResult Details(int id)
        {
            return View(_svc.GetDestinationByID(id));
        }

        //
        // GET: /Destination/Create

        public ActionResult Create()
        {
            return View();
        } 

        //
        // POST: /Destination/Create

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Create(EDM_Destination destination)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Destination/Edit/5
 
        public ActionResult Edit(int id)
        {
            return View(_svc.GetDestinationByID(id));
        }

        //
        // POST: /Destination/Edit/5

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Edit(
            [Bind(Include = "DestinationName,Description,city,state,country,Status,DestinationName_cn,Description_cn")]
            EDM_Destination destination)
        {
            if (_svc.SaveDestinationDetail(destination))
            {
                return RedirectToAction("Index");
            }
            else
            {
                return View();
            }
        }
    }
}
