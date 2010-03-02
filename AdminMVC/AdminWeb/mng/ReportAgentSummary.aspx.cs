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

public partial class ReportAgentSummary : System.Web.UI.Page
{
    decimal _receviable = 0, _discount = 0, _paid = 0;
    decimal _totRecevibale = 0, _totDiscount = 0, _totPaid = 0;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void lstAgentSummary_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row;
        if (row.RowType == DataControlRowType.DataRow)
        {
            _receviable = (decimal)DataBinder.Eval(row.DataItem, "agentReceivable");
            _discount = (decimal)DataBinder.Eval(row.DataItem, "additionalDiscount");
            _paid = (decimal)DataBinder.Eval(row.DataItem, "agentPaid");

            decimal ar = _receviable - _discount;
            decimal bl = ar - _paid;

            Label lbAr = row.FindControl("lbActualReceivable") as Label;
            Label lbBl = row.FindControl("lbBalance") as Label;

            lbAr.Text = ar.ToString("N2");
            lbBl.Text = bl.ToString("N2");

            _totRecevibale += _receviable;
            _totDiscount += _discount;
            _totPaid += _paid;
        }
        else if (row.RowType == DataControlRowType.Footer)
        {
            Label lbRe = row.FindControl("lbTotReceivable") as Label;
            Label lbDi = row.FindControl("lbTotDiscount") as Label;
            Label lbAr = row.FindControl("lbTotActualReceivable") as Label;
            Label lbPa = row.FindControl("lbTotPaid") as Label;
            Label lbBl = row.FindControl("lbTotBalance") as Label;
            Label lbPr = row.FindControl("lbPrompt") as Label;

            decimal ar = _totRecevibale - _totDiscount;
            decimal bl = ar - _totPaid;

            lbRe.Text = _totRecevibale.ToString("N2");
            lbDi.Text = _totDiscount.ToString("N2");
            lbAr.Text = ar.ToString("N2");
            lbPa.Text = _totPaid.ToString("N2");
            lbBl.Text = bl.ToString("N2");
            lbPr.Text = "<b>Total</b>";
        }
    }
}
