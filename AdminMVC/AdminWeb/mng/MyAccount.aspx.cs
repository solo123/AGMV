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
using com.Omei.OmeiDataSet;

public partial class MyAccount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            D_LoginUserInfo ui = Session["LoginUserInfo"] as D_LoginUserInfo;
            EmployeeDataset.SelectParameters["employeeID"].DefaultValue = ui.userId.ToString();
            lnkChgPwd.NavigateUrl = "ChangeSignIn.aspx";
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        fvEmployee.UpdateItem(true);
    }

    protected string ShowRoles(object employeeID)
    {
        if (employeeID == null) return string.Empty;
        EmployeeBiz biz = new EmployeeBiz();
        return biz.GetUserRoleNameList((int)employeeID);
    }
    protected string ShowPositions(object employeeID)
    {
        if (employeeID == null) return string.Empty;
        EmployeeBiz biz = new EmployeeBiz();
        return biz.GetUserPositionNameList((int)employeeID);
    }

}
