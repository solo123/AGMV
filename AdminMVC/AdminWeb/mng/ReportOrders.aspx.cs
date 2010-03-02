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

public partial class ReportOrders : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            dateFrom.DateValue = PageTools.GetSavedDate("FromDate", DateTime.Now.ToShortDateString());
            dateTo.DateValue = PageTools.GetSavedDate("ToDate", DateTime.Now.ToShortDateString());

            GetData();
        }

    }

    protected void btnDaily_Click(object sender, EventArgs e)
    {
        dateFrom.DateValue = PageTools.GetSavedDate("FromDate", DateTime.Now.ToShortDateString());
        dateTo.DateValue = PageTools.GetSavedDate("ToDate", DateTime.Now.ToShortDateString());
        GetData();
    }
    protected void btnMonthly_Click(object sender, EventArgs e)
    {
        DateTime dt = DateTime.Now;
        DateTime fromDt = new DateTime(dt.Year, dt.Month, 1);
        DateTime toDt = (new DateTime(dt.Year, dt.Month + 1, 1)).AddDays(-1);

        dateFrom.DateValue = PageTools.GetSavedDate("FromDate", fromDt.ToShortDateString());
        dateTo.DateValue = PageTools.GetSavedDate("ToDate", toDt.ToShortDateString());
        GetData();
    }
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        PageTools.GetSavedDate("FromDate", dateFrom.DateValue.ToShortDateString());
        PageTools.GetSavedDate("ToDate", dateTo.DateValue.ToShortDateString());
        GetData();
    }

    private void GetData()
    {
        SalesReportBiz biz = new SalesReportBiz();
        DataSet ds = biz.GetOrders(dateFrom.DateValue, dateTo.DateValue);
        lstOrders.DataSource = ds;
        lstOrders.DataBind();
    }
}
