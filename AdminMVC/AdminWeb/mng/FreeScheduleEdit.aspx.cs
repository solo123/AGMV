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

public partial class FreeScheduleEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            lbScheduleID.Text = Request.QueryString["id"];
            if(Request.QueryString["add"]=="1")
            {
                fvScheduleBaseInfo.ChangeMode(FormViewMode.Insert);
                TourNameCtl1.TourID = PageTools.ParseInt(Request.QueryString["tourID"]);
                lbScheduleID.Text = "(New)";
            }
        }
    }
}
