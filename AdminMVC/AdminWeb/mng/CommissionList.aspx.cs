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

public partial class Admin_CommissionList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void lstCommission_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        e.NewValues["ui"] = Session["LoginUserInfo"];
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        CommissionBiz biz = new CommissionBiz();
        biz.AddNewCommission((com.Omei.OmeiDataSet.D_LoginUserInfo)Session["LoginUserInfo"]);

        lstCommission.DataBind();
    }
}
