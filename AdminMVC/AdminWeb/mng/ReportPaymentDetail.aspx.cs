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
using com.Omei.DLL;

public partial class ReportPaymentDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DateTime dt1 = PageTools.GetSavedDate("ReportDate", null);
            if (dt1.Year < 2005) dt1 = DateTime.Now;

            PageTools.GetSavedDate("ReportDate", dt1.ToShortDateString());
            dateFrom.DateValue = dt1;
            dateTo.DateValue =dt1;

            int employeeID = PageTools.ParseInt(Request.QueryString["id"]);
            if (employeeID>0)
            {
                EmployeeBiz biz = new EmployeeBiz();
                lbEmployeeName.Text = biz.GetEmployeeName(employeeID);
            }
        }

        GridViewHelper helper = new GridViewHelper(this.lstReport);
        helper.RegisterSummary("amount", SummaryOperation.Sum);
    }
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        PageTools.GetSavedDate("ReportDate", dateFrom.DateValue.ToShortDateString());
        lstReport.DataBind();
    }
}
