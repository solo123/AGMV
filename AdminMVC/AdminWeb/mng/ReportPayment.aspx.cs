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

public partial class ReportPayment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DateTime dt = PageTools.GetSavedDate("ReportDate", null);
            if (dt.Year < 2005) dt = DateTime.Now;

            dateFrom.DateValue = PageTools.GetSavedDate("ReportDate", dt.ToShortDateString());
            lstReport.DataBind();
        }

        GridViewHelper helper = new GridViewHelper(this.lstReport);
        helper.RegisterSummary("cash", SummaryOperation.Sum);
        helper.RegisterSummary("creditCard", SummaryOperation.Sum);
        helper.RegisterSummary("check", SummaryOperation.Sum);
        helper.RegisterSummary("agent", SummaryOperation.Sum);
    }
    protected void lstReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row;
        if (row.RowType == DataControlRowType.DataRow)
        {
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
            row.Attributes.Add("onclick", "itemClick('ReportPaymentDetail.aspx?id=" + DataBinder.Eval(row.DataItem, "empID") +  "')");
        }
    }
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        PageTools.GetSavedDate("ReportDate", dateFrom.DateValue.ToShortDateString());
        lstReport.DataBind();
    }
}
