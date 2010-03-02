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
public partial class AgentRecvInvoice : System.Web.UI.Page
{
    private int numAdult = 0, numChild = 0;
    private decimal totFare = 0, totRec = 0, totPaid = 0, totBalance = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            AgentOrderBiz biz = new AgentOrderBiz();
            DataSet ds = biz.GetAgentRecvInvoice(PageTools.ParseInt(Request.QueryString["recv"]));
            if (ds != null)
            {
                AgentInfoCtl1.AgentID = PageTools.GetSavedId("agentID", ds.Tables[0].Rows[0]["agentID"].ToString());
                lnkPrint.NavigateUrl = "AgentRecvInvoice_prn.aspx?recv=" + Request.QueryString["recv"];
                lnkAgentOrders.NavigateUrl = "AgentOrders.aspx";
            }
        }

        // add summary
        GridViewHelper helper = new GridViewHelper(this.lstPayment);
        //helper.RegisterGroup("orderID", true, true);
        //helper.GroupHeader += new GroupEvent(helper_GroupHeader);
        //helper.ApplyGroupSort();
        helper.RegisterSummary("payAmount", SummaryOperation.Sum);
        helper.GeneralSummary += new FooterEvent(helper_SummaryFooter);
    }
    //private void helper_GroupHeader(string groupName, object[] values, GridViewRow row)
    //{
    //    row.CssClass = "list_item_alt";
    //    row.Cells[0].Text = "&nbsp;<b>Order#: " + row.Cells[0].Text + "</b>";
    //}
    private void helper_SummaryFooter(GridViewRow row)
    {
        row.Cells[0].Text = "Total:";
        row.CssClass = "pageSummary";
        row.Cells[0].HorizontalAlign = HorizontalAlign.Center;
    }

    protected void lstAgentOrders_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRow row = ((DataRowView)e.Row.DataItem).Row;
            numAdult += (int)row["numberAdult"];
            numChild += (int)row["numberChild"];
            totFare += (decimal)row["actualAmount"];
            totRec += (decimal)row["agentCredit"];
            totPaid += (decimal)row["agentBillAmount"];
            totBalance += (decimal)row["balance"];
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lbTotAdult = e.Row.FindControl("lbTotAdult") as Label;
            Label lbTotChild = e.Row.FindControl("lbTotChild") as Label;
            Label lbTotFare = e.Row.FindControl("lbTotFare") as Label;
            Label lbTotAgentReceivable = e.Row.FindControl("lbTotAgentReceivable") as Label;
            Label lbTotAgentPaid = e.Row.FindControl("lbTotAgentPaid") as Label;
            Label lbTotBalance = e.Row.FindControl("lbTotBalance") as Label;

            lbTotAdult.Text = numAdult.ToString();
            lbTotChild.Text = numChild.ToString();
            lbTotFare.Text = totFare.ToString("N2");
            lbTotAgentReceivable.Text = totRec.ToString("N2");
            lbTotAgentPaid.Text = totPaid.ToString("N2");
            lbTotBalance.Text = totBalance.ToString("N2");
        }
    }
    

}
