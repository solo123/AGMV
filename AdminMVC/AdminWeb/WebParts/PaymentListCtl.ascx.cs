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

public partial class WebParts_PaymentListCtl : System.Web.UI.UserControl
{
    private int m_orderId;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public int OrderId
    {
        set
        {
            m_orderId = value;
            PaymentListDataset.SelectParameters["orderId"].DefaultValue = m_orderId.ToString();
            lstPayment.DataBind();
            //RefreshControl();
        }

    }
    public void RefreshControl()
    {
        //lstPayment.DataBind();
    }
}
