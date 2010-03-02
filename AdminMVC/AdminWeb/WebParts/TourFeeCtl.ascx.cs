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

public partial class WebParts_TourFeeCtl : System.Web.UI.UserControl
{
    private decimal _adult=0, _child=0;
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    #region ÊôÐÔ: TourID
    public int TourID
    {
        set
        {
            if (value > 0)
            {
                TourFeeListDataset.SelectParameters["tourID"].DefaultValue = value.ToString();
                lstFee.DataBind();
            }
        }
    }
    #endregion
    protected void lstFee_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRow row = ((DataRowView)e.Row.DataItem).Row;
            _adult += (decimal)row["feeAdult"];
            _child += (decimal)row["feeChild"];
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lbTotAdult = e.Row.FindControl("lbAdultTot") as Label;
            Label lbTotChild = e.Row.FindControl("lbChildTot") as Label;

            lbTotAdult.Text = _adult.ToString("N2");
            lbTotChild.Text = _child.ToString("N2");
        }
    }
}
