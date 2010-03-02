using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;

namespace com.Omei.BLL.Admin
{
    public class DayBalanceBiz : AdminBll
    {
        #region schedules
        public int GenBalanceTable(DateTime balanceDay, int employeeId)
        {
            string sql = @"
delete Balance where status=0;

insert Balance
	select scheduleId, @balanceDay as balanceDay, @employeeId as opEmpId, 0 as status
	from busSchedule
	where startDate<@balanceDay and status=1;";
            SqlParameter[] para = {
                new SqlParameter("@balanceDay", balanceDay),
                new SqlParameter("@employeeId", employeeId)
            };
            return m_dao.ExecuteNoQuery(sql, para);
        }

        public int SchedulesBalance()
        {
            string sql = @"
update busSchedule
	set status=8
    where scheduleId in (select scheduleId from Balance where status=0)
";
            int i = m_dao.ExecuteNoQuery(sql, null);
            return i;
        }
        #endregion

        #region Orders
        public int OrdersBalance()
        {
            string sql = @"
update orders
    set status=8
    where status=3 and scheduleId in (select scheduleId from Balance where status=0 );
";
           int i = m_dao.ExecuteNoQuery(sql, null);
           return i;
        }
        #endregion

        #region AutoGenSchedule
        public string AutoGenSchedule()
        {
            string sql = @"
SELECT TourID, TourName, TourDay, weekly
FROM tours
WHERE (status = 1) AND (autoGenSchedule = 1)";

            System.Text.StringBuilder sb = new StringBuilder();
            sb.Append(@"
<table width='95%' cellpadding=2 cellspacing=0 border=1 class='DataList'>
    <tr class='list_head'>
        <td>ID</td>
        <td>Schedule Name</td>
        <td># New Added</td>
    </tr>
");    

            IDataReader dr = m_dao.ExecuteReader(sql, null);
            while (dr.Read())
            {
                int tourId = (int)dr["TourID"];
                string weekly = (string)dr["weekly"];
                int tourDay = (byte)dr["TourDay"] - 1;

                int cnt = GenSchedule( tourId, weekly, tourDay);
                if (cnt > 0)
                {
                    sb.Append("<tr><td>");
                    sb.Append(dr["TourID"]);
                    sb.Append("</td><td>");
                    sb.Append(dr["TourName"]);
                    sb.Append("</td><td>");
                    sb.Append(cnt);
                    sb.Append("</td></tr>");
                }
            }
            sb.Append("</table>");
            return sb.ToString();
        }

        public int GenSchedule(int tourId, string weekly, int tourDays)
        {
            int cnt = 0;
            DateTime today = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            for (int i = 0; i < 90; i++)
            {
                DateTime stdate = today.AddDays(i);
                if (weekly.IndexOf(stdate.DayOfWeek.ToString("d")) >= 0)
                {
                    if (AddSchedule(tourId, stdate, tourDays, 1))
                        cnt++;
                }
            }
            return cnt;
        }
        private bool AddSchedule(int tourId, DateTime startDate, int days, byte createMode)
        {
            int r = 0;
            SqlParameter successFlag = new SqlParameter("@successFlag", r);
            successFlag.Direction = ParameterDirection.Output;
            SqlParameter[] para = {
                new SqlParameter("@tourId", tourId),
                new SqlParameter("@startDate", startDate),
                new SqlParameter("@days", days),
                new SqlParameter("@createMode", createMode),
                successFlag
            };
            m_dao.ExecuteNoQuery("GenSchedule", para, true);

            r = (int)successFlag.Value;
            return (r == 1);
        }
        #endregion

        #region Agent Orders Balance
        public int AgentOrdersBalance()
        {
            string sql = @"
update agentOrders
	set status=8
where status=2 and agentReceivable+additionalDiscount=agentPaid";
            int r = m_dao.ExecuteNoQuery(sql, null);

            AgentInvoiceBalance();

            return r;
        }

        public void AgentInvoiceBalance()
        {
            string sql = @"
update agentInvoice
set payAmount=(select sum(agentPaid) from agentOrders where invoiceID=agentInvoice.invoiceID)
where status<=2

update agentInvoice
set status=8
where status<=2 and payAmount=netTotal";
            m_dao.ExecuteNoQuery(sql, null);
        }
        #endregion

    }
}
