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

using System.Text;
using com.Omei.BLL.Admin;

public partial class AgentNewRecv : System.Web.UI.Page
{
    //private bool _haveNewOrder = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        // add summary
        GridViewHelper helper = new GridViewHelper(this.lstOrders);
        helper.RegisterSummary("actualAmount", SummaryOperation.Sum);
        helper.RegisterSummary("agentCmt", SummaryOperation.Sum);
        helper.RegisterSummary("agentCredit", SummaryOperation.Sum);
        helper.RegisterSummary("agentBillAmount", SummaryOperation.Sum);
        helper.RegisterSummary("balance", SummaryOperation.Sum);
        helper.GeneralSummary += new FooterEvent(helper_SummaryFooter);

        if (!Page.IsPostBack)
        {
            int agentID = PageTools.GetSavedId("AgentID", Request.QueryString["agent"]);
            if (agentID <= 0) Response.Redirect("AgentReceivables.aspx");
            else
            {
                OrdersDataset.SelectParameters["agentID"].DefaultValue = agentID.ToString();
                lstOrders.DataBind();

                AgentDataset.SelectParameters["agentID"].DefaultValue = agentID.ToString();
                fvAgent.DataBind();
            }
        }
    }

    private void helper_SummaryFooter(GridViewRow row)
    {
        row.Cells[0].Text = "Total:";
        row.CssClass = "pageSummary";
        row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
    }

    protected void btnCreateRecvInvoice_Click(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();
        // input array
        foreach (GridViewRow row in lstOrders.Rows)
        {
            CheckBox cb = row.FindControl("cbSele") as CheckBox;
            if (cb != null && cb.Checked)
            {
                sb.Append(cb.Text);
                sb.Append(',');
            }
        }
        if (sb.Length > 1) sb.Remove(sb.Length - 1, 1);

        int agentID = PageTools.GetSavedId("AgentID", null);
        AgentOrderBiz biz = new AgentOrderBiz();
        int r = biz.NewReceiveInvoice(PageLogic.CurrentUserID, agentID, sb.ToString());
        if (r == 0)
        {
            Response.Write(@"
<script type='text/javascript'>
alert('Create Receive Invoice ERROR! Please Check.');
location = 'AgentOrders.aspx';
</script>");
            Response.End();
        }
        else
            Response.Redirect("AgentRecvInvoice.aspx?recv=" + r.ToString());
    }
    protected void cbSelectAll_CheckedChanged(object sender, EventArgs e)
    {
        bool b = cbSelectAll.Checked;
        // input array
        foreach (GridViewRow row in lstOrders.Rows)
        {
            CheckBox cb = row.FindControl("cbSele") as CheckBox;
            if (cb != null) cb.Checked = b;
        }
    }
}
