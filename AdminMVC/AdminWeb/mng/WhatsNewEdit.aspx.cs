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

public partial class Admin_WhatsNewEdit : AdminBase
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if(Request.QueryString["id"]==null)
            {
                fvWhatsnew.ChangeMode(FormViewMode.Insert);
            }
        }
    }
    protected void fvWhatsnew_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        WhatsNewDataset.UpdateParameters["userId"].DefaultValue = ((D_LoginUserInfo)Session["LoginUserInfo"]).userId.ToString();
    }
}
