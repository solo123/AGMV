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

public partial class ChangeSignIn : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["id"] != null)
            {
                if (!PageLogic.CheckActionAuth("ChangeEmployeePassword"))
                {
                    PageLogic.ShowError("Access Denided.", "MyAccount.aspx");
                    return;
                }
                int employeeID = PageTools.GetSavedId("EmployeeID", Request.QueryString["id"]);
                pnOldPsw.Visible = false;
            }
            else
            {
                D_LoginUserInfo ui = Session["LoginUserInfo"] as D_LoginUserInfo;
                int employeeID = PageTools.GetSavedId("EmployeeID", ui.userId.ToString());
            }

            txtPassword.Attributes.Add("onKeyUp", "updatestrength( this.value );");
        }
    }
 
    protected void btnChangeSign_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            int employeeID = PageTools.GetSavedId("EmployeeID", null);
            if (employeeID == 0)
            {
                lbMsg.Text = "没有指定employee";
                return;
            }

            EmployeeBiz biz = new EmployeeBiz();
            if (biz.ChangeLoginName(employeeID, txtSign.Text))
            {
                if (Request.QueryString["id"]==null)
                    Response.Redirect("MyAccount.aspx");
                else
                    Response.Redirect("EmployeeEdit.aspx?id=" + employeeID.ToString(), true);
            } 
            else
            {
                lbMsg.Text = "登录名<b>" + txtSign.Text + "</b>已经被用户使用或不合法，请重新输入用户名。";
            }
        }
    }
    protected void btnChangePwd_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            lbPwdMsg.Text = "";

            int employeeID = PageTools.GetSavedId("EmployeeID", null);
            if (employeeID == 0)
            {
                lbPwdMsg.Text = "没有指定employee";
                return;
            }

            EmployeeBiz biz = new EmployeeBiz();
            if (Request.QueryString["id"] == null)
            {
                if (biz.ChangeMyPassword(employeeID, txtOldPassword.Text, txtPassword.Text) == false)
                {
                    lbPwdMsg.Text = "原密码不正确，请检查。";
                    txtOldPassword.Focus();
                }
                else
                    Response.Redirect("MyAccount.aspx");
            }
            else
            {
                if (biz.ChangePassword(employeeID, txtPassword.Text) == false)
                {
                    lbPwdMsg.Text = "密码修改失败，请检查。";
                    txtPassword.Focus();
                }
                else
                    Response.Redirect("EmployeeEdit.aspx?id=" + employeeID.ToString(), true);
            }
        }

    }

}
