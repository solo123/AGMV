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

public partial class ReportSalesDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            dateFrom.DateValue = PageTools.GetSavedDate("FromDate", null);
            dateTo.DateValue = PageTools.GetSavedDate("ToDate", null);

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
}
