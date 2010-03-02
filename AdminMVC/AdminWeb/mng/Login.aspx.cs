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

using com.Omei.BLL.Authenticate;

public partial class LoginPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        txtUsername.Focus();
        
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["logout"] != null)
            {
                Session.Clear();
            }
        }
    }


    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            UserLoginBiz loginBiz = new UserLoginBiz();
            if (loginBiz.UserLogin(txtUsername.Text, txtPassword.Text))
            {
                Session["LoginUserInfo"] = loginBiz.loginUserInfo;
                Response.Redirect("../mng/Welcome.aspx");
            }
            else
            {
                Session.Clear();
                txtLoginMessage.Text = "用戶名或密碼不對，請重新登錄。<br />(允许登录时间 7:00am～20:59pm)";
            }
        }
    }
}
