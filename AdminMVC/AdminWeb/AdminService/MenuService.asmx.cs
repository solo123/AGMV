using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;

using System.Data;
using com.Omei.BLL.Admin;
using com.Omei.DLL;
using com.Omei.OmeiDataSet;

namespace AdminWeb.AdminService
{
    /// <summary>
    /// MenuService 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。
    [ScriptService]
    public class MenuService : System.Web.Services.WebService
    {

        [WebMethod(EnableSession=true)]
        [ScriptMethod]
        public string HelloWorld()
        {
            if (Session["LoginUserInfo"] == null) return "Hello, Please login.";

            D_LoginUserInfo ui = Session["LoginUserInfo"] as D_LoginUserInfo;
            return "Hello, " + ui.username;
        }

        private DS_Menu.MenuItemDataTable menuDt;

        [WebMethod(EnableSession=true)]
        [ScriptMethod]
        public string MainMenuUl()
        {
            if (Session["LoginUserInfo"] == null) 
                return "<ul id=jsddm class='sf-menu'><li><a href='default.aspx'>please login.</a></li></ul>";

            AdminMenuBiz mbiz = new AdminMenuBiz();
            menuDt = mbiz.GetMenuItems(false);

            return "<ul id=jsddm class='sf-menu'>" + MenuItemToString(90) + "</ul>";
        }
        private string MenuItemToString(int parentID)
        {
            string s = "";
            foreach (DS_Menu.MenuItemRow row in menuDt.Select("parentID="+ parentID.ToString() +" and status=1", "menuorder"))
            {
                string sub = MenuItemToString(row.menuID);
                if (!string.IsNullOrEmpty(sub)) sub = "<ul>" + sub + "</ul>";

                s += string.Format("<li><a url='{0}'>{1}</a>{2}</li>",row.navigateUrl, row.title, sub);
            }
            return s;
        }
    }
    
}
