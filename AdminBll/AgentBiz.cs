using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.DLL;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class AgentBiz : AdminBll
    {
        #region GenAgentBill _noused
        public int GenAgentInvoice_noused(int agentID, string orderList, int userID)
        {
            if (orderList == null || string.Empty == orderList) return 0;

            string sql = @"
if (( select count(*) from agentOrders where orderID in ("+ orderList + @") and status=1 and agentID=@agentID ) = 0 ) or 
   (( select count(*) from agentOrders where orderID in ("+ orderList + @") and (status!=1 or agentID!=agentID)) > 0 )
begin
    select 0;
    return;
end

declare @invoiceID int;

insert into agentInvoice
(agentID, createDate, lastUpdate, creator, updator, status)
values
(@agentID, getdate(), getdate(), @userID, @userID, 0);

select @invoiceID=SCOPE_IDENTITY();

update agentOrders
    set invoiceID=@invoiceID, reportDate=getdate(), status=2
where agentID=@agentID and orderID in ("+ orderList + @");

update agentInvoice
set amount=t.amount, commission=t.commission, netTotal=t.netTotal, payAmount=t.payAmount
from
(
    SELECT 
        sum(fare + miscCharge) as amount,
        sum((fare + miscCharge) - (agentReceivable-additionalDiscount)) as commission,
	    sum(agentReceivable-additionalDiscount) as netTotal, 
	    sum(agentPaid) as payAmount
    FROM AgentOrders
    WHERE orderID in ("+orderList+ @")
) as t
where invoiceID=@invoiceID;

select @invoiceID;
";
            SqlParameter[] para = {
                new SqlParameter("@agentID", agentID),
                new SqlParameter("@userID", userID),
            };

            object o = m_dao.ExecuteScalar(sql, para);
            return Convert.ToInt32(o);
        }
        #endregion

        #region AgentReceivable Query _ noused
        /// <summary>
        /// query agent orders by status
        /// </summary>
        /// <param name="status"></param>
        /// <returns></returns>
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Agent.AgentReceivablesDataTable AgentReceivablesQuery_noused()
        {
            string sql = @"
SELECT a.invoiceID, a.orderID, o.firstName+'.'+o.lastName as username,
    a.agentID, a.agentReceivable, a.additionalDiscount, a.agentPaid, a.orderClosedDate, a.reportDate,
    c.companyName, c.companyName_cn, a.status
FROM AgentOrders AS a 
    left join Company AS c ON a.agentID = c.companyId
    left join orders as o on a.orderID=o.orderID
WHERE a.status<2
ORDER BY c.companyName";

            DS_Agent ds = new DS_Agent();
            m_dao.FillDataSet(ds, "AgentReceivables", sql, null);
            return ds.AgentReceivables;
        }

        

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Agent.AgentReceivablesDataTable AgentNewReceivableByAgentID_noused(int agentID)
        {

            string sql = @"
SELECT a.invoiceID, a.orderID, o.firstName+'.'+o.lastName as username,
    a.agentID, a.agentReceivable, a.additionalDiscount, a.agentPaid, a.agentReceivable-a.additionalDiscount-agentPaid as balance, a.orderClosedDate, a.reportDate,
    c.companyName, c.companyName_cn, a.status
FROM AgentOrders AS a 
    left join Company AS c ON a.agentID = c.companyId
    left join orders as o on a.orderID=o.orderID
WHERE a.agentID=@agentID and a.invoiceID=0
ORDER BY a.orderID desc";

            DS_Agent ds = new DS_Agent();
            SqlParameter[] para = {
                new SqlParameter("@agentID", agentID)
            };
            m_dao.FillDataSet(ds, "AgentReceivables", sql, para);
            return ds.AgentReceivables;
        }

        /// <summary>
        /// get active agent order by agent id
        /// </summary>
        /// <param name="agentID"></param>
        /// <returns></returns>
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Agent.AgentReceivablesDataTable AgentReceivableByInvoiceID_noused(int invoiceID)
        {

            string sql = @"
SELECT a.invoiceID, a.orderID, o.firstName+'.'+o.lastName as username,
    a.agentID, a.agentReceivable, a.additionalDiscount, a.agentPaid, a.orderClosedDate, a.reportDate,
    c.companyName, c.companyName_cn, a.status
FROM AgentOrders AS a 
    left join Company AS c ON a.agentID = c.companyId
    left join orders as o on a.orderID=o.orderID
WHERE a.invoiceID=@invoiceID
ORDER BY a.orderID desc";

            DS_Agent ds = new DS_Agent();
            SqlParameter[] para = {
                new SqlParameter("@invoiceID", invoiceID)
            };
            m_dao.FillDataSet(ds, "AgentReceivables", sql, para);
            return ds.AgentReceivables;
        }



        #endregion

        #region AgentDiscount
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Agent.AgentReceivablesDataTable AgentReceivableByOrderID_noused(int orderID)
        {
            if (orderID == 0) return null;

            string sql = @"
SELECT a.invoiceID, a.orderID, o.firstName+'.'+o.lastName as username,
    a.agentID, a.agentReceivable, a.additionalDiscount, a.agentPaid, a.orderClosedDate, a.reportDate,
    c.companyName, c.companyName_cn, a.status
FROM AgentOrders AS a 
    left join Company AS c ON a.agentID = c.companyId
    left join orders as o on a.orderID=o.orderID
WHERE a.orderID=@orderID";
            DS_Agent ds = new DS_Agent();
            SqlParameter[] para = {
                new SqlParameter("@orderID", orderID)
            };
            m_dao.FillDataSet(ds, "AgentReceivables", sql, para);
            return ds.AgentReceivables;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public bool UpdateAgentDiscount_noused(int original_orderID, decimal additionalDiscount)
        {
            if (original_orderID == 0) return false;

            string sql = @"
UPDATE AgentOrders
    SET additionalDiscount=@additionalDiscount
WHERE orderID=@orderID
";
            SqlParameter[] para = {
                new SqlParameter("@orderID", original_orderID),
                new SqlParameter("@additionalDiscount", additionalDiscount)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }

        public void SaveAgentDiscount(int agentID, decimal discount)
        {
            if (agentID == 0) return;

            string sql = @"
update company
    set discount=@discount
where companyID=@companyID";
            SqlParameter[] para = {
                new SqlParameter("@companyID", agentID),
                new SqlParameter("@discount", discount)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        public void SaveAgentCredit(int agentID, decimal maxCredit)
        {
            if (agentID == 0) return;

            string sql = @"
update company
    set maxCredit=@maxCredit
where companyID=@companyID";
            SqlParameter[] para = {
                new SqlParameter("@companyID", agentID),
                new SqlParameter("@maxCredit", maxCredit)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        #endregion

        #region Agent Payment
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_AgentPayment.AgentPaymentDataTable GetAgentPaymentsByAgentID_noused(int agentID)
        {
            if (agentID <= 0) return null;

            string sql = @"
SELECT apID, payAmount, payDate, notes, status
FROM AgentPayment
WHERE agentID=@agentID
order by apID desc";
            SqlParameter[] para = {
                new SqlParameter("@agentID", agentID),
            };
            DS_AgentPayment ds = new DS_AgentPayment();
            m_dao.FillDataSet(ds, "AgentPayment", sql, para);
            return ds.AgentPayment;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetAgentPaymentByRecvID(int recvID)
        {
            if (recvID <= 0) return null;

            string sql = @"
select apiID, apID, orderID, payAmount, payDate, matchID, notes,invoiceID, agentID
from agentPaymentItem
where orderID in
(
	select orderID from orders where agentRecvPrintID=@recvID
)
order by orderID";

            SqlParameter[] para = { new SqlParameter("@recvID", recvID), };
            return m_dao.ExecuteDataSet(sql,para);
        }

        public int AgentMatched_noused(int invoiceID, int orderID, decimal payAmount, string matchID, string notes)
        {
            string sql = @"
if (@invoiceID=0) or (@orderID=0) or
((select agentReceivable-agentPaid-@payAmount from agentOrders where orderID=@orderID)< 0 ) or
((select agentPaid+@payAmount from agentOrders where orderID=@orderID)< 0 )
begin
	select 0;
	return;
end

update agentOrders
    set agentPaid =agentPaid+@payAmount
where orderID=@orderID;

update agentOrders
    set status=3
where orderID=@orderID and status<3;


insert agentPaymentItem
(invoiceID, apID, agentID, orderID, payAmount, payDate, matchID, notes)
values
(@invoiceID, 0, 0, @orderID, @payAmount, getdate(), @matchID, @notes)

select SCOPE_IDENTITY();
";
            SqlParameter[] para = {
                new SqlParameter("@invoiceID", invoiceID),
                new SqlParameter("@orderID", orderID),
                new SqlParameter("@payAmount", payAmount),
                new SqlParameter("@matchID", matchID),
                new SqlParameter("@notes", notes),
            };

            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null || o is DBNull)
                return 0;
            else
                return Convert.ToInt32(o);
        }

        public bool isNotDupAgentID_noused(string agentInvoiceID)
        {
            string sql = "select count(*) from agentPayment where agentInvoiceID=@agentInvoiceID";
            SqlParameter[] para = {
                new SqlParameter("@agentInvoiceID", agentInvoiceID),
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null || o is DBNull)
                return true;
            else
                return (Convert.ToInt32(o) == 0);
        }

        public int UpdatePayment(int agentID, decimal payAmount, int payMethod, string notes)
        {
            string sql = @"
insert agentPayment
(agentID, payAmount, payMethod, payDate, notes, status)
values
(@agentID, @payAmount, @payMethod, getdate(), @notes, 1);

select SCOPE_IDENTITY();
";
            SqlParameter[] para = {
                new SqlParameter("@agentID", agentID),
                new SqlParameter("@payAmount", payAmount),
                new SqlParameter("@payMethod", payMethod),
                new SqlParameter("@notes", notes),
            };

            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null || o is DBNull)
                return 0;
            else
                return Convert.ToInt32(o);
        }

        public void UpdatePaymentItem(int agentPaymentID, int orderID, int agentID, decimal payAmount)
        {
            if (orderID == 0 || agentPaymentID == 0 || payAmount==0)
                return;

            string sql = @"
    insert agentPaymentItem
    (orderID, apID, agentID, payAmount)
    values
    (@orderID, @apID, @agentID, @payAmount);

    update Orders
        set agentBillAmount=agentBillAmount+@payAmount
    where orderID=@orderID;
";
            SqlParameter[] para = {
                new SqlParameter("@agentID", agentID),
                new SqlParameter("@orderID", orderID),
                new SqlParameter("@apID", agentPaymentID),
                new SqlParameter("@payAmount", payAmount),
            };
            m_dao.ExecuteNoQuery(sql, para);
        }


        #endregion

        #region ReCal agent receivable
        public int ReCalAgentReceivable_noused(int agentID)
        {
            string sql = @"
update agentOrders
	set agentReceivable=a.fare*(100-c.discount)/100 + a.miscCharge
from agentOrders as a
	left join company as c on a.agentID=c.companyId
where a.status=1";
            if (agentID > 0)
            {
                sql += " and a.agentID=" + agentID.ToString();
            }
            int i = m_dao.ExecuteNoQuery(sql, null);
            return i;
        }

        #endregion

        #region GetAgentInfo
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetAgentInfo(int agentID)
        {
            if (agentID == 0) return null;

            string sql = @"
select 
	companyID as agentID, companyName, companyName_cn, contactPerson, telephone, fax, discount,
	(
select sum(agentCredit-agentBillAmount) from orders
where agentID=@agentID and status!=7
	) as balance

from company
where companyID=@agentID";
            SqlParameter[] para = {
                new SqlParameter("@agentID", agentID),
            };
            return m_dao.ExecuteDataSet(sql, para);
        }

        public int GetAgentIdByInvoiceID(int invoiceID)
        {
            if (invoiceID <= 0) return 0;

            string sql = "select agentID from agentInvoice where invoiceID=@invoiceID";
            SqlParameter[] para = {
                new SqlParameter("@invoiceID", invoiceID),
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null || o is DBNull)
                return 0;
            else
                return Convert.ToInt32(o);
        }
        #endregion

        #region GetAgentCreditList
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetAgentCreditList()
        {
            string sql = @"
SELECT companyId, companyName, companyName_cn, telephone, contactPerson, 
      discount, maxCredit, creditBalance
FROM Company
WHERE (status=1) AND (companyType=3)";
            return m_dao.ExecuteDataSet(sql, null);
        }
        #endregion

        #region GetAgentNameByID
        public string GetAgentNameByID(int agentID)
        {
            if (agentID <= 0) return null;

            string sql = @"
select companyName + ' / ' + companyName_cn from company
where companyID=@agentID";
            SqlParameter[] para = { new SqlParameter("@agentID", agentID), };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o != null && !(o is DBNull))
                return o.ToString();
            else
                return "[error agent ID]";
        }
        #endregion
    }
}
