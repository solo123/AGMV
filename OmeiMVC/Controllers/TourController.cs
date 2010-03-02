using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using OmeiWebModel;

namespace OmeiMVC.Controllers
{
    public class TourController : Controller
    {
        public ActionResult List(TourTypeEnum id)
        {
            byte tt = Convert.ToByte(id);
            OmeiTravelEntities db = new OmeiTravelEntities();
            var tours = from t in db.TourSet
                        where t.status==1 && ( tt==0 || t.TourType == tt)
                        select t;
            return View(tours.OrderBy(t=>t.TourDay).ThenBy(t=>t.tourOrder).ToList());
        }

        public ActionResult Detail(int id)
        {
            OmeiTravelEntities db = new OmeiTravelEntities();
            Tour dt = (from d in db.TourSet
                              where d.TourID == id
                              select d).FirstOrDefault();

            var td = from d in db.v_tourDestinationSet
                     where d.tourId == id
                     orderby d.visitDate, d.visitOrder
                     select d; 
            ViewData["TourDestinations"] = td.ToList();

            return View(dt);
        }

        public ActionResult TourDestinations(int id)
        {
            OmeiTravelEntities db = new OmeiTravelEntities();
            var td = from d in db.v_tourDestinationSet
                      where d.tourId == id
                      orderby d.visitDate, d.visitOrder
                      select d;

            return View(td.ToList());
        }

    }
}
