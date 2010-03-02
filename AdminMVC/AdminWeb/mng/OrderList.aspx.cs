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

public partial class OrderList :AdminList
{
    private bool isQueryAll = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        base.EditPageUrl = "OrderDetail.aspx";
        if (!Page.IsPostBack)
        {
        }

    }


    #region QueryOrderCondition
    public D_QueryOrderCondition QueryOrderCondition
    {
        get
        {
            D_QueryOrderCondition qc = new D_QueryOrderCondition();
            qc.ScheduleID = PageTools.ParseInt(inpScheduleId.Text);
            qc.CustomerName = inpCustName.Text;
            qc.Phone = inpPhone.Text;
            qc.StartDate = dateFrom.DateValue;
            qc.EndDate = dateTo.DateValue;
            qc.Status = PageTools.ParseInt(lstStatus.SelectedValue);
            return qc;
        }
    }
    #endregion

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

    
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        lstOrder.DataBind();
    }
    protected void OrderDataset_Selecting(object sender, ObjectDataSourceSelectingEventArgs e)
    {
        if (isQueryAll)
        {
            D_QueryOrderCondition qc = new D_QueryOrderCondition();
            qc.IsGetAll = true;
            e.InputParameters["condition"] = qc;
        }
        else
            e.InputParameters["condition"] = this.QueryOrderCondition;
    }
    protected void btnAllOrders_Click(object sender, EventArgs e)
    {
        isQueryAll = true;
        lstOrder.DataBind();
    }
}
