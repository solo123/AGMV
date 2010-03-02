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

public partial class EmployeeEdit : AdminBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            string id = Request.QueryString["id"];
            lnkAuth.NavigateUrl = "EmployeeRoleEdit.aspx?id=" + Request.QueryString["id"];
            lnkChgPwd.NavigateUrl = "ChangeSignIn.aspx?id=" + Request.QueryString["id"];
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
