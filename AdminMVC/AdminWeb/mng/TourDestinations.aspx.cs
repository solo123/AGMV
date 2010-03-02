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

public partial class TourDestinations : AdminList
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int tourID = PageTools.GetSavedId("tourID", Request.QueryString["id"]);
            if (tourID > 0 && Request.QueryString["id"] == null)
                Response.Redirect("TourDestinations.aspx?id=" + tourID.ToString());

            AdminTourBiz biz = new AdminTourBiz();
            DS_Tours.tourDetailDataTable dt = biz.GetTourDetail(tourID);

            if (tourID > 0 && dt.Rows.Count > 0)
            {
                DS_Tours.tourDetailRow row = dt.Rows[0] as DS_Tours.tourDetailRow;
                lbTourName.Text = "#" + row.TourID.ToString() + ":" + row.TourName + " / " + row.TourName_cn;
            }
            fvTourDayDest.ChangeMode(FormViewMode.Insert);
        }
    }

    protected void lstTourDest_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            GridViewRow row = e.Row;
            row.Attributes["OnClick"] = ClientScript.GetPostBackEventReference(lstTourDest, "Select$" + e.Row.RowIndex);
            row.Style["cursor"] = "hand";
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
        }
    }

    
    protected void lstTourDest_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (lstTourDest.SelectedIndex < 0)
        {
            fvTourDayDest.ChangeMode(FormViewMode.Insert);
        }
        else
        {
            fvTourDayDest.ChangeMode(FormViewMode.ReadOnly);
            TourDayDestDetailDataset.SelectParameters["tourDestId"].DefaultValue =
                lstTourDest.SelectedDataKey.Value.ToString();
        }
        fvTourDayDest.DataBind();
    }
    

    protected void fvTourDayDest_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        lstTourDest.SelectedIndex = -1;
        //fvTourDayDest.ChangeMode(FormViewMode.Insert);
        fvTourDayDest.DataBind();

        lstTourDest.DataBind();
    }

    protected void fvTourDayDest_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        lstTourDest.DataBind();
    }
    protected void fvTourDayDest_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        lstTourDest.DataBind();
    }

}
