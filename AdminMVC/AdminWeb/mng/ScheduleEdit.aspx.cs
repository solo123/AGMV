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
using com.Omei.OmeiAdminData;

public partial class ScheduleEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void fvScheduleBaseInfo_DataBound(object sender, EventArgs e)
    {
        if (fvScheduleBaseInfo.CurrentMode == FormViewMode.Edit)
        {
            Control cnt = fvScheduleBaseInfo.FindControl("ScheduleHotelCtl1");
            if (cnt != null)
            {
                WebParts_ScheduleHotelCtl hc = cnt as WebParts_ScheduleHotelCtl;
                hc.Days = Convert.ToInt32(DataBinder.Eval(fvScheduleBaseInfo.DataItem, "tourDay"));
                hc.ScheduleID = Convert.ToInt32(DataBinder.Eval(fvScheduleBaseInfo.DataItem, "scheduleID"));
            }
        }
    }

    protected void fvScheduleBaseInfo_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        WebParts_ScheduleHotelCtl ctl = fvScheduleBaseInfo.FindControl("ScheduleHotelCtl1") as WebParts_ScheduleHotelCtl;
        if (ctl != null)
        {
            ctl.SaveData();
        }
    }
}
