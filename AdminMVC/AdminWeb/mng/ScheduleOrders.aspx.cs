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

public partial class ScheduleOrders : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int scheduleID = PageTools.GetSavedId("scheduleID", Request.QueryString["id"]);
            if (scheduleID <= 0) Response.Redirect("OrderList.aspx");

            ScheduleBriefCtl1.ScheduleId = scheduleID;
            OrderDataset.SelectParameters["scheduleID"].DefaultValue = scheduleID.ToString();
            lstOrder.DataBind();
        }

    }
    protected void lstOrder_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected string ShowAgentIcon(object agentId)
    {
        if (agentId == null || !(agentId is int)) return null;
        int a = (int)agentId;
        if (a > 0)
            return "<a href='#'><img src='Images/res/members.gif' /></a>";
        else
            return string.Empty;
    }
    protected string ShowEmailIcon(object email)
    {
        if (email == null) return string.Empty;

        string e = email.ToString();
        if (e.Length < 4) return string.Empty;
        else
            return "<a href='mailto:" + e + "'><img src='Images/res/mail.gif' /></a>";
    }
    protected string ShowPickup(object pickup)
    {
        if (pickup == null) return string.Empty;

        string s = pickup.ToString();
        if (s.Length < 1) return string.Empty;

        return s[0].ToString();
    }
    protected void btnNewOrder_Click(object sender, EventArgs e)
    {
        int sid = PageTools.GetSavedId("scheduleID", null);
        AdminOrderBiz biz = new AdminOrderBiz();
        int orderId = biz.AddEmptyOrder(sid, ((D_LoginUserInfo)Session["LoginUserInfo"]).userId);
        if (orderId > 0)
        {
            biz.RecalculateOrder(orderId);
            Response.Redirect("OrderEdit.aspx?mode=edit&id=" + orderId.ToString());
        }
        else
            txtMsg.Text = "Add new order ERROR!";
    }
}
