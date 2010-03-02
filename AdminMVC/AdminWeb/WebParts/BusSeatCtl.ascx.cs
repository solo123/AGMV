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

public partial class Controls_BusSeatCtl : System.Web.UI.UserControl
{
    private int m_scheduleId = -1;
    private int m_maxSeats = 0;
    private bool m_isPrintMode = false;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    #region  Ù–‘
    public int ScheduleId
    {
        set { m_scheduleId = value; }
    }
    public int MaxSeats
    {
        set { m_maxSeats = value; }
    }
    public bool IsPrintMode
    {
        set { m_isPrintMode = value; }
    }
    #endregion

    public override void DataBind()
    {
        base.DataBind();
        if (m_isPrintMode)
            Literal1.Text = GenSeatPrintTable();
        else
            Literal1.Text = GenSeatTable();
    }

    private string GenSeatTable()
    {
        if (m_scheduleId < 1 || m_maxSeats < 1)
            return "<table width='100%'><tr><td align='center' class=head01>Empty...</td></tr></table>";

        com.Omei.DLL.DS_SeatsTableAdapters.BusSeatsTableAdapter bdl = new com.Omei.DLL.DS_SeatsTableAdapters.BusSeatsTableAdapter();
        com.Omei.DLL.DS_Seats.BusSeatsDataTable dt = bdl.GetData(m_scheduleId);


        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append(@"
<!-- Seats table blow -->
<table width='100%' border='1' cellspacing='0' cellpadding='4' id='SeatsTable'>
      <tr>
        <td colspan='4' align='left'>&nbsp;</td>
        <td width='24%' align='left' class='seat_fullpay'>
            <input type='checkbox' name='cb' value='0' />
        </td>
      </tr>

");
        // every seat
        System.Text.StringBuilder sbInfo = new System.Text.StringBuilder();
        int status = 0;

        for (int i = 0; i < m_maxSeats; i++)
        {
            if (dt.Count > 0)
            {
                status = 0;
                sbInfo = new System.Text.StringBuilder();
                DataRow[] rows = dt.Select("seatNumber="+(i+1).ToString());
                if (rows.Length > 0)
                {
                    com.Omei.DLL.DS_Seats.BusSeatsRow row = rows[0] as com.Omei.DLL.DS_Seats.BusSeatsRow;
                    sbInfo.Append("\n\n<table width='100%' cellpadding=1 cellspacing=0><tr>");
                    sbInfo.Append("<td align=left>");
                    if (m_isPrintMode)
                    {
                        sbInfo.Append("<B>");
                        sbInfo.Append(i + 1);
                        sbInfo.Append("</B>&nbsp;&nbsp;");
                    }
                    if ( row.pickup!=null && row.pickup!="")
                        sbInfo.Append(row.pickup.Substring(0,1));
                    // show agent
                    if (row.agentId > 0)
                        sbInfo.Append(".A");

                    sbInfo.Append("</td><td align=right><a href='OrderDetail.aspx?id=");
                    sbInfo.Append(row.orderId);
                    sbInfo.Append("'>");
                    sbInfo.Append(row.orderId);
                    sbInfo.Append("</a></td></tr><td colspan=2 align=right>");
                    sbInfo.Append(row.firstName);
                    sbInfo.Append('.');
                    sbInfo.Append(row.lastName);
                    sbInfo.Append("</td></tr><tr><td colspan=2 align=right>");
                    sbInfo.Append(row.contactPhone);
                    sbInfo.Append("</td></tr></table>\n");
                    status = row.status;
                }
            }

            if (i % 4 == 0)
            {
                sb.Append("\n<tr>\n");
            }
            else if ( i% 2 == 0)
            {
                sb.Append("\n<td width='4%' align='left'>&nbsp;</td>\n");
            }

            string tdStyle;
            switch (status)
            {
                case 1:
                    tdStyle = "class='seat_hold'";
                    break;
                case 2:
                    tdStyle = "class='seat_sold'";
                    break;
                case 3:
                    tdStyle = "class='seat_fullpay'";
                    break;
                default:
                    tdStyle = "class='seat_available'";
                    break;
            }

            sb.Append(@"
            <td width='24%' align='left' ");
            //sb.Append(tdStyle);
            sb.Append(">");
            if (m_isPrintMode)
            {
                if (sbInfo.Length == 0)
                    sb.Append("&nbsp;");
                else
                    sb.Append(sbInfo);
            }
            else
            {
                sb.Append(@"
                <table width='100%' cellpadding='2' cellspacing='2' border='0'>
	                <tr>
		                <td nowrap><input type='checkbox' name='cb' value='");
                sb.Append(status);
                sb.Append("' /><b>");
                sb.Append(i + 1);
                sb.Append(@"</b></td>
		                <td align='right' width='100%' ");
                sb.Append(tdStyle);
                sb.Append(" >");
                sb.Append(sbInfo);
                sb.Append(@"
                        </td>
	                </tr>
                </table> 
");
            }
            sb.Append("</td>");

            if (i % 4 == 3)
            {
                sb.Append("\n</tr>\n");
            }
        }

        // finish td
        if (m_maxSeats > 0)
        {
            int ctd = 4 - ((m_maxSeats - 1) % 4);
            if (ctd < 3) ctd--;
            if (ctd > 0)
            {
                sb.Append("<td colspan=");
                sb.Append(ctd);
                sb.Append(">&nbsp;</td></tr>");
            }
        }

        sb.Append("\n</table>\n");
        sb.Append("\n<!-- End of Seats table -->\n\n");

        return sb.ToString();
    }

    private string GenSeatPrintTable()
    {
        if (m_scheduleId < 1 || m_maxSeats < 1)
            return "<table width='100%'><tr><td align='center' class=head01>Empty...</td></tr></table>";

        com.Omei.DLL.DS_SeatsTableAdapters.BusSeatsTableAdapter bdl = new com.Omei.DLL.DS_SeatsTableAdapters.BusSeatsTableAdapter();
        com.Omei.DLL.DS_Seats.BusSeatsDataTable dt = bdl.GetData(m_scheduleId);


        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append(@"
<!-- Seats table blow -->
<table width='100%' border='1' cellspacing='0' cellpadding='2' id='SeatsTable' style='border-collapse:collapse;'>
      <tr>
        <td colspan='4' align='left'>&nbsp;</td>
        <td width='24%' align='left' class='seat_fullpay'>
            <input type='checkbox' name='cb' value='0' />
        </td>
      </tr>

");
        // every seat
        System.Text.StringBuilder sbInfo = new System.Text.StringBuilder();
        int status = 0;

        for (int i = 0; i < m_maxSeats; i++)
        {
            if (dt.Count > 0)
            {
                status = 0;
                sbInfo = new System.Text.StringBuilder();
                DataRow[] rows = dt.Select("seatNumber=" + (i + 1).ToString());
                if (rows.Length > 0)
                {
                    com.Omei.DLL.DS_Seats.BusSeatsRow row = rows[0] as com.Omei.DLL.DS_Seats.BusSeatsRow;
                    sbInfo.Append("\n\n<table width='100%' cellpadding=1 cellspacing=0><tr>");
                    sbInfo.Append("<td align=left>");

                    sbInfo.Append("<B>");
                    sbInfo.Append(i + 1);
                    sbInfo.Append("</B>&nbsp;");

                    // show agent
                    if (row.agentId > 0) sbInfo.Append("/A");

                    sbInfo.Append("</td><td align=right>");
                    sbInfo.Append(row.firstName);
                    sbInfo.Append('.');
                    sbInfo.Append(row.lastName);

                    sbInfo.Append("</td></tr><td align=left>");
                    sbInfo.Append(row.orderId);

                    if (row.pickup != null && row.pickup != "")
                        sbInfo.Append(row.pickup.Substring(0, 1));

                    sbInfo.Append("</td><td align=right>");
                    sbInfo.Append(row.contactPhone);
                    sbInfo.Append("</td></tr></table>\n");
                    status = row.status;
                }
                else
                {
                    sbInfo.Append("<TABLE cellSpacing=0 cellPadding=1 width='100%'><TR><TD align=left><B>");
                    sbInfo.Append(i + 1);
                    sbInfo.Append("</B>&nbsp;</TD><TD align=right>&nbsp;</TD></TR></TABLE>");
                }
            }
            else
            {
                sbInfo = new System.Text.StringBuilder();
                sbInfo.Append("<TABLE cellSpacing=0 cellPadding=1 width='100%'><TR><TD align=left><B>");
                sbInfo.Append(i + 1);
                sbInfo.Append("</B>&nbsp;</TD><TD align=right>&nbsp;</TD></TR></TABLE>");

            }

            sb.Append("<td width='24%' valign=top>");
            sb.Append(sbInfo);
            sb.Append("</td>");

            switch (i % 4)
            {
                case 1:
                    sb.Append("\n<td width='4%' align='left'>&nbsp;</td>\n");
                    break;
                case 3:
                    sb.Append("\n</tr>\n");
                    break;
            }
        }

        // finish td
        if (m_maxSeats > 0)
        {
            int ctd = 4 - ((m_maxSeats - 1) % 4);
            if (ctd < 3) ctd--;
            if (ctd > 0)
            {
                sb.Append("<td colspan=");
                sb.Append(ctd);
                sb.Append(">&nbsp;</td></tr>");
            }
        }

        sb.Append("\n</table>\n");
        sb.Append("\n<!-- End of Seats table -->\n\n");

        return sb.ToString();
    }
}
