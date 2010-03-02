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

using com.Omei.BLL.Admin;
using com.Omei.DLL;

public partial class MenuEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadMenu();
        }
    }

    #region LoadMenu
    private void LoadMenu()
    {
        tvMenu.Nodes.Clear();

        AdminMenuBiz mbiz = new AdminMenuBiz();
        ActionAuthorization biz = new ActionAuthorization();
        DS_Menu.MenuItemDataTable dt = mbiz.GetMenuItems(true);
        DS_Authorization.AuthActionDataTable actionTable = biz.GetActions();

        LoadSubMenu(tvMenu.Nodes, 0, dt, actionTable);
    }
    private void LoadSubMenu(TreeNodeCollection pnode, int parentID,
        DS_Menu.MenuItemDataTable menuTable,
        DS_Authorization.AuthActionDataTable actionTable)
    {
        DataRow[] rows = menuTable.Select("parentID=" + parentID.ToString(), "menuOrder");
        foreach (DS_Menu.MenuItemRow row in rows)
        {
            string title = row.title;
            if (row.status < 1)
                title = "<del>" + title + "</del>";
            TreeNode node = new TreeNode(title, "m" + row.menuID.ToString());
            if (row.menuType == 10)
                node.ImageUrl = "~/Images/res/blog.gif";
            else
                node.ImageUrl = "~/Images/res/WebCmd.gif";
            pnode.Add(node);
            LoadSubMenu(node.ChildNodes, row.menuID, menuTable, actionTable);
        }
        LoadActions(pnode, parentID, actionTable);
    }
    private void LoadActions(TreeNodeCollection pnode, int menuID, DS_Authorization.AuthActionDataTable actionTable)
    {
        DataRow[] rows = actionTable.Select("menuID=" + menuID.ToString(), "showOrder");
        foreach (DS_Authorization.AuthActionRow row in rows)
        {
            TreeNode node = new TreeNode(row.description, "a" + row.actionID.ToString());
            node.ImageUrl = "~/Images/res/members.gif";
            pnode.Add(node);
        }
    }
    #endregion

    protected void tvMenu_SelectedNodeChanged(object sender, EventArgs e)
    {
        TreeNode node = tvMenu.SelectedNode;
        if (node != null)
        {
            if (node.Value.StartsWith("m"))
            {
                int menuID = int.Parse(node.Value.Substring(1));
                MenuItemEditCtl1.MenuID = menuID;
                MenuItemEditCtl1.Visible = true;
                ActionEditCtl1.Visible = false;
            }
            else
            {
                int actionID = int.Parse(node.Value.Substring(1));
                ActionEditCtl1.ActionID = actionID;
                ActionEditCtl1.Visible = true;
                MenuItemEditCtl1.Visible = false;
            }
        }
    }
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        LoadMenu();
    }

    protected void OnChanged(object sender, EventArgs e)
    {
        string path = null;
        if (tvMenu.SelectedNode != null)
        {
            path = tvMenu.SelectedNode.ValuePath;
        }
        LoadMenu();

        if (path != null)
        {
            TreeNode node = tvMenu.FindNode(path);
            if (node != null)
            {
                while (node.Parent != null)
                {
                    node = node.Parent;
                    node.Expand();
                }
            }
        }
    }
    protected void btnReload_Click(object sender, EventArgs e)
    {
        Master.RebuildSiteMap();
    }
}
