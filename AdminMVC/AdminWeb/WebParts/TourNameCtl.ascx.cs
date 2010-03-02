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
using com.Omei.OmeiAdminData;

public partial class WebParts_TourNameCtl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #region ÊôÐÔ: TourID
    public int TourID
    {
        set
        {
            if (value > 0)
            {
                AdminTourBiz biz = new AdminTourBiz();
                D_TourInfo ti = biz.GetTourInfo(value);
                if (ti != null && ti.tourId == value)
                {
                    lbTourName.Text = ti.tourName + " / " + ti.tourName_cn + " (" + ti.tourId.ToString() + ")";
                }
            }
        }
    }
    #endregion
}
