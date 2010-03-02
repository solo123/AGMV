using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using OmeiWebModel;
using System.Data.Common;
using System.Data;

namespace OmeiMVC.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            using (OmeiTravelEntities db = new OmeiTravelEntities())
            {
                ViewData["NavigateIndex"] = (int)0;
                try
                {
                    var sql = @"
SELECT VALUE d FROM OmeiTravelEntities.TypeRefSet AS d 
where d.listClass='WebSite' and d.listValue='Promotion'";
                    var query = db.CreateQuery<TypeRef>(sql);
                    if (query!=null && query.Count()>0)
                        ViewData["PromotionMessage"] = query.First().listTitle;
                }
                catch (EntitySqlException ex)
                {
                    ViewData["PromotionMessage"] = ex.ToString();
                }
            }
            return View();
        }

        public ActionResult About()
        {
            return View();
        }
    }
}
