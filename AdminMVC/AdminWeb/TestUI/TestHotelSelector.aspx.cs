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

public partial class TestUI_TestHotelSelector : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        ScheduleHotelCtl1.ScheduleID = int.Parse(txtScheduleId.Text);
        ScheduleHotelCtl1.Days = int.Parse(txtNights.Text);
    }
}
