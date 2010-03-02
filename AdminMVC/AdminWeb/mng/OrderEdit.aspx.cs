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

public partial class OrderEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int orderId = PageTools.GetSavedId("OrderId", Request.QueryString["id"]);
            if (orderId == 0) Response.Redirect("OrderList.aspx");

            AdminOrderBiz biz = new AdminOrderBiz();
            int status = biz.GetOrderStatus(orderId);
            //检查权限
            if (status >= 7)
            {
                PageLogic.ShowError("Order is closed. 订单已完成。", "OrderDetail.aspx");
                return;
            }
            else if (status >2 )
            {
                if (!PageLogic.CheckActionAuth("EditFullPaidOrder"))
                {
                    PageLogic.ShowError("You have not authorization. 您没有权限。", "OrderDetail.aspx");
                    return;
                }
            }
        }
    }

    protected void OrderDetailDataset_Updated(object sender, ObjectDataSourceStatusEventArgs e)
    {
        if(e.ReturnValue!=null && (bool)e.ReturnValue==true)
            Response.Redirect("OrderDetail.aspx");
        else
            lbMsg.Text = "Update failure! please check.";
    }

    protected void fvOrderDetail_DataBound(object sender, EventArgs e)
    {
        TextBox adultNum = fvOrderDetail.FindControl("numberAdultTextBox") as TextBox;
        TextBox childNum = fvOrderDetail.FindControl("numberChildTextBox") as TextBox;
        Label subTotal = fvOrderDetail.FindControl("lbSubtotal") as Label;
        TextBox miscCharge = fvOrderDetail.FindControl("miscChargeTextBox") as TextBox;
        Controls_OmeiTypeSelectorCtl discountCtl = fvOrderDetail.FindControl("lstDiscount") as Controls_OmeiTypeSelectorCtl;
        DropDownList discount = discountCtl.OmeiTypeDropDownList;
        Label suggetAmount = fvOrderDetail.FindControl("lbSuggestAmount") as Label;
        TextBox actual = fvOrderDetail.FindControl("actualAmountTextBox") as TextBox;
        TextBox priceAdult = fvOrderDetail.FindControl("txtPriceAdult") as TextBox;
        TextBox priceChild = fvOrderDetail.FindControl("txtPriceChild") as TextBox;
        HiddenField hdSubTotal = fvOrderDetail.FindControl("hdSubtotal") as HiddenField;
        HiddenField hdSuggest = fvOrderDetail.FindControl("hdSuggest") as HiddenField;
        Label recal = fvOrderDetail.FindControl("lbRecal") as Label;

        adultNum.Attributes.Add("onchange", "DoCalculate()");
        childNum.Attributes.Add("onchange", "DoCalculate()");
        miscCharge.Attributes.Add("onchange", "DoCalculate()");
        discount.Attributes.Add("onchange", "DoCalculate()");
        recal.Attributes.Add("onclick", "DoCalculate()");
        priceAdult.Attributes.Add("onchange", "DoCalculate()");
        priceChild.Attributes.Add("onchange", "DoCalculate()");

        System.Text.StringBuilder sb = new System.Text.StringBuilder();

        sb.Append("\n\n<script type=text/javascript>\n");
        sb.Append("function DoCalculate(){");

        AddClientDeclare(sb, "HD_priceAdult", priceAdult.ClientID);
        AddClientDeclare(sb, "HD_priceChild", priceChild.ClientID);
        AddClientDeclare(sb, "HD_subtotal", hdSubTotal.ClientID);
        AddClientDeclare(sb, "HD_suggest", hdSuggest.ClientID);

        AddClientDeclare(sb, "TB_adultNum", adultNum.ClientID);
        AddClientDeclare(sb, "TB_childNum", childNum.ClientID);
        AddClientDeclare(sb, "TB_misc", miscCharge.ClientID);
        AddClientDeclare(sb, "DL_discount", discount.ClientID);
        AddClientDeclare(sb, "TB_actual", actual.ClientID);

        AddClientDeclare(sb, "LB_subtotal", subTotal.ClientID);
        AddClientDeclare(sb, "LB_suggest", suggetAmount.ClientID);

        sb.Append(@"

    if ( TB_adultNum!=null && TB_childNum!=null && HD_priceAdult!=null && HD_priceChild!=null )
    {
        var na = TB_adultNum.value;
        var nc = TB_childNum.value;
        var pa = HD_priceAdult.value;
        var pc = HD_priceChild.value;
        if (na == '') na = '0';
        if (nc == '') nc = '0';
        if (pa == '') pa = '0';
        if (pc == '') pc = '0';
        if (TB_misc.value=='') TB_misc.value = '0';

        var fare = 0.00 + na*pa + nc*pc;
        var suggest = (fare * (100-DL_discount.value) / 100) + eval(TB_misc.value);
        
        LB_subtotal.innerHTML = fare.toFixed(2);
        HD_subtotal.value = fare.toFixed(2);
        LB_suggest.innerHTML = suggest.toFixed(2);
        HD_suggest.value = suggest.toFixed(2);
        TB_actual.value = suggest.toFixed(2);
    }
");

        sb.Append("}\n");


        Label lbMemberID = fvOrderDetail.FindControl("lbMemberID") as Label;
        HiddenField txtMemberID = fvOrderDetail.FindControl("txtMemberID") as HiddenField;
        Label lbFirstname = fvOrderDetail.FindControl("lbFirstname") as Label;
        HiddenField txtFirstname = fvOrderDetail.FindControl("txtFirstname") as HiddenField;
        Label lbLastname = fvOrderDetail.FindControl("lbLastname") as Label;
        HiddenField txtLastname = fvOrderDetail.FindControl("txtLastname") as HiddenField;
        Label lbTel = fvOrderDetail.FindControl("lbContactPhone") as Label;
        HiddenField txtTel = fvOrderDetail.FindControl("txtContactPhone") as HiddenField;
        Label lbEmail = fvOrderDetail.FindControl("lbEmail") as Label;
        HiddenField txtEmail = fvOrderDetail.FindControl("txtEmail") as HiddenField;

        sb.Append(@"
var currentUserID = '';
function GotCustomerInfo(info)
{
    ShowSearchCustomer('none');
");
        sb.Append(" var l_memberID = $('");
        sb.Append(lbMemberID.ClientID);
        sb.Append("');\n var t_memberID = $('");
        sb.Append(txtMemberID.ClientID);
        sb.Append("');\n var l_firstname = $('");
        sb.Append(lbFirstname.ClientID);
        sb.Append("');\n var t_firstname = $('");
        sb.Append(txtFirstname.ClientID);
        sb.Append("');\n var l_lastname = $('");
        sb.Append(lbLastname.ClientID);
        sb.Append("');\n var t_lastname = $('");
        sb.Append(txtLastname.ClientID);
        sb.Append("');\n var l_tel = $('");
        sb.Append(lbTel.ClientID);
        sb.Append("');\n var t_tel = $('");
        sb.Append(txtTel.ClientID);
        sb.Append("');\n var l_email = $('");
        sb.Append(lbEmail.ClientID);
        sb.Append("');\n var t_email = $('");
        sb.Append(txtEmail.ClientID);
        sb.Append("');\n\n");

        sb.Append(@"
    if ( info!=null && info.length>0 )
    {
        var ci = info.split('|');
        if(ci.length>=5)
        {
            l_memberID.innerHTML = t_memberID.value = ci[0];
            l_firstname.innerHTML = t_firstname.value = ci[1];
            l_lastname.innerHTML = t_lastname.value = ci[2];
            l_tel.innerHTML = t_tel.value = ci[3];
            l_email.innerHTML = t_email.value = ci[4];
            currentUserID = ci[0];
        }
    }

}
function ShowSearchCustomer(displayMode){
    var fw = document.getElementById('dhtmlgoodies_floating_window0');
    if (fw!=null) fw.style.display = displayMode;
}
");
        sb.Append("</script>\n\n");

        ClientScript.RegisterClientScriptBlock(this.GetType(), "OrderElements", sb.ToString());
    }

    private void AddClientDeclare(System.Text.StringBuilder sb, string clientID, string val)
    {
        sb.Append("var ");
        sb.Append(clientID);
        sb.Append(" = document.getElementById('");
        sb.Append(val);
        sb.Append("');\n");
    }

    protected string GetSeatList(object o)
    {
        com.Omei.BLL.Admin.AdminOrderBiz biz = new com.Omei.BLL.Admin.AdminOrderBiz();
        if (o == null) return string.Empty;

        return biz.GetSeatList((int)o);
    }

    protected bool IsFloatPrice()
    {
        int orderType = Convert.ToInt32(DataBinder.Eval(fvOrderDetail.DataItem, "orderType"));
        if (orderType == 0)
        {
            object f = DataBinder.Eval(fvOrderDetail.DataItem, "isFloatPrice");
            if (f == null || f is DBNull)
                return false;
            else
                return (bool)f;
        }
        else
            return true;
    }
    
}
