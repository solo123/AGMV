using System.Text;
using System.Web.Mvc;
using com.Omei.BLL.Admin;
using com.Omei.DLL;

namespace AdminMVC.Controllers
{
    public class MenuController : Controller
    {
        private DS_Menu.MenuItemDataTable menuDt;

        public ActionResult MainMenu()
        {
            return View(MainMenuUl());
        }

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
            StringBuilder sb = new StringBuilder();
            foreach (DS_Menu.MenuItemRow row in menuDt.Select("parentID=" + parentID.ToString() + " and status=1", "menuorder"))
            {
                string sub = MenuItemToString(row.menuID);
                if (!string.IsNullOrEmpty(sub)) sub = "<ul>" + sub + "</ul>";

                sb.Append(string.Format("<li><a url='{0}'>{1}</a>{2}</li>", row.navigateUrl, row.title, sub));
            }
            return sb.ToString();
        }

    }
}
