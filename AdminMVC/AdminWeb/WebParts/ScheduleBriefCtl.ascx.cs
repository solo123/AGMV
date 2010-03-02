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

public partial class WebParts_ScheduleBriefCtl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    public int ScheduleId
    {
        set 
        {
            if (value > 10)
            {
                panel1.Visible = true;
                panel2.Visible = false;
                ScheduleBriefDataset.SelectParameters["scheduleId"].DefaultValue = value.ToString();
                fvScheduleBrief.DataBind();
            }
            else
            {
                panel1.Visible = false;
                panel2.Visible = true;
            }
        }
    }

}
