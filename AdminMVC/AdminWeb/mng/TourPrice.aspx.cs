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

public partial class TourPrice : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            // ȡ�i����ԃ�l��
            if (Session["Prof_TourType"] != null)
                selectTourType.SelectedValue = Session["Prof_TourType"].ToString();

        }
    }

}
