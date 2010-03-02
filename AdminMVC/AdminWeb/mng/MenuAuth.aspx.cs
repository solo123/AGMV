using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Text;
using com.Omei.BLL.Admin;
using com.Omei.DLL;

public partial class MenuAuth : System.Web.UI.Page
{
    private DS_Menu.MenuItemDataTable menuTable;
    private DS_Authorization.AuthActionDataTable actionTable;
    private DS_Authorization.RoleActionDataTable roleAuthTable;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //LoadTextMenu();
        }

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        LoadTextMenu();
    }

    #region LoadTextMenu
    private void LoadTextMenu()
    {
        txtMenu.Text = "";
        int role = PageTools.ParseInt(lstRole.SelectedValue);
        if (role<0) return;

        AdminMenuBiz mbiz = new AdminMenuBiz();
        ActionAuthorization biz = new ActionAuthorization();
        menuTable = mbiz.GetMenuItems(false);
        actionTable = biz.GetActions();
        roleAuthTable = biz.GetRoleAuth(role);

        txtMenu.Text = "<ul>" + LoadSubMenu(0) + "</ul>" +
            "<br />Other Authorizations:<br />" +
            LoadActions(0);

        ClientScript.RegisterArrayDeclaration("Results", "'" + hdMenuSelected.ClientID + "'");
        ClientScript.RegisterArrayDeclaration("Results", "'" + hdActionSelected.ClientID + "'");
    }
    private string LoadSubMenu(int parentID)
    {
        StringBuilder sb = new StringBuilder();
        DataRow[] rows = menuTable.Select("parentID=" + parentID.ToString(), "menuOrder");
        foreach (DS_Menu.MenuItemRow row in rows)
        {
            DataRow[] rr = roleAuthTable.Select("menuID=" + row.menuID.ToString());
            string id = "menu_" + row.menuID.ToString();
            sb.Append("<li style='list-style-type: none;'>");
            if (row.menuType == 10)
                sb.Append("<img src='Images/res/blog.gif'/>");
            else
                sb.Append("<img src='Images/res/WebCmd.gif' />");
            sb.Append("&nbsp;<input type=checkbox id='");
            sb.Append(id);
            sb.Append("' ");
            if (rr != null && rr.Length > 0) sb.Append("checked");
            sb.Append(" /><label for='");
            sb.Append(id);
            sb.Append("'>");
            sb.Append(row.title);
            sb.Append("</label>");

            ClientScript.RegisterArrayDeclaration("ChkMenus", "'" + row.menuID + "'");

            sb.Append(LoadActions(row.menuID));

            string subNode = LoadSubMenu(row.menuID);
            if (subNode != string.Empty)
            {
                sb.Append("<ul>");
                sb.Append(subNode);
                sb.Append("</ul>");
            }
            sb.Append("</li>");
        }

        //sb.Append(LoadActions(parentID, actionTable));
        return sb.ToString();
    }
    private string LoadActions(int menuID)
    {
        StringBuilder sb = new StringBuilder();
        DataRow[] rows = actionTable.Select("menuID=" + menuID.ToString(),"showOrder");
        foreach (DS_Authorization.AuthActionRow row in rows)
        {
            DataRow[] rr = roleAuthTable.Select("actionID=" + row.actionID.ToString());
            string id = "action_" + row.actionID.ToString();
            sb.Append("<input type=checkbox id='");
            sb.Append(id);
            sb.Append("' ");
            if (rr != null && rr.Length > 0) sb.Append("checked");
            sb.Append(" /><label for='");
            sb.Append(id);
            sb.Append("'>");
            sb.Append(row.description);
            sb.Append("</label> &nbsp;");

            ClientScript.RegisterArrayDeclaration("ChkActions", "'" + row.actionID + "'");
        }
        if (sb.Length > 0)
        {
            sb.Insert(0, "&nbsp;--&nbsp;<img src='Images/res/members.gif'>&nbsp;");
        }
        return sb.ToString();
    }
    #endregion

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string menuIDs = hdMenuSelected.Value;
        string actionIDs = hdActionSelected.Value;

        ActionAuthorization biz = new ActionAuthorization();

        if (menuIDs.Length > 1) menuIDs = menuIDs.Substring(0, menuIDs.Length - 1);
        if (actionIDs.Length > 1) actionIDs = actionIDs.Substring(0, actionIDs.Length - 1);

        int roleID = int.Parse(lstRole.SelectedValue);
        biz.DelRoleAuthNotIn(roleID, null, menuIDs);
        biz.DelRoleAuthNotIn(roleID, actionIDs, null);

        string[] menus = menuIDs.Split(',');
        if (menus != null && menus.Length > 0)
        {
            for (int i = 0; i < menus.Length; i++)
            {
                biz.AddRoleAuth(roleID, 0, PageTools.ParseInt(menus[i]));
            }
        }

        string[] actions = actionIDs.Split(',');
        if (actions != null && actions.Length > 0)
        {
            for (int i = 0; i < actions.Length; i++)
            {
                biz.AddRoleAuth(roleID, PageTools.ParseInt(actions[i]), 0);
            }
        }

    }
}
