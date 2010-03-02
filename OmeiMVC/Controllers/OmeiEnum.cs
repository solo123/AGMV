using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OmeiMVC.Controllers
{

    public enum TourTypeEnum
    {
        All = 0,
        Bus,Package, Cruise
    }

    public class NavigateHelper
    {
        public static string[] HeaderImage = {
            "topban_home.jpg",
            "topban_generic.jpg",
            "topban_bus.jpg",
            "topban_air.jpg",
            "topban_generic.jpg",
            "topban_air.jpg",
            "topban_contact.jpg",
            "topban_bus.jpg",
            "topban_about.jpg",
                                      };
        public static string GetHeaderImage(object index)
        {
            if (index != null)
            {
                return HeaderImage[(int)index];
            }
            return HeaderImage[0];
        }
    }
}
