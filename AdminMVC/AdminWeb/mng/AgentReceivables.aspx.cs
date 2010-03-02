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

public partial class AgentReceivables : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GridViewHelper helper = new GridViewHelper(this.lstAgentOrders);
        helper.RegisterSummary("agentReceivable", SummaryOperation.Sum);
        helper.RegisterSummary("additionalDiscount", SummaryOperation.Sum);
        helper.RegisterSummary("agentPaid", SummaryOperation.Sum);
    }
    protected void lstAgentOrders_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row;
        if (row.RowType == DataControlRowType.DataRow)
        {
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
            row.Attributes.Add("onclick", "itemClick('AgentOrders.aspx?agent=" + DataBinder.Eval(row.DataItem, "agentID") + "')");
        }

    }

    protected void btnGo_Click(object sender, EventArgs e)
    {
        if (txtAgentID.Text.Trim() == "")
            txtAgentID.Focus();
        else
            Response.Redirect("AgentOrderReport.aspx?agent=" + txtAgentID.Text);
    }
}
