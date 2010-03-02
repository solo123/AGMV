using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.DLL;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class PaymentReportBiz : AdminBll
    {
        #region GetDailyReport
        public DataSet GetDailyReport(DateTime date)
        {
            if (date==null || date.Year > 2010 || date.Year < 2005 ) return null;

            DateTime toDate1 = date.AddDays(1);

            string sql = @"
select p.*, e.nickname from 
(
	(select empID, '' as reason, sum(cash) as cash, sum(creditCard) as creditCard,
		sum([check]) as [check], sum(agent) as agent from (
		select
			payEmployeeId as empID, method, 
			cash = case when method=1 then sum(amount) else 0 end,
			[creditCard] = case when method=2 then sum(amount) else 0 end,
			[check] = case when method=3 then sum(amount) else 0 end,
			[agent] = case when method=4 then sum(amount) else 0 end
			from payment
			where amount>0 and payDate>@fromDate and payDate<@toDate
			group by payEmployeeId, method
		) as p
		group by empID
	)
	union
	(
	select empID, 'refund' as reason, sum(cash) as cash, sum(creditCard) as creditCard,
		sum([check]) as [check], sum(agent) as agent from (
		select
			payEmployeeId as empID, method, 
			cash = case when method=1 then sum(amount) else 0 end,
			[creditCard] = case when method=2 then sum(amount) else 0 end,
			[check] = case when method=3 then sum(amount) else 0 end,
			[agent] = case when method=4 then sum(amount) else 0 end
			from payment
			where amount<0 and payDate>@fromDate and payDate<@toDate
			group by payEmployeeId, method
		) as p
		group by empID
	)
) as p
	left join employeeInfo as e on p.empID=e.employeeID
    order by e.nickname

";
            SqlParameter[] para = {
                new SqlParameter("@fromDate", date),
                new SqlParameter("@toDate", toDate1),
            };

            DataSet ds = m_dao.ExecuteDataSet(sql, para);
            return ds;
        }

        
        #endregion

        #region GetPaymentReportDetail
        public DataSet GetPaymentReportDetail(int employeeID, DateTime fromDate, DateTime toDate)
        {
            if (employeeID <= 0 || fromDate.Year > 2010 || toDate.Year < 2005 || fromDate>toDate) return null;

            DateTime toDate1 = toDate.AddDays(1);

            string sql = @"
select
	p.orderID, p.amount, p.payDate, p.method, p.remark, 
	pe.nickname as payEmployee, oe.nickname as opEmployee
from payment as p
	left join employeeInfo as pe on p.payEmployeeID=pe.employeeID
	left join employeeInfo as oe on p.opEmployeeID=oe.employeeID
where p.payEmployeeID=@employeeID and p.payDate>@fromDate and p.payDate<@toDate

";
            SqlParameter[] para = {
                new SqlParameter("@employeeID", employeeID),
                new SqlParameter("@fromDate", fromDate),
                new SqlParameter("@toDate", toDate1),
            };
            return m_dao.ExecuteDataSet(sql, para);
        }
        #endregion
    }
}
