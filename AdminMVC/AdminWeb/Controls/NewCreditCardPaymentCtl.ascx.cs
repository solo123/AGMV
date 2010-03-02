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
public partial class Controls_NewCreditCardPaymentCtl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }


    // auto fill
    protected void btnFillCustomerInfo_Click(object sender, EventArgs e)
    {
        int orderId = PageTools.GetSavedId("OrderId", Request.QueryString["id"]);
        if (orderId > 0)
        {
            AdminOrderBiz obiz = new AdminOrderBiz();
            int customerID = obiz.GetOrderCustomer(orderId);

            if (customerID > 0)
            {
                AdminUserBiz biz = new AdminUserBiz();
                D_UserInfo ui = biz.GetUserInfo(customerID);

                TextBox tbFirstname = fvCreditCard.FindControl("firstNameTextBox") as TextBox;
                if (tbFirstname != null)
                {
                    TextBox tbLastname = fvCreditCard.FindControl("lastNameTextBox") as TextBox;
                    TextBox tbAddress = fvCreditCard.FindControl("addressTextBox") as TextBox;
                    TextBox tbCity = fvCreditCard.FindControl("cityTextBox") as TextBox;
                    TextBox tbState = fvCreditCard.FindControl("stateTextBox") as TextBox;
                    TextBox tbZip = fvCreditCard.FindControl("zipTextBox") as TextBox;
                    Controls_CountrySelector country = fvCreditCard.FindControl("CountrySelector1") as Controls_CountrySelector;

                    tbFirstname.Text = ui.firstName;
                    tbLastname.Text = ui.lastName;
                    tbAddress.Text = ui.address;
                    tbCity.Text = ui.city;
                    tbState.Text = ui.state;
                    tbZip.Text = ui.zip;
                    country.CountryCode = ui.country;
                }
            }
        }
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        TextBox tbAmount = fvCreditCard.FindControl("txtAmount") as TextBox;
        TextBox tbServiceFee = fvCreditCard.FindControl("txtServiceFee") as TextBox;
        if (tbAmount != null)
        {
            if (PageTools.ParseDouble(tbAmount.Text) + PageTools.ParseDouble(tbServiceFee.Text) == PageTools.ParseDouble(args.Value))
                args.IsValid = true;
            else
                args.IsValid = false;
        }
    }

    #region 保存信用卡信息
    public void SaveCreditCardInfo(int paymentID)
    {
        TextBox tAmount = fvCreditCard.FindControl("txtAmount") as TextBox;
        TextBox tSf = fvCreditCard.FindControl("txtServiceFee") as TextBox;
        decimal tot = PageTools.ParseDecimal(tAmount.Text) + PageTools.ParseDecimal(tSf.Text);
        CreditCardDataset.InsertParameters["orderID"].DefaultValue = PageTools.GetSavedId("orderID", null).ToString();
        CreditCardDataset.InsertParameters["totalAmount"].DefaultValue = tot.ToString();
        CreditCardDataset.InsertParameters["paymentID"].DefaultValue = paymentID.ToString();
        fvCreditCard.InsertItem(true);
    }
    protected void CreditCardDataset_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
    {
        object r = e.ReturnValue;
        if (r == null || Convert.ToInt32(r) <= 0)
        {
            lbMsg.Text = "保存信用卡信息出錯，請檢查。";
            lbMsg.Visible = true;
        }
        else
        {
            lbMsg.Visible = false;
        }
    }
    #endregion

    #region 屬性
    public bool ValidateInput
    {
        get
        {
            return false;
        }
    }
    public decimal PaymentAmount
    {
        get
        {
            TextBox tAmount = fvCreditCard.FindControl("txtAmount") as TextBox;
            TextBox tSf = fvCreditCard.FindControl("txtServiceFee") as TextBox;
            decimal tot = PageTools.ParseDecimal(tAmount.Text) + PageTools.ParseDecimal(tSf.Text);
            return tot;
        }
        set
        {
            TextBox tAmount = fvCreditCard.FindControl("txtAmount") as TextBox;
            TextBox tSf = fvCreditCard.FindControl("txtServiceFee") as TextBox;
            tAmount.Text = value.ToString();
            tSf.Text = "0.00";
        }
    }

    public string CreditCardBriefNumber
    {
        get
        {
            Controls_OmeiTypeSelectorCtl ctype = fvCreditCard.FindControl("seleCardType") as Controls_OmeiTypeSelectorCtl;
            TextBox cn = fvCreditCard.FindControl("cardNumberTextBox") as TextBox;
            return ctype.SelectedValue + " Card: ****-" +  cn.Text.Substring(cn.Text.Length-4);
        }
    }
    #endregion

}
