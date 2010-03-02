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

public partial class LookCard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

        }
    }

    protected void btnPay_Click(object sender, EventArgs e)
    {
        Label lb = fvCreditCard.FindControl("lbCrid") as Label;
        if (lb != null)
        {
            CreditCardBiz biz = new CreditCardBiz();
            bool b = biz.CreditCardPayment(Session["LoginUserInfo"], PageTools.ParseInt(lb.Text));

            fvCreditCard.DataBind();
        }
    }
}
