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

public partial class BusSeats_Prn : System.Web.UI.Page
{
    #region Page_Load
    protected void Page_Load(object sender, EventArgs e)
    {
        // para: scheduleId
        if (!Page.IsPostBack)
        {
            ShowScheduleInfo();
        }
    }

    #endregion

    #region 显示schedule相关信息
    private void ShowScheduleInfo()
    {
        if (Request.QueryString["scheduleId"] == null) return;

        int scheduleId = int.Parse(Request.QueryString["scheduleId"]);
        if (scheduleId > 0)
        {

            ScheduleBriefCtl1.ScheduleId = scheduleId;
            ScheduleBriefCtl1.DataBind();

            com.Omei.DLL.DS_SchedulesTableAdapters.ScheduleBaseInfoTableAdapter sdl = new com.Omei.DLL.DS_SchedulesTableAdapters.ScheduleBaseInfoTableAdapter();
            com.Omei.DLL.DS_Schedules.ScheduleBaseInfoDataTable dt = sdl.GetData(scheduleId);
            if (dt != null && dt.Count > 0)
            {
                int seats = dt[0].maxSeats;
                if (seats == 0) seats = 57;
                BusSeatCtl1.MaxSeats = seats;
                BusSeatCtl1.ScheduleId = scheduleId;
                BusSeatCtl1.DataBind();

                HotelListCtl1.ScheduleID = scheduleId;
            }
        }
    }
    #endregion

}
