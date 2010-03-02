using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for DayNights
/// </summary>
public class DayNights
{
    public DayNights()
    {
        //
        // TODO: Add constructor logic here
        //
    }

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
