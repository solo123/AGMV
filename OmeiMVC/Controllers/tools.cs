using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OmeiMVC.Controllers
{
    public class OmeiTools
    {
        public static string GetDayNightText(object days, string lang)
        {
            if (days == null) return "";

            int day = Convert.ToInt32(days);
            if (day <= 0) return "";

            if (lang == "cn")
            {
                if (day == 1) return "一日游";
                else
                {
                    int nights = day - 1;
                    return day.ToString() + "天" + nights.ToString() + "夜";
                }
            }
            else
            {
                if (day == 1) return " 1 Day";
                else
                {
                    int nights = day - 1;
                    return " " + day.ToString() + " Day " + nights.ToString() + " Night";
                }
            }
        }
    }
}
