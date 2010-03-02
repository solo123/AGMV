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

public partial class TestUI_TestDateInputor : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        DateInputCtl3.DateValue = DateTime.Now;

        Label1.Text = "Date1=" + DateInputCtl1.DateValue.ToString() +
            "<br />Date2=" + DateInputCtl2.DateValue.ToString();
            
    }
}
