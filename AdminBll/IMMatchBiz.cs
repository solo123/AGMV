using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.OmeiDataSet;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class IMMatchBiz : AdminBll
    {
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetInvoiceList()
        {
            string sql = @"
select 
	matchID, agentID, 
	(select companyName + '/' + companyName_cn from company where company.companyID=agentID) as agentName,
    agentInv, 
	cost, tax, matchAmount, profit, matchDate, 
	opEmployee, (select nickname from employeeInfo where employeeID=opEmployee) as opEmployeeName,
	matchOrders, status
from invoiceMatch
order by matchID desc";

            return m_dao.ExecuteDataSet(sql, null);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetAgentTransforSum()
        {
            string sql = @"
select o.*, c.companyName, c.discount, c.maxcredit from
(select sum(actualAmount) as amount,count(*) as cnt, agentTransfor as agentID
from orders
where agentTransfor>0 and matchID=0
group by agentTransfor) o
	left join company c on o.agentID=c.companyId";
            return m_dao.ExecuteDataSet(sql, null);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetInvoiceDetail(int matchID)
        {
            string sql = @"
select * from invoiceMatch
where matchID=@matchID";
            SqlParameter[] para = { new SqlParameter("@matchID", matchID), };
            return m_dao.ExecuteDataSet(sql, para);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetMatchedOrders(int matchID)
        {
            if (matchID <= 0) return null;

            string sql = @"
select 
	o.orderId, o.scheduleId, o.orderType, t.tourName, t.tourName_cn,
	b.startDate,
	o.numberAdult, o.numberChild, o.numberFree,
	o.firstName, o.lastName,
	o.contactPhone, o.status, o.orderDate, e.nickname
from orders as o
	left join busSchedule as b on o.scheduleId=b.scheduleId
	left join tours as t on b.tourId=t.tourId
	left join employeeInfo as e on o.empId=e.employeeID
where o.matchID=@matchID
order by orderId desc";
            SqlParameter[] para = { new SqlParameter("@matchID", matchID), };
            return m_dao.ExecuteDataSet(sql, para);
        }

        public void UpdateAgentInv(object userLoginInfo, int matchID, string agentInv)
        {
            string sql = @"
update invoiceMatch
set agentInv=@agentInv
where matchID=@matchID";
            SqlParameter[] para = {
                new SqlParameter("@matchID", matchID),
                new SqlParameter("@agentInv", agentInv),
            };
            m_dao.ExecuteNoQuery(sql, para);
            EventLog.OpLog(userLoginInfo, "Change match invoice agent INV# to " + agentInv, 6, matchID);

        }

        #region Invoice Match!
        public int MatchInvoice(object loginUserAccount, DataEntity.DT_InvoiceMatch imatch) 
        {
            if (imatch.AgentID <= 0 || imatch.Cost <= 0 || imatch.Orders.Count<1 )
                return -1;

            D_LoginUserInfo ui = loginUserAccount as D_LoginUserInfo;
            if (ui == null) return -2;
            imatch.Operator = ui.userId;

            string sql = @"
insert into invoiceMatch
(agentID,agentInv, paymentMethod, notes, cost, tax, matchAmount, profit, matchDate, opEmployee, matchOrders)
values
(@agentID, @agentInv, @paymentMethod, @notes, @cost, @tax, 0, 0, getdate(), @opEmployee, '');
select SCOPE_IDENTITY();";
            SqlParameter[] para = {
                new SqlParameter("@opEmployee", ui.userId),
                new SqlParameter("@agentID", imatch.AgentID),
                new SqlParameter("@agentInv", imatch.AgentInv),
                new SqlParameter("@cost", imatch.Cost),
                new SqlParameter("@tax", imatch.Tax),
                new SqlParameter("@paymentMethod", imatch.PaymentMethod),
                new SqlParameter("@notes", imatch.Notes),
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null)
                return 0;
            else
            {
                int matchID = Convert.ToInt32(o);
                foreach (DataEntity.DT_InvoiceMatchOrder order in imatch.Orders)
                {
                    string s = @"
insert into invoiceMatchOrders 
(matchID, orderID, cost,amount,profit) 
values 
(@matchID, @orderID, @cost,0,0);
update orders set matchID=@matchID
where orderID=@orderID;
";
                    SqlParameter[] p = {
                        new SqlParameter("@matchID", matchID),
                        new SqlParameter("@orderID", order.OrderID),
                        new SqlParameter("@cost", order.Cost),
                                       };
                    m_dao.ExecuteNoQuery(s, p);
                }

                sql = @"
update invoiceMatchOrders
set amount=o.actualAmount, profit=o.actualAmount-m.cost
from invoiceMatchOrders m, orders o
where m.matchID=@matchID and o.orderID=m.orderID;

update invoiceMatch
set matchAmount=m.amount, profit=m.profit
from 
(
select sum(amount) as amount, sum(profit) as profit
from invoiceMatchOrders
where matchID=@matchID 
) as m
where matchID=@matchID;
";
                SqlParameter[] pp = { new SqlParameter("@matchID", matchID) };
                m_dao.ExecuteNoQuery(sql, pp);

                return matchID;
            }
        }
        #endregion

        #region Cancel Matched Invoice
        public void CancelMatchedInvoice(object userLoginAccount, int matchID)
        {
            string sql = @"
update invoiceMatch
    set status=7
where matchID=@matchID;

update orders
    set matchID=0
where matchID=@matchID;
";
            SqlParameter[] para = {
                new SqlParameter("@matchID", matchID),
            };
            m_dao.ExecuteDataSet(sql, para);
        }
        #endregion

        #region commission report
        public DataSet GetIMCommissionReport(int empID, DateTime startDate, DateTime endDate)
        {
            string dateRange = "";
            if (!(startDate==null)) dateRange+= " matchDate>=@startDate";
            if (!(endDate==null))
            {
                if (dateRange.Length>0) dateRange += " and ";
                dateRange += "matchDate<=@endDate";
            }
            if (dateRange.Length>0) dateRange = " where " + dateRange;

            string sql = @"
select *, 
(select companyName+' / '+companyName_cn from company where companyID=invoiceMatch.agentID) as agentName 
from invoiceMatch" + dateRange + @"

select *,
(select nickname from employeeInfo where employeeID=orders.empID) as employeeName,
(select startDate from busSchedule where scheduleID=orders.scheduleID) as startDate,
(select tourName from tours where tourID=(select tourID from busSchedule where scheduleID=orders.scheduleID)) as tourName
from orders
where matchID in (
	select matchID from invoiceMatch " + dateRange + @"
	)
";
            if (empID > 0)
            {
                sql += " and empID=" + empID.ToString();
            }

            sql += 
@"

select distinct empID, (select nickname from employeeInfo where employeeID=orders.empID) as employee
from orders
where matchID in (
	select matchID from invoiceMatch " + dateRange + @"
	)
";
            SqlParameter[] para = {
                new SqlParameter("@startDate", startDate),
                new SqlParameter("@endDate", endDate),
            };
            return m_dao.ExecuteDataSet(sql, para);
        }
        #endregion
    }
}
