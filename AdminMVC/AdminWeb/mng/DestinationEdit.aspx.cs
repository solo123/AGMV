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

public partial class DestinationEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["mode"] == "add")
            {
                fvDestination.ChangeMode(FormViewMode.Insert);
            }
        }
    }

    protected void DestinationDetailDataset_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
    {
        Response.Redirect("DestinationEdit.aspx?id=" + e.ReturnValue.ToString());
    }
}
