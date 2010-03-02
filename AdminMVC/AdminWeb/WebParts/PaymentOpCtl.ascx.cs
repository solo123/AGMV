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

public partial class WebParts_PaymentCtl : System.Web.UI.UserControl
{
    private string m_afterPayment = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.ClientScript.IsClientScriptBlockRegistered("SetMethod"))
        {
            string script = @"
<script type='text/javascript'>
function setMethod(method)
{
    var TB_method = document.getElementById('" + txtMethod.ClientID + @"');
    var DIV_check = document.getElementById('CheckDiv');

    if (method==1)
    {
        TB_method.value = '1';
        DIV_check.style.visibility = 'hidden';
    } 
    else 
    {
        TB_method.value = '3';
        DIV_check.style.visibility = 'visible';
    }
}
function CheckPayment()
{
    var TB_pay = document.getElementById('"+ txtPay.ClientID + @"');
    var TB_method = document.getElementById('" + txtMethod.ClientID + @"');
    var TB_check = document.getElementById('"+ txtCheckNumber.ClientID +@"');
    var LB_balance = document.getElementById('"+ lbBalance.ClientID +@"');
    
    if(isNaN(TB_pay.value) || isNaN(Number(TB_pay.value)) ||Number(TB_pay.value)==0 )
    {
        alert('Please input a valid number');
        TB_pay.focus();
        return false;
    }
    if( Number(TB_pay.value) > Number(LB_balance.innerText) )
    {
        alert('Pay amount more than balance amount.');
        TB_pay.focus();
        return false;
    }
    if( Number(TB_method.value)==3 )
    {
        if (TB_check.value.length < 1)
        {
            alert('Please input check number.');
            TB_check.focus();
            return false;
        }
    }

    return true;
}
</script>";
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "SetMethod", script);
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

    #region Refresh
    public void RefreshControl()
    {
        int orderId = PageTools.GetSavedId("OrderId", null);
        if (orderId > 0)
        {
            com.Omei.BLL.Admin.AdminOrderBiz biz = new com.Omei.BLL.Admin.AdminOrderBiz();
            lbBalance.Text = biz.GetBalance(orderId).ToString();
        }
        else lbBalance.Text = "";
    }
    #endregion

    #region Payment
    protected void btnPay_Click(object sender, EventArgs e)
    {
        string remark = "";
        D_LoginUserInfo ui = Session["LoginUserInfo"] as D_LoginUserInfo;

        if (txtMethod.Value == "3")
        {
            remark = txtCheckNumber.Text;
        }

        AdminOrderBiz biz = new AdminOrderBiz();
        int orderId = PageTools.GetSavedId("OrderId",null);
        decimal amount = PageTools.ParseDecimal(txtPay.Text);

        int chargeForId = ui.userId;
        if ( payEmp.SelectedIndex>0 )
            chargeForId = int.Parse(payEmp.SelectedValue);

        int r = biz.Payment( Session["LoginUserInfo"],
            orderId, amount,
            int.Parse(txtMethod.Value), 0,
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
            lbMsg.ForeColor = System.Drawing.Color.DarkGreen;
            txtPay.Text = "0.00";
        }

        RefreshControl();

        if (m_afterPayment != null && m_afterPayment != "")
        {
            Delegate d = Delegate.CreateDelegate(typeof(EventHandler), Page, m_afterPayment);
            ((EventHandler)d)(this, null);
        }
    }
    #endregion

}
