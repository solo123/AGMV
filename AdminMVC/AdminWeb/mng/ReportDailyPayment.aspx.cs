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

public partial class ReportDailyPayment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DateTime dt = PageTools.GetSavedDate("ReportDate", null);
            if (dt == null || dt.Year < 2005)
                dt = DateTime.Now;

            PageTools.GetSavedDate("ReportDate", dt.ToShortDateString());

            DateInputCtl1.DateValue = dt;
            lstPayment.DataBind();
        }

        GridViewHelper helper = new GridViewHelper(this.lstPayment);
        helper.RegisterSummary("amount", SummaryOperation.Sum);

    }
}
