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

public partial class OrderDetail : System.Web.UI.Page
{
    private int cardCount = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int orderId = PageTools.GetSavedId("OrderId", Request.QueryString["id"]);
            if ( orderId==0 )
                Response.Redirect("OrderList.aspx");


            lnkPrint.NavigateUrl = "PrintTicket.aspx" + Request.Url.Query;

            AdminOrderBiz biz = new AdminOrderBiz();
            int scheduleId = biz.GetOrderScheduleId(orderId);

            OrderInfoCtl1.OrderId = orderId;
            OrderInfoCtl1.DataBind();

            OrdersCCListDataset.SelectParameters["orderId"].DefaultValue = orderId.ToString();
            lstOrdersCCList.DataBind();

            OplogList1.OpType = 4;
            OplogList1.RelateID = orderId;

            VoucherDataset.SelectParameters["orderID"].DefaultValue = orderId.ToString();

            lnkBusSeats.NavigateUrl = "~/BusSeats.aspx?id="+ scheduleId.ToString();

            // OrderEdit权限检查
            int status = biz.GetOrderStatus(orderId);
            int orderType = biz.GetOrderType(orderId);
            if (orderType > 0)
            {
                // is ticket
                lnkOrderEdit.NavigateUrl = "TicketEdit.aspx";
                lnkPrint.NavigateUrl = "PrintQTicket.aspx" + Request.Url.Query;
            }
            if (PageLogic.CheckPageAuth("OrderEdit.aspx"))
            {
                if (status >= 3 && status<7)
                {
                    if (!PageLogic.CheckActionAuth("EditFullPaidOrder"))
                    {
                        lnkOrderEdit.Attributes.Add("onclick", "alert('You have not authorization to edit orders in this status.\\n\\n您没有授权修改此状态下的订单。');return false;");
                    }
                }
                if (status >= 7)
                {
                    lnkOrderEdit.Attributes.Add("onclick", "alert('Order been closed.\\n订单已完成。');return false;");
                }
            }
            else
            {
                lnkOrderEdit.Enabled = false;
            }


            if (status ==0 || status >= 3)
            {
                lnkPayment.Enabled = false;
            }
            if (status < 2)
            {
                lnkRefund.Enabled = lnkPrint.Enabled = false;
            }
        }
    }

    protected string PayCreditCardText(object paymentId, object crId, object cardNumber, object amount)
    {
        if (paymentId == null || crId==null) return string.Empty;

        int p = (int)paymentId;
        int c = (int)crId;
        cardCount++;

        string txt = OmeiStatus.CreditCardNumberText(cardNumber) + "("+ (p>0?"Paid":"") +"$"+amount.ToString()+")";
        if (p > 0)
            return cardCount.ToString() + ") <a href='LookCard.aspx?id=" + crId.ToString() +"'>"+ txt +"</a>";
        else
            return cardCount.ToString() + ") <a href='LookCard.aspx?id=" + crId.ToString() + "'>" + txt + "</a>";

    }

}
