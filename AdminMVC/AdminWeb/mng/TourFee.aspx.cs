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

public partial class TourFee : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["id"] == null)
            {
                int id = PageTools.GetSavedId("tourID", Request.QueryString["id"]);
                if (id > 0)
                    Response.Redirect("TourFee.aspx?id=" + id.ToString());
            }

            TourNameCtl1.TourID = PageTools.ParseInt(Request.QueryString["id"]);
            fvTourFee.ChangeMode(FormViewMode.Insert);
        }

    }
    protected void lstTourFee_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(lstTourFee.SelectedIndex>=0)
        {
            int tourFeeID = (int)lstTourFee.SelectedDataKey.Value;
            TourFeeDataset.SelectParameters["tourFeeID"].DefaultValue = tourFeeID.ToString();
            fvTourFee.DataBind();
            fvTourFee.ChangeMode(FormViewMode.ReadOnly);
        }
    }
    protected void fvTourFee_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        lstTourFee.DataBind();
    }
    protected void fvTourFee_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        lstTourFee.DataBind();
    }
    protected void fvTourFee_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        lstTourFee.DataBind();
    }
}
