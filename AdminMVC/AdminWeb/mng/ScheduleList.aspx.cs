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

public partial class ScheduleList : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            dateFrom.DateValue = DateTime.Now;
            dateTo.DateValue = DateTime.Now.AddMonths(1);

            btnQuery_Click(null, null);
        }

    }

    protected void btnQuery_Click(object sender, EventArgs e)
    {
        ScheduleListDataset.SelectParameters["startDate"].DefaultValue = dateFrom.DateValue.ToShortDateString();
        ScheduleListDataset.SelectParameters["endDate"].DefaultValue = dateTo.DateValue.ToShortDateString();
        lstSchedule.DataBind();
    }

    protected void lstSchedule_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int idx;
        switch (e.CommandName)
        {
            case "ScheduleEdit":
                idx = int.Parse(e.CommandArgument.ToString());
                Response.Redirect("ScheduleEdit.aspx?id=" + lstSchedule.DataKeys[idx].Value.ToString());
                break;
            case "ShowSeats":
                idx = int.Parse(e.CommandArgument.ToString());
                Response.Redirect("BusSeats.aspx?id=" + lstSchedule.DataKeys[idx].Value.ToString());
                break;
            default:
                break;
        }
    }

    protected string ScheduleSeatsUrl(object scheduleID, object hasSeatTable)
    {
        if (scheduleID == null || !(scheduleID is int))
            return string.Empty;

        int id = (int)scheduleID;
        bool b = (bool)hasSeatTable;

        if (b)
        {
            return "BusSeats.aspx?id=" + id.ToString();
        }
        else
            return "ScheduleOrders.aspx?id=" + id.ToString();

    }

    protected string SeatImg(object hasSeatTable)
    {
        if (hasSeatTable != null && (bool)hasSeatTable == false)
            return "~/Images/res/arrow01.gif";
        else
            return "~/Images/res/spacer.gif";
    }

}
