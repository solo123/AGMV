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

public partial class AgentInvoiceSum : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GridViewHelper helper = new GridViewHelper(this.lstInvoice);
        helper.RegisterSummary("amount", SummaryOperation.Sum);
        helper.RegisterSummary("commission", SummaryOperation.Sum);
        helper.RegisterSummary("nettotal", SummaryOperation.Sum);
        helper.RegisterSummary("payAmount", SummaryOperation.Sum);
        helper.RegisterSummary("balance", SummaryOperation.Sum);
        helper.GeneralSummary += new FooterEvent(helper_footerEvent);
    }

    protected void lstInvoice_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row;
        if (row.RowType == DataControlRowType.DataRow)
        {
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
            row.Attributes.Add("onclick", "itemClick('AgentOrders.aspx?agent=" + DataBinder.Eval(row.DataItem, "agentID") + "')");
        }
    }

    protected void helper_footerEvent(GridViewRow row)
    {
        row.Cells[0].Text = "Total:";
        row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
        row.CssClass = "pageSummary";
    }
}
