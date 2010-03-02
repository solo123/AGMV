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
using com.Omei.OmeiDataSet;

public partial class Refund : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int orderId = PageTools.GetSavedId("OrderId", Request.QueryString["id"]);
            if ( orderId==0)
                Response.Redirect("OrderList.aspx");

            AdminOrderBiz biz = new AdminOrderBiz();
            int status = biz.GetOrderStatus(orderId);
            if (status != 2 && status!=3 )
                Response.Redirect("ProcessError.aspx?errMsg=Order's status incorrect. Please check.&nav=OrderDetail.aspx");

            OrderInfoCtl1.OrderId = orderId;

        }
    }
    protected void btnRefund_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            com.Omei.BLL.Admin.AdminOrderBiz biz = new com.Omei.BLL.Admin.AdminOrderBiz();
            D_LoginUserInfo ui = Session["LoginUserInfo"] as D_LoginUserInfo;

            decimal amount = PageTools.ParseDecimal(txtRefund.Text);
            int chargeForId = PageTools.ParseInt(payEmp.SelectedValue);
            int orderId = PageTools.GetSavedId("OrderId", null);
            int payMethod = PageTools.ParseInt(chkPayMethod.SelectedValue);
            int r = biz.Refund( ui, orderId, amount, payMethod, chargeForId, 
                "Refund by " + OmeiStatus.GetOmeiStatusText("PaymentMethod", payMethod, "en") + " " + txtRemark.Text);

            if (r >= 0)
            {
                if (payMethod == 5)
                {
                    // refund to credit voucher
                    VoucherBiz vbiz = new VoucherBiz();
                    int vid = vbiz.CreateVoucher(orderId, 0, amount, ui.userId);
                }
                Response.Redirect("OrderDetail.aspx");
            }
            else
                lbMsg.Text = "退款不成功，请检查订单状态和退款金额！";
        }
    }

    protected void btnDelOrder_Click(object sender, EventArgs e)
    {
        com.Omei.BLL.Admin.AdminOrderBiz biz = new com.Omei.BLL.Admin.AdminOrderBiz();
        D_LoginUserInfo ui = Session["LoginUserInfo"] as D_LoginUserInfo;

        if (biz.CancelOrder( PageTools.GetSavedId("OrderId",null) ))
            Response.Redirect("OrderDetail.aspx");
        else
            lbMsg.Text = "取消訂單失敗，如已付款請先退款！";
    }
}
