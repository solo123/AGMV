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

public partial class AgentInvoices : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // add summary
        //GridViewHelper helper = new GridViewHelper(this.lstAgentOrders);
        //helper.RegisterSummary("agentReceivable", SummaryOperation.Sum);
        //helper.RegisterSummary("additionalDiscount", SummaryOperation.Sum);
        //helper.RegisterSummary("agentPaid", SummaryOperation.Sum);

        if (!Page.IsPostBack)
        {
            int agentID = PageTools.GetSavedId("AgentID", Request.QueryString["agent"]);
            if (agentID > 0)
            {
                InvoiceDataset.SelectParameters["agentID"].DefaultValue = agentID.ToString();
                lstInvoice.DataBind();
            }
        }
    }

    protected string AgentInvoicePrintUrl(object reportDate)
    {
        if (reportDate == null || reportDate is DBNull) return null;
        DateTime dt = (DateTime)reportDate;
        return "AgentInvoice.aspx?date=" + dt.ToShortDateString();
    }

    protected void lstInvoice_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row;
        if (row.RowType == DataControlRowType.DataRow)
        {
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
            row.Attributes.Add("onclick", "itemClick('AgentInvoice.aspx?id=" + DataBinder.Eval(row.DataItem, "invoiceID") + "')");
        }
    }
}
