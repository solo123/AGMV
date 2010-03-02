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
using com.Omei.BLL.Admin.DataEntity;
public partial class InvoiceMatch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnMatch_Click(object sender, EventArgs e)
    {
        if (PageTools.ParseInt(seleAgent.SelectedValue) <= 0)
        {
            lbMsg.CssClass = "error";
            lbMsg.Text = "Please select agent!";
            return;
        }
        if (PageTools.ParseInt(seleAgentPaymentMethod.SelectedValue) < 0)
        {
            lbMsg.CssClass = "error";
            lbMsg.Text = "Please select payment method!";
            return;
        }

        DT_InvoiceMatch im = new DT_InvoiceMatch();
        foreach (GridViewRow row in lstOrder.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                TextBox tb = row.FindControl("txtCost") as TextBox;
                HyperLink lnk = row.FindControl("lnkOrderID") as HyperLink;
                if (tb != null && lnk!=null && !string.IsNullOrEmpty(tb.Text))
                    im.Orders.Add(new DT_InvoiceMatchOrder(Convert.ToInt32(lnk.Text), Convert.ToDecimal(tb.Text)));
            }
        }
        im.Cost = Convert.ToDecimal(txtCost.Text);
        im.Tax = Convert.ToDecimal(txtTax.Text);
        im.AgentInv = txtAgentInv.Text;
        im.Notes = txtNotes.Text;
        im.AgentID = PageTools.ParseInt(seleAgent.SelectedValue);
        im.PaymentMethod = PageTools.ParseInt(seleAgentPaymentMethod.SelectedValue);

        IMMatchBiz biz = new IMMatchBiz();
        int matchID = biz.MatchInvoice(PageLogic.GetCurrentUserLogin(), im);
        if (matchID > 0)
        {
            lbMsg.Text = "Invoice Matched.(ID:"+ matchID.ToString() +")";
            lbMsg.CssClass = "";
            txtAgentInv.Text = txtCost.Text = txtTax.Text = txtNotes.Text = "";
            lstOrder.DataBind();
        }
        else
        {
            lbMsg.Text = "Not Match! Please check.";
            lbMsg.CssClass = "error";
        }
    }
}
