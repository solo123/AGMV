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

using com.Omei.OmeiDataSet;
using com.Omei.OmeiAdminData;

public partial class LeftMenu : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginUserInfo"] != null)
        {
            D_LoginUserInfo ui = Session["LoginUserInfo"] as D_LoginUserInfo;
            SubMenuDataset.SelectParameters["userRole"].DefaultValue = ui.roleIds;
            SubMenuDataset.SelectParameters["userPos"].DefaultValue = ui.positionIds;
        }

    }

}
