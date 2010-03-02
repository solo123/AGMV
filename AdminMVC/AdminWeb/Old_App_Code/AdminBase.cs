using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using com.Omei.OmeiDataSet;

/// <summary>
/// Summary description for AdminBase
/// </summary>


public class AdminBase : System.Web.UI.Page
{
    public AdminBase()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    protected void Page_PreInit(object sender, EventArgs e)
    {
        //if (Session["UserName"] == null && User.Identity.IsAuthenticated)
        //{
        //    Session["UserName"] = User.Identity.Name;
        //}
        //Page.Theme = "AdminThemes";

    }

    protected void Page_Error(object sender, EventArgs e)
    {
        if (!Request.IsLocal)
        {
            D_PageError pe = new D_PageError();
            pe.errorDetail = Server.GetLastError().ToString();
            pe.webPage = Request.Url.ToString();
            Session["CurrentError"] = pe;
            Server.ClearError();
            Response.Redirect("ApplicationError.aspx");
        }
    }


}

