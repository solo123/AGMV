using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// HotelListCtl 的摘要说明
/// </summary>
public partial class Controls_HotelListCtl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    public int ScheduleID
    {
        set
        {
            HotelDataset.SelectParameters["scheduleID"].DefaultValue = value.ToString();
            lstHotel.DataBind();
        }
    }
}
