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
/// Summary description for OmeiStatus
/// </summary>
public class OmeiStatus
{
    public OmeiStatus()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    #region Day and Night
    public static string DayAndNightText(object days, string lang)
    {
        if (days == null || days is DBNull) return string.Empty;

        int d = Convert.ToInt32(days);
        if (d < 1) return string.Empty;

        if (lang == "en")
        {
            if (d == 1)
                return "1 Day";
            else
                return d.ToString() + " Days" + (d - 1).ToString() + " Nights";
        }
        else
        {
            if (d == 1)
                return "一日游";
            else
                return d.ToString() + "天" + (d - 1).ToString() + "夜";
        }
        
    }
    #endregion

    #region CreditCardNumber
    public static string CreditCardNumberText(object creditCardNumber)
    {
        if (creditCardNumber == null) return string.Empty;
        string s = creditCardNumber.ToString();
        if (s.Length < 5) 
            return s;
        else
            return s.Substring(0, 4) + "-****-" + s.Substring(s.Length - 4);

    }
    #endregion

    #region OmeiStatus
    public static void ReloadStatus()
    {
        if (HttpContext.Current.Application["OmeiStatus"] == null)
            HttpContext.Current.Application["OmeiStatus"] = new com.Omei.BLL.Admin.OmeiStatus();

        com.Omei.BLL.Admin.OmeiStatus ost = HttpContext.Current.Application["OmeiStatus"] as com.Omei.BLL.Admin.OmeiStatus;
        ost.ReLoad();
    }
    public static string GetOmeiStatusText(string typeName, object val, string lang)
    {
        if (typeName == null || val == null || "" == typeName || val is DBNull)
            return null;

        if (HttpContext.Current.Application["OmeiStatus"] == null)
            HttpContext.Current.Application["OmeiStatus"] = new com.Omei.BLL.Admin.OmeiStatus();

        com.Omei.BLL.Admin.OmeiStatus ost = HttpContext.Current.Application["OmeiStatus"] as com.Omei.BLL.Admin.OmeiStatus;
        return ost.GetPrompt(typeName, val.ToString(), lang);
    }

    public static string GetOmeiStatusBackColor(string typeName, object val)
    {
        if (typeName == null || val == null || "" == typeName || val is DBNull)
            return null;

        if (HttpContext.Current.Application["OmeiStatus"] == null)
            HttpContext.Current.Application["OmeiStatus"] = new com.Omei.BLL.Admin.OmeiStatus();

        com.Omei.BLL.Admin.OmeiStatus ost = HttpContext.Current.Application["OmeiStatus"] as com.Omei.BLL.Admin.OmeiStatus;
        return ost.GetBackColor(typeName, val.ToString());
    }
    #endregion

    public static string GetLogRelatePage(int opType, int relateID)
    {
        string s = string.Empty;
        if (opType > 0 && relateID > 0)
        {
            switch(opType)
            {
                case 1:
                case 2:
                case 3:
                    s = "EmployeeEdit.aspx?id=" + relateID.ToString();
                    break;
                case 4:
                    s = "OrderDetail.aspx?id=" + relateID.ToString();
                    break;
                case 5:
                    s = "DestinationEdit.aspx?id=" + relateID.ToString();
                    break;
            }
        }
        return s;
    }


}
