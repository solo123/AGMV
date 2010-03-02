using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using OmeiWebModel;

namespace OmeiMVC.Controllers
{
    public class DestinationController : Controller
    {
        public ActionResult Index()
        {
            OmeiTravelEntities db = new OmeiTravelEntities();
            return View(db.DestinationSet.OrderBy(d=>d.DestinationName).ToList());
        }

        public ActionResult Detail(int id)
        {
            OmeiTravelEntities db = new OmeiTravelEntities();
            Destination dt = (from d in db.DestinationSet
                              where d.DestinationID == id
                              select d).FirstOrDefault();

            var relate = from td in db.TourDestinationSet
                         join d in db.TourSet on td.tourId equals d.TourID
                         where td.destinationId == id
                         select new { d.TourID, d.TourName };

            ViewData["relate"] = relate;
    
            return View(dt);
        }



    }
}
