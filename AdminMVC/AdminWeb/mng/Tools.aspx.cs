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

public partial class Tools : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnScheduleStatics_Click(object sender, EventArgs e)
    {
        /*
        AdminTourScheduleBiz biz = new AdminTourScheduleBiz();
        DataSet ds = biz.GetScheduleList();
        foreach (DataRow row in ds.Tables[0].Rows)
        {
            biz.ScheduleStatics((int)row["scheduleId"]);
        }
      */
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Label1.Text = "Resv:" + agentRecv.SelectedValue + " - To:" + agentTo.SelectedValue;
    }
}
