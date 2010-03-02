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

public partial class AgentOrders : System.Web.UI.Page
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

                AgentInfoCtl1.AgentID = agentID;
            }
            lnkInvoices.NavigateUrl = "AgentRecvInvoiceList.aspx?agent=" + agentID.ToString();
        }
    }

    private void helper_SummaryFooter(GridViewRow row)
    {
        row.Cells[0].Text = "Total:";
        row.CssClass = "pageSummary";
        row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
    } 

}
