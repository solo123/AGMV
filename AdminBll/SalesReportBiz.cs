using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.DLL;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class SalesReportBiz : AdminBll
    {
        #region GetSalesReport
        public DataSet GetSalesReport(DateTime fromDate, DateTime toDate)
        {
            if (fromDate.Year > 2010 || toDate.Year < 2005 || fromDate>toDate) return null;
            DateTime toDate1 = toDate.AddDays(1);

            string sql = @"
select s.*, e.nickName
from (
select 
	empID,
	sum(cash) as cash, sum(creditCard) as creditCard, sum([check]) as [check], 
	sum(agent) as agent
from (
select
	o.empID, sum(p.amount) as cash, 0 as creditCard, 0 as [check], 0 as agent
from payment as p
	left join orders as o on p.orderID=o.orderID

where o.empID>0 and method=1 and payDate>@fromDate and payDate<@toDate
group by o.empID


union

select
	o.empID, 0 as cash, sum(p.amount) as creditCard,0 as [check], 0 as agent
from payment as p
	left join orders as o on p.orderID=o.orderID

where o.empID>0 and method=2 and payDate>@fromDate and payDate<@toDate
group by o.empID

union
select
	o.empID, 0 as cash, 0 as creditCard, sum(p.amount) as [check], 0 as agent
from payment as p
	left join orders as o on p.orderID=o.orderID

where o.empID>0 and method=3 and payDate>@fromDate and payDate<@toDate
group by o.empID

union
select
	o.empID, 0 as cash, 0 as creditCard, 0 as [check], sum(p.amount) as agent
from payment as p
	left join orders as o on p.orderID=o.orderID

where o.empID>0 and method=4 and payDate>@fromDate and payDate<@toDate
group by o.empID
) as salesReport
group by empID
) as s
	left join employeeInfo as e on s.empID=e.employeeID
order by s.empID

";
            SqlParameter[] para = {
                new SqlParameter("@fromDate", fromDate),
                new SqlParameter("@toDate", toDate1),
            };

            DataSet ds = m_dao.ExecuteDataSet(sql, para);
            return ds;
        }
        #endregion

        #region GetSalesReportDetail
        public DataSet GetSalesReportDetail(int employeeID, DateTime fromDate, DateTime toDate)
        {
            if (employeeID <= 0 || fromDate.Year > 2010 || toDate.Year < 2005 || fromDate>toDate) return null;

            DateTime toDate1 = toDate.AddDays(1);

            string sql = @"
select
	p.orderID, p.amount, p.payDate, p.method, p.remark, 
	pe.nickname as payEmployee, oe.nickname as opEmployee
from payment as p
	left join orders as o on p.orderID=o.orderID
	left join employeeInfo as pe on p.payEmployeeID=pe.employeeID
	left join employeeInfo as oe on p.opEmployeeID=oe.employeeID
where o.empID=@employeeID and p.payDate>@fromDate and p.payDate<@toDate

";
            SqlParameter[] para = {
                new SqlParameter("@employeeID", employeeID),
                new SqlParameter("@fromDate", fromDate),
                new SqlParameter("@toDate", toDate1),
            };
            return m_dao.ExecuteDataSet(sql, para);
        }
        #endregion

        #region GetOrders
        public DataSet GetOrders(DateTime fromDate, DateTime toDate)
        {
            string sql = @"
select t.tourID, t.tourName, t.tourName_cn,
    o.scheduleID, pickup, 
    numberAdult, numberChild, numberFree, bookRooms, 
    actualAmount, pay, empID, agentID
from orders as o
	left join busSchedule as s on o.scheduleID=s.scheduleID
	left join tours as t on s.tourID=t.tourID
where orderDate>=@fromDate and orderDate<@toDate";
            SqlParameter[] para = {
                new SqlParameter("@fromDate", fromDate),
                new SqlParameter("@toDate", toDate),
            };
            return m_dao.ExecuteDataSet(sql, para);
        }
        #endregion
    }
}
