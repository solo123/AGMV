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
public partial class Controls_PubControls_CtlLb_EmployeeName : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public int EmployeeID
    {
        set
        {
            if (value > 0)
            {
                EmployeeBiz biz = new EmployeeBiz();
                lbEmployeeName.Text = biz.GetEmployeeNameByID(value);
            }
        }
    }
}
