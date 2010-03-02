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

using com.Omei.BLL;
using com.Omei.OmeiDataSet;

public partial class Controls_CountrySelector : System.Web.UI.UserControl
{
    private string m_lang = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            lstCountry.DataBind();
        }
    }

    #region  Ù–‘
    public string Lang
    {
        set { m_lang = value; }
    }
    
    public string CountryCode
    {
        set
        {
            lstCountry.SelectedValue = value;
        }
        get
        {
            return lstCountry.SelectedValue;
        }
    }
    #endregion

}
