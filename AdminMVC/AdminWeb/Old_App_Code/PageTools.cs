using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Text;
using com.Omei.BLL.Admin;
using com.Omei.DLL;
using com.Omei.OmeiDataSet;

/// <summary>
/// PageTools 的摘要说明
/// </summary>
public class PageTools
{
    private static int menuItemCount;

    public PageTools()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }

    public static int GetSavedId(string DataType, string paraString)
    {
        string key = "Current_" + DataType;
        if (paraString != null && paraString != "")
        {
            int id = int.Parse(paraString);
            HttpContext.Current.Session[key] = id;
            return id;
        }

        if (HttpContext.Current.Session[key] == null || !(HttpContext.Current.Session[key] is int))
            return 0;

        return (int)HttpContext.Current.Session[key];
    }

    public static DateTime GetSavedDate(string DataType, string paraString)
    {
        string key = "Current_" + DataType;
        if (paraString != null && paraString != "")
        {
            DateTime dt = ParseDate(paraString);
            HttpContext.Current.Session[key] = dt;
            return dt;
        }

        if (HttpContext.Current.Session[key] == null || !(HttpContext.Current.Session[key] is DateTime))
            return DateTime.MinValue;

        return (DateTime)HttpContext.Current.Session[key];
    }

    #region LoadMainMenu
    public static void LoadMainMenu(Menu menu)
    {
        if (menu == null) return;

        com.Omei.OmeiDataSet.D_LoginUserInfo ui = HttpContext.Current.Session["LoginUserInfo"] as com.Omei.OmeiDataSet.D_LoginUserInfo;
        if (ui == null || ui.userId <= 0) return;

        AdminMenuBiz biz = new AdminMenuBiz();
        DS_Menu.MenuItemDataTable menuDt = biz.GetMenuItemsByRoles(ui.roleIds);

        menuItemCount = 0;
        AddMenuItems(menuDt, menu.Items, 90);

    }
    private static void AddMenuItems(DS_Menu.MenuItemDataTable menuTable, MenuItemCollection pnode, int nodeId)
    {
        if(menuTable==null || pnode==null || menuItemCount>500) return;
        
        DataRow[] rows = menuTable.Select("status=1 and parentId=" + nodeId.ToString(), "parentID, menuOrder");
        foreach (DS_Menu.MenuItemRow row in rows)
        {
            MenuItem item = new MenuItem();
            item.Text = row.title;
            item.Value = row.menuID.ToString();
            item.NavigateUrl = row.navigateUrl;
            pnode.Add(item);
            menuItemCount++;
            AddMenuItems(menuTable, item.ChildItems, row.menuID);
        }
    }

    public static string GetLoginUserInfo()
    {
        D_LoginUserInfo ui = HttpContext.Current.Session["LoginUserInfo"] as D_LoginUserInfo;
        if (ui == null) return "<a href='/adminweb/mng/Login.aspx'>Please login</a>";
        string s = "Welcome: " + ui.username + "&nbsp;|&nbsp;<a href='/adminweb/mng/Login.aspx?logout=1'>Logout</a>";
        return s;
    }
    #endregion

    #region Parse Int, Double, Decimal
    public static int ParseInt(string str)
    {
        if (str == null) return 0;
        str = System.Text.RegularExpressions.Regex.Replace(str, "[^0-9+-]", "").Trim();
        if (str == "") return 0;
        return int.Parse(str);
    }

    public static double ParseDouble(string str)
    {
        if (str == null) return 0d;
        str = System.Text.RegularExpressions.Regex.Replace(str, "[^0-9.+-]", "").Trim();
        if (str == "") return 0d;
        return double.Parse(str);
    }

    public static decimal ParseDecimal(string str)
    {
        if (str == null) return 0M;
        str = System.Text.RegularExpressions.Regex.Replace(str, "[^0-9.+-]", "").Trim();
        if (str == "") return 0M;
        return decimal.Parse(str);
    }
    public static DateTime ParseDate(string str)
    {
        if (str == null || str.Length < 8) return DateTime.MinValue;

        return DateTime.Parse(str);
    }
    #endregion


    public static void AddStyleSheet(HtmlHead header, string cssPath)
    {
        HtmlLink lnk = new HtmlLink();
        lnk.Href = cssPath;
        lnk.Attributes["text"] = "text/css";
        lnk.Attributes["rel"] = "stylesheet";

        header.Controls.Add(lnk);
    }
    


}
