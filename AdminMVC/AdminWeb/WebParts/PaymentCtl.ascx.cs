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
using com.Omei.OmeiDataSet;

public partial class WebParts_PaymentControl : System.Web.UI.UserControl
{
    private string m_afterPayment = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int orderId = PageTools.GetSavedId("OrderId", null);
            if (orderId <= 0) tabsPayment.Visible = false;

            AdminOrderBiz biz = new AdminOrderBiz();
            if (!biz.IsAgentOrder(orderId)) tabsPayment.Tabs.FromKey("Agent").Visible = false;
        }
    }

    #region 属性
    public string AfterPayment
    {
        set { m_afterPayment = value; }
    }
    #endregion

    public override void DataBind()
    {
        base.DataBind();
        RefreshControl();
    }

    public void DoAfterPayment()
    {
        if (m_afterPayment != null && m_afterPayment != "")
        {
            Delegate d = Delegate.CreateDelegate(typeof(EventHandler), Page, m_afterPayment);
            ((EventHandler)d)(this, null);
        }
    }

    #region Refresh
    public void RefreshControl()
    {
        int orderId = PageTools.GetSavedId("OrderId", null);
        if (orderId > 0)
        {
            com.Omei.BLL.Admin.AdminOrderBiz biz = new com.Omei.BLL.Admin.AdminOrderBiz();
            lbAgentAmount.Text = lbBalance.Text = biz.GetBalance(orderId).ToString();
        }
        else
        {
            lbAgentAmount.Text = lbBalance.Text = "";
        }
    }
    #endregion

    private int DoPayment(string payAmountString, int paymentMethod, string remark)
    {
        decimal amount = PageTools.ParseDecimal(payAmountString);
        if (amount <= 0)
        {
            lbMsg.Text = "金額不能為0或負數！";
            return 0;
        }

        D_LoginUserInfo ui = Session["LoginUserInfo"] as D_LoginUserInfo;
        
        int orderId = PageTools.GetSavedId("OrderId", null);
        int chargeForId = ui.userId;
        if (payEmp.SelectedIndex > 0)
            chargeForId = int.Parse(payEmp.SelectedValue);



        AdminOrderBiz biz = new AdminOrderBiz();
        int r = biz.Payment(Session["LoginUserInfo"],
            orderId, amount,
            paymentMethod, 0,
            chargeForId, ui.userId, remark);

        if (r < 0)
        {
            lbMsg.ForeColor = System.Drawing.Color.Red;
            switch (r)
            {
                case -1:
                    lbMsg.Text = "订单状态不能付款";
                    break;
                case -2:
                    lbMsg.Text = "付款金额超过应付额";
                    break;
                case -3:
                    lbMsg.Text = "订单不存在";
                    break;
                case -9:
                    lbMsg.Text = "金额不能为0";
                    break;
                default:
                    lbMsg.Text = "订单状态不确定";
                    break;
            }
        }
        else
        {
            lbMsg.Text = "付款成功.";
            lbMsg.CssClass = "ok_message";
        }
        return r;
    }
    protected void btnPayCash_Click(object sender, EventArgs e)
    {
        if (DoPayment(txtCashAmount.Text,1, "By Cash")>0)
        {
            txtCashAmount.Text = "0.00";
            RefreshControl();
            DoAfterPayment();
        }
    }
    protected void btnPayCheck_Click(object sender, EventArgs e)
    {
        if (DoPayment(txtCheckAmount.Text, 3, "By Check:" + txtCheckNumber.Text)>0)
        {
            txtCheckAmount.Text = "0.00";
            txtCheckNumber.Text = "";
            RefreshControl();
            DoAfterPayment();
        }
    }
    protected void btnPayCC_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            int pid = DoPayment(CreditCardPaymentCtl1.PaymentAmount.ToString(), 2, "By " + CreditCardPaymentCtl1.CreditCardBriefNumber);
            if (pid>0)
            {
                CreditCardPaymentCtl1.SaveCreditCardInfo(pid);
                RefreshControl();
                DoAfterPayment();
            }
        }
    }

    
    protected void btnPayAgent_Click(object sender, EventArgs e)
    {
        if (DoPayment(lbAgentAmount.Text, 4, "By Agent Credit.")>0)
        {
            lbAgentAmount.Text = "0.0";
            RefreshControl();
            DoAfterPayment();
        }
    }

    protected void bntVoucher_Click(object sender, EventArgs e)
    {
        VoucherBiz biz = new VoucherBiz();
        DataSet ds = biz.GetVoucherDetail(PageTools.ParseInt(txtVoucherID.Text));
        if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
        {
            DataRow row = ds.Tables[0].Rows[0];
            lbVoucherAmount.Text = row["amount"].ToString();
            lbVoucherDetail.Text = "Refund by order:<a href='OrderDetail.aspx?id="+ row["refundOrder"].ToString() +"'>"+ row["refundOrder"].ToString() +"</a> (Expire:" +
                row["expireDate"].ToString() + ", Status:" +
                row["status"].ToString() + ")";
            txtVoucherAmount.Enabled = btnPayVoucher.Enabled = true;
        }
        else
        {
            lbVoucherAmount.Text = "No found!";
            lbVoucherAmount.ForeColor = System.Drawing.Color.Red;
            lbVoucherDetail.Text = "";
            txtVoucherAmount.Enabled = btnPayVoucher.Enabled = false;
        }
    }
    protected void btnPayVoucher_Click(object sender, EventArgs e)
    {
        VoucherBiz biz = new VoucherBiz();
        int voucherID = PageTools.ParseInt(txtVoucherID.Text);
        decimal amount = PageTools.ParseDecimal(txtVoucherAmount.Text);
        int orderID = PageTools.GetSavedId("OrderId", null);
        if (biz.CheckVoucherPaymentValid(voucherID, amount))
        {
            int pid = DoPayment(txtVoucherAmount.Text, 5, "By Voucher: " + voucherID.ToString());
            if (pid > 0)
            {
                if (!biz.VoucherPayment(PageLogic.GetCurrentUserLogin(), voucherID, amount, orderID))
                {
                    lbMsg.Text = "Voucher Payment fail! Please check.";
                }
                lbVoucherAmount.Text = "";
                lbVoucherDetail.Text = "";
                txtVoucherAmount.Text = "0.0";
                txtVoucherID.Text = "";
                txtVoucherAmount.Enabled = btnPayVoucher.Enabled = false;
                RefreshControl();
                DoAfterPayment();
            }
        }
        else
        {
            lbMsg.Text = "付款失敗，請檢查。";
        }
    }

}
