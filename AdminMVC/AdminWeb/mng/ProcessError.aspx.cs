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

public partial class ProcessError : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            lbMsg.Text = (Session["ProcessError"]!=null)? Session["ProcessError"].ToString() : "";
            string nav = (Session["PreNav"]!=null)? Session["PrevNav"].ToString() : "";

            if (nav == null || nav == "")
                lnkBack.Visible = false;
            else
                lnkBack.NavigateUrl = nav;
        }
    }
}
