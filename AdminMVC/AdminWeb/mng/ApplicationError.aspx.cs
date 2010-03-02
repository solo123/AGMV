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

public partial class ApplicationError : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["CurrentError"] != null)
            {
                D_PageError pe = (D_PageError)Session["CurrentError"];
                txtErrorPage.Text = pe.webPage;
                txtErrorMessage.Text = pe.errorDetail;
                int userId = 0;
                if (Session["UserInfo"] != null)
                {
                    userId = ((D_UserInfo)Session["UserInfo"]).userId;
                }

                EventLog eventLog = new EventLog();
                eventLog.Log("PageError", pe.webPage, pe.errorDetail, userId);
                Session["CurrentError"] = null;

                OmeiMail om = new OmeiMail();
                om.SendMail("PageError", "info", "jimmy@omeitravel.com", "PageError:" + pe.webPage, pe.errorDetail);

            }


        }
    }
}
