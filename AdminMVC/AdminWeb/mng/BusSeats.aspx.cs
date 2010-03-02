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
using com.Omei.DLL;
using com.Omei.OmeiDataSet;

public partial class BusSeats : System.Web.UI.Page
{
    #region Page_Load
    protected void Page_Load(object sender, EventArgs e)
    {
        MasterPageHelper.AddStyleSheet(Page, "Images/ticket.css");

        if (!Page.IsPostBack)
        {
            ShowScheduleInfo();

            if (!PageLogic.CheckActionAuth("ReleaseSeats"))
                btnRelease.Enabled = false;
        }

    }

    #endregion

    #region 显示schedule相关信息
    private void ShowScheduleInfo()
    {
        int scheduleID = PageTools.GetSavedId("scheduleID", Request.QueryString["id"]);
        if (scheduleID > 0)
        {
            lstOrders.DataBind();

            ScheduleBriefCtl1.ScheduleId = scheduleID;
            ScheduleBriefCtl1.DataBind();

            com.Omei.DLL.DS_SchedulesTableAdapters.ScheduleBaseInfoTableAdapter sdl = new com.Omei.DLL.DS_SchedulesTableAdapters.ScheduleBaseInfoTableAdapter();
            com.Omei.DLL.DS_Schedules.ScheduleBaseInfoDataTable dt = sdl.GetData(scheduleID);
            if (dt != null && dt.Count > 0)
            {
                int seats = dt[0].maxSeats;
                if (seats == 0) seats = 57;
                BusSeatCtl1.MaxSeats = seats;
                BusSeatCtl1.ScheduleId = scheduleID;
                BusSeatCtl1.DataBind();

                TourFeeCtl1.TourID = dt[0].tourId;
                HotelListCtl1.ScheduleID = scheduleID;
            }
            lbPrintSeats.Text = "<input type=button value='Print' onclick='PrintSeats(" + scheduleID.ToString() + ")' />";

            
        }
    }
    #endregion

    #region 按键处理
    protected void btnHold_Click(object sender, EventArgs e)
    {
        int sid = PageTools.ParseInt(Request.QueryString["id"]);
        AdminOrderBiz biz = new AdminOrderBiz();
        biz.HoldSeats( Session["LoginUserInfo"], sid, hdSeatList.Value, hdRemark.Value);
        ShowScheduleInfo();
    }

    protected void btnRelease_Click(object sender, EventArgs e)
    {
        int sid = PageTools.ParseInt(Request.QueryString["id"]);
        AdminOrderBiz biz = new AdminOrderBiz();
        biz.ReleaseSeats(sid, hdSeatList.Value);
        ShowScheduleInfo();
    }

    protected void btnOrder_Click(object sender, EventArgs e)
    {
        int sid = PageTools.ParseInt(Request.QueryString["id"]);
        AdminOrderBiz biz = new AdminOrderBiz();
        int orderId = biz.HoldSeats( Session["LoginUserInfo"], sid, hdSeatList.Value,  "");
        if (orderId > 0)
            Response.Redirect("OrderEdit.aspx?mode=edit&id=" + orderId.ToString() );
    }

    protected void lstOrders_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "AddSeats")
        {
            int orderId = PageTools.ParseInt( e.CommandArgument.ToString() );
            if (orderId > 0)
            {
                int sid = PageTools.ParseInt(Request.QueryString["id"]);
                AdminOrderBiz biz = new AdminOrderBiz();
                biz.AddSeats(sid, orderId, hdSeatList.Value);
                ShowScheduleInfo();
            }
        }
    }
    #endregion
}
