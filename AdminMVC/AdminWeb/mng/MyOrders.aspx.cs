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

public partial class MyOrders :AdminList
{
    protected void Page_Load(object sender, EventArgs e)
    {
        base.EditPageUrl = "OrderDetail.aspx";
        if (!Page.IsPostBack)
        {
            D_LoginUserInfo ui = Session["LoginUserInfo"] as D_LoginUserInfo;
            OrderDataset.SelectParameters["employeeID"].DefaultValue = ui.userId.ToString();
        }
    }
    protected void lstOrder_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row;
        if (row.RowType == DataControlRowType.DataRow)
        {
            Label lb = row.FindControl("lbTourName") as Label;
            if (lb != null)
            {
                int ot = Convert.ToInt32(DataBinder.Eval(row.DataItem, "orderType"));
                if (ot > 0)
                    lb.Text = "[TKT] " + OmeiStatus.GetOmeiStatusText("TicketType", ot, "en");
                else
                    lb.Text = DataBinder.Eval(row.DataItem, "tourName").ToString() + "<br />" + DataBinder.Eval(row.DataItem, "tourName_cn").ToString();
            }
        }

        base.RowOnMouseOverEvent(e.Row, "orderId");
    }


}
