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

public partial class ReportSales : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            dateFrom.DateValue = PageTools.GetSavedDate("FromDate", DateTime.Now.ToShortDateString());
            dateTo.DateValue = PageTools.GetSavedDate("ToDate", DateTime.Now.ToShortDateString());
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
            row.Attributes.Add("onclick", "itemClick('ReportSalesDetail.aspx?id=" + DataBinder.Eval(row.DataItem, "empID") +  "')");
        }
    }
    protected void btnDaily_Click(object sender, EventArgs e)
    {
        dateFrom.DateValue = PageTools.GetSavedDate("FromDate", DateTime.Now.ToShortDateString());
        dateTo.DateValue = PageTools.GetSavedDate("ToDate", DateTime.Now.ToShortDateString());
        lstReport.DataBind();
    }
    protected void btnMonthly_Click(object sender, EventArgs e)
    {
        DateTime dt = DateTime.Now;
        DateTime fromDt = new DateTime(dt.Year, dt.Month, 1);
        DateTime toDt = (new DateTime(dt.Year, dt.Month + 1, 1)).AddDays(-1);

        dateFrom.DateValue = PageTools.GetSavedDate("FromDate", fromDt.ToShortDateString());
        dateTo.DateValue = PageTools.GetSavedDate("ToDate", toDt.ToShortDateString());
    }
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        PageTools.GetSavedDate("FromDate", dateFrom.DateValue.ToShortDateString());
        PageTools.GetSavedDate("ToDate", dateTo.DateValue.ToShortDateString());
    }
}
