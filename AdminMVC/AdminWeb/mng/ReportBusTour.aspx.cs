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

public partial class ReportBusTour : System.Web.UI.Page
{
    private int m_book=0, m_actual=0, m_schedules=0;
    private decimal m_rooms=0, m_salesAmount=0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            inpDateFrom.DateValue = DateTime.Now.AddDays(1 - DateTime.Now.Day);
            DateTime dt = DateTime.Now.AddMonths(1);
            inpDateTo.DateValue = dt.AddDays( - dt.Day);
        }
    }
    protected void lstReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row;
        if (row.RowType == DataControlRowType.DataRow)
        {
            m_schedules += (int)DataBinder.Eval(row.DataItem, "scheduleCount");
            m_book += (int)DataBinder.Eval(row.DataItem, "bookCustomers");
            m_actual += (int)DataBinder.Eval(row.DataItem, "actualCustomers");
            m_rooms += (decimal)DataBinder.Eval(row.DataItem, "actualRooms");
            m_salesAmount += (decimal)DataBinder.Eval(row.DataItem, "salesAmount");
        }
        else if (row.RowType == DataControlRowType.Footer)
        {
            Label lbSchedules = row.FindControl("lbTotScheduleCount") as Label;
            Label lbBook = row.FindControl("lbTotBookCustomers") as Label;
            Label lbActual = row.FindControl("lbTotActualCustomers") as Label;
            Label lbRooms = row.FindControl("lbTotActualRooms") as Label;
            Label lbSales = row.FindControl("lbTotSalesAmount") as Label;

            lbSchedules.Text = m_schedules.ToString();
            lbBook.Text = m_book.ToString();
            lbActual.Text = m_actual.ToString();
            lbRooms.Text = m_rooms.ToString("N1");
            lbSales.Text = m_salesAmount.ToString("N2");

        }
    }
}
