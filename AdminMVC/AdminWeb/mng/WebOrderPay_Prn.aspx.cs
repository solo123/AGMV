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

public partial class WebOrderPay_Prn : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void CCDetailDataset_Updated(object sender, ObjectDataSourceStatusEventArgs e)
    {
        // if update falure
        if ((bool)e.ReturnValue == false)
        {
            lbMsg.Text = "Pay falure! Please check.";
        }

    }
}
