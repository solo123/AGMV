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

public partial class Drivers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnNewDriver_Click(object sender, EventArgs e)
    {
        DriverDataset.Insert();
    }
    protected void lstDriver_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DelDriver")
        {
            com.Omei.DLL.DS_UserInfoTableAdapters.DriversTableAdapter adp = new com.Omei.DLL.DS_UserInfoTableAdapters.DriversTableAdapter();
            if (e.CommandArgument != null)
            {
                adp.DelDriver(Convert.ToInt32(e.CommandArgument));
                lstDriver.DataBind();
            }
            
        }

    }
}
