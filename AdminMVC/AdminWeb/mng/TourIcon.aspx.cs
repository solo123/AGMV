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

public partial class TourIcon : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            // 取齣最后查詢條件
            if (Session["Prof_TourType"] != null)
                selectTourType.SelectedValue = Session["Prof_TourType"].ToString();

        }

    }

    #region 鼠標單擊行選中
    protected void lstTours_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row;
        if (row.RowType == DataControlRowType.DataRow)
        {
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
            row.Attributes.Add("onclick", "prepareUpload(this, '" + DataBinder.Eval(row.DataItem, "TourID") + "')");
            row.Style["cursor"] = "hand";
        }
    }
    #endregion
}
