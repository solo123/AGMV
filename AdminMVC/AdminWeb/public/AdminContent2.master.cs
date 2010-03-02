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

public partial class AdminContent2 : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //TODO: get page title by page name
        Page.Title = "O'Mei";

        if (!Page.IsPostBack)
        {
            PageTools.LoadMainMenu(menuMain);
            lbLoginUserInfo.Text = PageTools.GetLoginUserInfo();
        }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        PageLogic.CheckPageAuthorization(Page.ToString());
    }

    public void RebuildSiteMap()
    {
        DBSiteMapProvider pv = SiteMapPath1.Provider as DBSiteMapProvider;
        pv.reLoadSiteMap();
    }
}
