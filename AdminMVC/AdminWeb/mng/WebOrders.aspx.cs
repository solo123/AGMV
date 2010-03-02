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

using com.Omei.OmeiDataSet;

public partial class WebOrders :AdminList
{
    protected void Page_Load(object sender, EventArgs e)
    {
        base.EditPageUrl = "OrderDetail.aspx";
    }
    protected void lstOrder_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        base.RowOnMouseOverEvent(e.Row, "orderId");
    }

}
