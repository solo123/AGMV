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

public partial class CreditCardPayment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int orderId = PageTools.GetSavedId("OrderId", Request.QueryString["id"]);
            if (orderId == 0)
                Response.Redirect("OrderActive.aspx");

            AdminOrderBiz biz = new AdminOrderBiz();
            int status = biz.GetOrderStatus(orderId);
            if (status != 2)
            {
                PageLogic.ShowError("Order's status incorrect. Please check.", "OrderDetail.aspx");
                return;
            }

            int scheduleId = biz.GetOrderScheduleId(orderId);

            OrderInfoCtl1.OrderId = orderId;
            OrderInfoCtl1.DataBind();

            CompareValidator rv = fvCreditCard.FindControl("CompareValidator1") as CompareValidator;
            if (rv != null)
            {
                rv.ValueToCompare = biz.GetBalance(orderId).ToString();
            }
        }
    }


    protected void btnInsert_Click(object sender, EventArgs e)
    {
        fvCreditCard.InsertItem(true);
    }
    protected void CreditCardDataset_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
    {
        lbMsg.Text = lbMsg1.Text = string.Empty;

        object r = e.ReturnValue;
        if (r != null)
        {
            if (Convert.ToInt32(r) > 0)
                Response.Redirect("OrderDetail.aspx",true);
        }
        lbMsg1.Text = lbMsg.Text = "Payment error, please check.";
    }

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
                if(tbFirstname!=null)
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
}
