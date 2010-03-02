using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using OmeiWebModel;

namespace OmeiMVC.Controllers
{
    public class AirlineController : Controller
    {
        public ActionResult Index()
        {
            OmeiTravelEntities db = new OmeiTravelEntities();
            return View(db.FlightSet.Select(f=>f.status>0).ToList());
        }

    }
}
