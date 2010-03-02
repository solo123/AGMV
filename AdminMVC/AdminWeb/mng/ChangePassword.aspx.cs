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

public partial class ChangePasswordPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtPassword.Attributes.Add("onKeyUp", "updatestrength( this.value );");
        }
    }
 
    protected void btnChangePwd_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            lbPwdMsg.Text = "";

            D_LoginUserInfo ui = Session["LoginUserInfo"] as D_LoginUserInfo;

            EmployeeBiz biz = new EmployeeBiz();
            if (biz.ChangeMyPassword(ui.userId, txtOldPassword.Text, txtPassword.Text) == false)
            {
                lbPwdMsg.Text = "原密码不正确，请检查。";
                txtOldPassword.Focus();
            }
            else
                lbPwdMsg.Text = "密码已修改.";
        }
    }

}
