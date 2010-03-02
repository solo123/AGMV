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

public partial class TourDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["add"] != null)
            {
                fvTourDetail.ChangeMode(FormViewMode.Insert);
            }
            else
            {
                int id = PageTools.GetSavedId("tourID", Request.QueryString["id"]);
                if (Request.QueryString["id"] == null && id > 0)
                    Response.Redirect("TourDetail.aspx?id=" + id.ToString());
            }
            
        }
    }

    protected void TourDetailDataset_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
    {
        if (e.ReturnValue != null && e.ReturnValue is int)
        {
            Response.Redirect("TourDetail.aspx?id=" + e.ReturnValue.ToString());
        }
    }
}
