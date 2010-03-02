using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using com.Omei.BLL.Admin;
using com.Omei.OmeiDataSet;

/// <summary>
/// Summary description for PageLogic
/// </summary>
public class PageLogic
{
    private static string Url_CommonError = "~/CommonError.html";

    public PageLogic()
    {
    }

    public static void CheckPageAuthorization(string actionName)
    {
        if (HttpContext.Current.Session["LoginUserInfo"] == null)
            HttpContext.Current.Response.Redirect(Url_CommonError);

        D_LoginUserInfo ui = HttpContext.Current.Session["LoginUserInfo"] as D_LoginUserInfo;
        if (ui == null || ui.userId <= 0)
            ShowError("Session is expired, please login again.", "Login.aspx");

        ActionAuthorization auth = new ActionAuthorization();
        bool r = auth.CheckPageAuthorization( HttpContext.Current.Session["LoginUserInfo"], HttpContext.Current.Request.RawUrl, actionName);
        if (!r)
        {
            ShowError("Permittion Denided.", "Login.aspx");
        }
    }
    public static D_LoginUserInfo GetCurrentUserLogin()
    {
        return HttpContext.Current.Session["LoginUserInfo"] as D_LoginUserInfo;
    }
    public static void CheckAuthorization(string actionName)
    {
        if (HttpContext.Current.Session["LoginUserInfo"] == null)
            HttpContext.Current.Response.Redirect(Url_CommonError);

        D_LoginUserInfo ui = HttpContext.Current.Session["LoginUserInfo"] as D_LoginUserInfo;
        if (ui == null || ui.userId <= 0)
            ShowError("Session is expired, please login again.", "Login.aspx");

        ActionAuthorization auth = new ActionAuthorization();
        bool r = auth.CheckAuthorization(ui,actionName);
        if (!r)
        {
            ShowError("Permittion Denided.","Login.aspx");
        }
    }

    public static int CurrentUserID
    {
        get
        {
            if (HttpContext.Current.Session["LoginUserInfo"] == null) return 0;
            D_LoginUserInfo ui = HttpContext.Current.Session["LoginUserInfo"] as D_LoginUserInfo;
            return ui.userId;
        }
    }

    public static bool CheckPageAuth(string pageName)
    {

        if (HttpContext.Current.Session["LoginUserInfo"] == null) return false;

        D_LoginUserInfo ui = HttpContext.Current.Session["LoginUserInfo"] as D_LoginUserInfo;
        if (ui == null || ui.userId <= 0) return false;

        ActionAuthorization auth = new ActionAuthorization();
        string pn = "ASP." + pageName.Replace('.', '_');
        return auth.GetPageAuthorization(ui, pn);
    }
    public static string GetPageAuthStyle(string pageName)
    {
        if (CheckPageAuth(pageName))
            return "style_enabled";
        else
            return "style_disabled";
    }

    public static bool CheckActionAuth(string actionName)
    {
        if (HttpContext.Current.Session["LoginUserInfo"] == null) return false;

        D_LoginUserInfo ui = HttpContext.Current.Session["LoginUserInfo"] as D_LoginUserInfo;
        if (ui == null || ui.userId <= 0) return false;

        ActionAuthorization auth = new ActionAuthorization();
        bool r = auth.CheckAuthorization(ui,actionName);
        return r;
    }
    public static string GetActionAuth(string actionName)
    {
        if (HttpContext.Current.Session["LoginUserInfo"] == null) return "false";

        D_LoginUserInfo ui = HttpContext.Current.Session["LoginUserInfo"] as D_LoginUserInfo;
        if (ui == null || ui.userId <= 0) return "false";

        ActionAuthorization auth = new ActionAuthorization();
        bool r = auth.CheckAuthorization(ui, actionName);
        return r.ToString();

    }

    public static bool OrderEditable(int orderId)
    {
        if (HttpContext.Current.Session["LoginUserInfo"] == null)
            return false;

        D_LoginUserInfo ui = HttpContext.Current.Session["LoginUserInfo"] as D_LoginUserInfo;
        if (ui == null || ui.userId < 0) return false;

        AdminOrderBiz biz = new AdminOrderBiz();
        return biz.OrderEditable(orderId, ui.positionIds);

    }

    public static void ShowError(string errMsg, string prevUrl)
    {
        HttpContext.Current.Session["ProcessError"] = errMsg;
        HttpContext.Current.Session["PrevNav"] = prevUrl;
        HttpContext.Current.Response.Redirect("ProcessError.aspx");
    }

}
