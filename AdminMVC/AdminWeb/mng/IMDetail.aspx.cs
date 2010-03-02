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
public partial class IMDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnUpdateAgentInv_Click(object sender, EventArgs e)
    {
        if (Session["LoginUserInfo"] != null && fvInvoice.DataKey.Value != null)
        {
            TextBox tb = fvInvoice.FindControl("lbAgentInv") as TextBox;
            IMMatchBiz biz = new IMMatchBiz();
            biz.UpdateAgentInv(Session["LoginUserInfo"], (int)fvInvoice.DataKey.Value, tb.Text);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        if (Session["LoginUserInfo"] != null && fvInvoice.DataKey.Value != null)
        {
            IMMatchBiz biz = new IMMatchBiz();
            biz.CancelMatchedInvoice(Session["LoginUserInfo"], (int)fvInvoice.DataKey.Value);
        }
    }

    protected string MatchInvoiceStatus(object status)
    {
        if (Convert.ToInt32(status) == 7)
        {
            fvInvoice.CssClass = "canceled";
            Button btn1 = fvInvoice.FindControl("btnUpdateAgentInv") as Button;
            Button btn2 = fvInvoice.FindControl("btnCancel") as Button;
            TextBox txt1 = fvInvoice.FindControl("lbAgentInv") as TextBox;

            btn1.Visible = btn2.Visible = false;
            txt1.Enabled = false;
        }
        return "";
    }
}
