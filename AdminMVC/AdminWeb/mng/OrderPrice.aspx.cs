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

public partial class OrderPrice : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int orderId = PageTools.GetSavedId("OrderId", Request.QueryString["id"]);
            if (orderId == 0) Response.Redirect("OrderList.aspx");
            if (Request.QueryString["id"] == null)
                Server.Transfer("OrderPrice.aspx?id=" + orderId.ToString());
        }
    }
}
