using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using OmeiWebModel;

namespace OmeiMVC.Controllers
{
    public class ScheduleController : Controller
    {
        public ActionResult List(TourTypeEnum id)
        {
            byte tt = Convert.ToByte(id);
            DateTime startDate = DateTime.Now;
            OmeiTravelEntities db = new OmeiTravelEntities();
            var schedules = (from s in db.V_scheduleSet
                             where (tt==0 || s.TourType==tt) && s.startDate>=startDate
                             select s).Take(30);
            return View(schedules.ToList());
        }


    }
}
