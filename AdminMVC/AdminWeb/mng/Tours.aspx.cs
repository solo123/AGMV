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

public partial class Tours : AdminList
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    #region 鼠標單擊行選中
    protected void lstTourList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row;
        if (row.RowType == DataControlRowType.DataRow)
        {
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
            row.Attributes.Add("onclick", "itemClick('TourDetail.aspx?id=" + DataBinder.Eval(row.DataItem, "tourId") + "')");
        }
    }
    #endregion
}
