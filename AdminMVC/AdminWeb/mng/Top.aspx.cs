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

using com.Omei.DLL;
using com.Omei.OmeiDataSet;
using com.Omei.DLL.DS_MenuTableAdapters;

public partial class Top : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginUserInfo"] == null)
            Response.Redirect("Login.aspx");

        D_LoginUserInfo ui = Session["LoginUserInfo"] as D_LoginUserInfo;
        MenuDataset.SelectParameters["userRole"].DefaultValue = ui.roleIds;
        MenuDataset.SelectParameters["userPos"].DefaultValue = ui.positionIds;

        if (!Page.IsPostBack)
        {
            D_LoginUserInfo loginUser = Session["LoginUserInfo"] as D_LoginUserInfo;
            txtUsername.Text = loginUser.username;
        }
    }
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        Session.Clear();
        Response.Redirect("Login.aspx");
    }

}
