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

using System.Text;
using com.Omei.BLL.Admin;

public partial class ReportEmployeeCommission : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DateTime dt1 = DateTime.Now.AddMonths(-1);
            dt1 = dt1.AddDays(-dt1.Day+1);
            DateTime dt2 = dt1.AddMonths(1).AddDays(-1);

            dateFrom.DateValue = dt1;
            dateTo.DateValue = dt2;
        }

        ShowReport(dateFrom.DateValue, dateTo.DateValue);

    }

    private void ShowReport(DateTime fromDate, DateTime toDate)
    {
        int seleEmpID = 0;
        if (lstEmployee.SelectedIndex >= 0) seleEmpID = Convert.ToInt32(lstEmployee.SelectedValue);
        IMMatchBiz biz = new IMMatchBiz();
        DataSet ds = biz.GetIMCommissionReport(seleEmpID, fromDate, toDate);

        int empID = 0;
        int matchID = 0;

        if (ds != null && ds.Tables.Count > 0)
        {
            lstEmployee.DataSource = ds.Tables[2];
            lstEmployee.DataBind();

            if (seleEmpID > 0)
            {
                foreach (ListItem item in lstEmployee.Items)
                {
                    if (Convert.ToInt32(item.Value) == seleEmpID)
                    {
                        item.Selected = true;
                        break;
                    }
                }
            }

            DataRow[] orders = ds.Tables[1].Select("", "empID,matchID,orderID");
            StringBuilder sb = new StringBuilder();

            sb.Append(@"
<table cellpadding='4' cellspacing='0' class='DataList' border='1' style='border-collapse: collapse;' width='100%'>
    <tr class='list_head'>
        <td align='center'>Order#</td><td align='center'>Schdule#</td><td align='center'>Tour name</td><td align='center'>Deparutre</td>
        <td align='center'>Customer</td><td align='center'>Amount</td><td align='center'>Status</td>
    </tr>
");

            foreach (DataRow row in orders)
            {
                if (empID != (int)row["empID"])
                {
                    if (empID != 0)
                    {
                        // not first line
                    }
                    empID = (int)row["empID"];
                    matchID = 0;
                    sb.Append("<tr class='list_item_alt'><td colspan='7'>");
                    sb.Append("Employee:");
                    sb.Append(row["employeeName"]);
                    sb.Append(" (");
                    sb.Append(row["empID"]);
                    sb.Append(")</td></tr>");
                }

                if (matchID != (int)row["matchID"])
                {
                    matchID = (int)row["matchID"];
                    DataRow[] r = ds.Tables[0].Select("matchID=" + matchID.ToString());
                    if (r.Length > 0)
                    {
                        sb.Append("<tr class='list_item_alt'><td colspan='7'>");
                        DataRow rr = r[0];
                        sb.Append("Match ID:<b>");
                        sb.Append(rr["matchID"]);
                        sb.Append("</b>, Agent Inv# <b>");
                        sb.Append(rr["agentInv"]);
                        sb.Append("</b>, Agent:<i>");
                        sb.Append(rr["agentName"]);
                        sb.Append(" (");
                        sb.Append(rr["agentID"]);
                        sb.Append(")</i><br />Cost:<b>");
                        sb.Append(rr["cost"]);
                        sb.Append("</b>, Tax:<b>");
                        sb.Append(rr["tax"]);
                        sb.Append("</b>, Profit:<b>");
                        sb.Append(rr["profit"]);
                        sb.Append("</b>, Amount:<b>" );
                        sb.Append(rr["matchAmount"]);
                        sb.Append("</b>, Match date:<i>");
                        sb.Append(rr["matchDate"]);
                        sb.Append("</i></td></tr>");
                        
                    }
                }

                sb.Append("<tr class='list_item'><td align='center'>");
                sb.Append(row["orderID"]);
                sb.Append("</td><td align='center'>");
                sb.Append(row["scheduleID"]);
                sb.Append("</td><td>");
                sb.Append(row["tourName"]);
                sb.Append("</td><td align='center'>");
                if (row["startDate"] is DBNull)
                {
                    sb.Append("[CANCLED]");
                } else
                    sb.Append(((DateTime)row["startDate"]).ToShortDateString());
                sb.Append("</td><td>");
                sb.Append(row["firstname"]);
                sb.Append(" ");
                sb.Append(row["lastname"]);
                sb.Append("</td><td align='right'>");
                sb.Append(row["actualAmount"]);
                sb.Append("</td><td align='center'>");
                sb.Append(OmeiStatus.GetOmeiStatusText("OrderStatus", row["status"], "en"));
                sb.Append("</td></tr>");

            }
            sb.Append("</table>");
            lstReport.Text = sb.ToString();
        }

    }
}
