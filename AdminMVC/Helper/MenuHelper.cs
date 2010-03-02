using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using com.Omei.OmeiDataSet;
using com.Omei.BLL.Admin;
using com.Omei.DLL;
using System.Data;
using System.Web.UI.WebControls;
using System.Text;
using System.Web.Mvc;

namespace AdminMVC.Helper
{
    public static class MenuHelper
    {
        private static DS_Menu.MenuItemDataTable menuDt = null;

        public static string MenuUL(this HtmlHelper helper)
        {
            D_LoginUserInfo ui = HttpContext.Current.Session["LoginUserInfo"] as D_LoginUserInfo;
            if (ui == null || ui.userId <= 0) 
                return "<ul id=jsddm class='sf-menu'><li><a href='/home/login'>Please login.</a></li></ul>";

            AdminMenuBiz mbiz = new AdminMenuBiz();
            menuDt = mbiz.GetMenuItemsByRoles(ui.roleIds);

            return "<ul id=jsddm class='sf-menu'>" + MenuItemToString(90) + "</ul>";
        }
        private static string MenuItemToString(int parentID)
        {
            StringBuilder sb = new StringBuilder();
            foreach (DS_Menu.MenuItemRow row in menuDt.Select("parentID=" + parentID.ToString() + " and status=1", "menuOrder,menuID"))
            {
                string sub = MenuItemToString(row.menuID);
                if (!string.IsNullOrEmpty(sub)) sub = "<ul>" + sub + "</ul>";

                sb.Append(string.Format("<li><a href='{0}'>{1}</a>{2}</li>", row.navigateUrl, row.title, sub));
            }
            return sb.ToString();
        }


    }


}
