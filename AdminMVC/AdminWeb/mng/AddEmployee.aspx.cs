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

public partial class AddEmployee : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            EmployeeBiz biz = new EmployeeBiz();
            int employeeId = biz.AddEmployee(txtLoginName.Text, txtPassword.Text);
            if (employeeId > 0)
            {
                Response.Redirect("EmployeeEdit.aspx?id=" + employeeId.ToString());
            }
            else
                lbMsg.Text = "添加失敗！用戶名與已有用戶名重復。";

        }

    }
}
