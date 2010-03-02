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

public partial class Page_OrderPayment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int orderId = PageTools.GetSavedId("OrderId", Request.QueryString["id"]);
            if (orderId==0)
                Response.Redirect("OrderList.aspx");

            AdminOrderBiz biz = new AdminOrderBiz();
            int status = biz.GetOrderStatus(orderId);
            if (status != 2)
            {
                PageLogic.ShowError("Order's status incorrect. Please check.", "OrderDetail.aspx");
                return;
            }

            OrderInfoCtl1.OrderId = orderId;
            OrderInfoCtl1.DataBind();

            PaymentCtl1.DataBind();
        }
    }

    protected void AfterPayment(object sender, EventArgs e)
    {
        OrderInfoCtl1.DataBind();
    }

}
