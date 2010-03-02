using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
namespace com.Omei.BLL.Admin
{
    /**************************************************************
     * 关于Agent Receive的说明
     * Jimmy Liang, 2007-12-26
     * ************************************************************
     * 一、数据表
     * 1) orders: 字段：orderID, agentID, actualAmount（订单金额）, agentCredit, agentCmt, agentBillAmount, agentRecvPrintID(打印给agent的invoice ID)
     * 2) company: 字段：companyID(agentID), status, discount, maxCredit, creditBalance(?)
     * 3) agentPayment: 字段：apID, agentID, agentInvoiceID(string), payAmount, payDate, notes, status(?)
     * 4) agentPaymentItem: 字段：apiID, apID, agentID, orderID, matchID(string 实际为agent payment invoice), payDate, payAmount
     * 
     * 二、功能（见程序中的说明）
     * 
     * 
     * 
     **************************************************************/


    [System.ComponentModel.DataObject]
    public class AgentOrderBiz : AdminBll
    {
        #region noused
        public int GetAgentID_noused(int orderID) //应放入orderBiz
        {
            if (orderID <= 0) return 0;

            string sql = @"select agentID from orders where orderID=@orderID";
            SqlParameter[] para = { new SqlParameter("@orderID", orderID), };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null)
                return 0;
            else
                return Convert.ToInt32(o);
        }


        #endregion


        #region Change order's Agent
        /// <summary>
        /// 判断该订单是否可以改变agentID
        /// 
        /// 订单存在 & 订单有效且未结束 & 尚未设定agent credit
        /// </summary>
        /// <param name="orderID"></param>
        /// <returns></returns>
        public bool IsAgentChangeable(int orderID)
        {
            string sql = @"
select count(*) from orders
where orderID=@orderID and status<7 and agentCredit=0";
            SqlParameter[] para = { new SqlParameter("@orderID", orderID),};
            object o = m_dao.ExecuteScalar(sql, para);
            return (Convert.ToInt32(o) == 1);
        }

        /// <summary>
        /// 修改订单agentID
        /// 
        /// 满足上述条件时，修改agentID，同时重设agentCmt (commission)
        /// 
        /// </summary>
        /// <param name="orderID"></param>
        /// <param name="agentID"></param>
        /// <returns></returns>
        public bool ChangeAgent(int orderID, int agentID)
        {
            if (orderID <= 0) return false;

            string sql = @"
update orders
set agentID=@agentID, agentCmt = CASE when @agentID>0 then fare * (select discount from company where companyID=@agentID) / 100 else 0 END
where orderID=@orderID and status<7 and agentCredit=0";
            SqlParameter[] para = {
                new SqlParameter("@orderID", orderID),
                new SqlParameter("@agentID", agentID),
            };
            int r = m_dao.ExecuteNoQuery(sql, para);
            return (r == 1);
        }

        #endregion

        /// <summary>
        /// Pay balance by agent credit的订单，必须先取消此条payment才能做其他refund。
        /// 
        /// 
        /// </summary>
        /// <param name="paymentID"></param>
        /// <returns></returns>
        public bool CancelAgentOrderCreditPayment(int paymentID)
        {
            return false;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetAgentActiveOrders(int agentID)
        {

            string sql = @"
select 
	o.agentID, o.orderID, o.scheduleID, 
	o.numberAdult,o.numberChild,o.numberFree,
	o.actualAmount, o.agentCredit, o.orderDate, o.agentCredit-o.agentBillAmount as agentBalance,
	o.firstName +'.' + o.lastName as customer, o.status, o.orderType,
	c.shortName as agentName
from orders as o
	left join company as c on o.agentID=c.companyID
where agentCredit!=agentBillAmount and o.status!=7";
            if (agentID > 0)
                sql += " and o.agentID=@agentID";
            SqlParameter[] para = {
                new SqlParameter("@agentID", agentID),
            };
            return m_dao.ExecuteDataSet(sql, para);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetOrdersByAgentID(int agentID)
        {

            string sql = @"
SELECT a.invoiceID, a.orderID, o.firstName+'.'+o.lastName as username,
    a.agentID, a.agentReceivable, a.additionalDiscount, a.agentPaid, a.orderClosedDate, a.reportDate,
    c.companyName, c.companyName_cn, a.status, o.agentInv
FROM AgentOrders AS a 
    left join Company AS c ON a.agentID = c.companyId
    left join orders as o on a.orderID=o.orderID
WHERE a.agentID=@agentID and a.status!=7
ORDER BY a.orderID desc";

            SqlParameter[] para = {
                new SqlParameter("@agentID", agentID)
            };
            return m_dao.ExecuteDataSet(sql, para);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetAgentOrders(int agentID)
        {

            string sql = @"
select 
	o.orderID, o.agentRecvPrintID, o.agentID, o.firstName+' ' + o.lastName as customer, agentInv,
	o.actualAmount, o.actualAmount-o.agentCredit as deposit, o.agentCmt, o.agentCredit, o.agentBillAmount, o.agentCredit-o.agentBillAmount as balance,
	c.companyName + ' / ' + c.companyName_cn as agentName,
	s.startDate
from orders as o
	left join company as c on o.agentID=c.companyID
	left join busSchedule as s on o.scheduleID=s.scheduleID
where agentCredit<>agentBillAmount and o.status!=7";
            if (agentID > 0)
                sql += " and o.agentID=@agentID";
            SqlParameter[] para = {
                new SqlParameter("@agentID", agentID),
            };
            return m_dao.ExecuteDataSet(sql, para);
        }
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetAgentOrdersAgent()
        {
            string sql = @"
select companyID as agentID, companyName + '/' + companyName_cn as agentName 
from company
where companyID in (
	select distinct agentID
    from orders
    where agentCredit<>agentBillAmount and status!=7
)
order by agentName";
            return m_dao.ExecuteDataSet(sql, null);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetAgentUnprintOrders(int agentID)
        {

            string sql = @"
select 
	o.orderID, o.agentID, o.firstName+' ' + o.lastName as customer, agentInv,
	o.actualAmount,o.agentCmt, o.agentCredit, o.agentBillAmount, o.agentCredit-o.agentBillAmount as balance,
	c.companyName + ' / ' + c.companyName_cn as agentName,
    s.startDate
from orders as o
	left join company as c on o.agentID=c.companyID
	left join busSchedule as s on o.scheduleID=s.scheduleID
where agentID=@agentID and agentRecvPrintID=0 and o.status!=7";
            SqlParameter[] para = {
                new SqlParameter("@agentID", agentID),
            };
            return m_dao.ExecuteDataSet(sql, para);
        }

        public int NewReceiveInvoice(int employee, int agentID, string orders)
        {
            if (agentID <= 0 || orders == null || orders.Length < 1) return 0;

            string sql = @"
declare @apID int;
insert agentRecvInvoice
(agentID, createDate, printDate, operator, remark, lastUpdate)
values
(@agentID, getdate(), getdate(), @employee, '', getdate());
select @apID=SCOPE_IDENTITY();

update orders
set agentRecvPrintID=@apID
where orderID in ("+ orders + @") and agentID=@agentID and agentRecvPrintID=0 and status!=7;

select @apID;";
            SqlParameter[] para = {
                new SqlParameter("@agentID", agentID),
                new SqlParameter("@employee", employee),
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null)
                return 0;
            else
                return Convert.ToInt32(o);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetAgentRecvInvoiceOrders(int recvID)
        {
            if (recvID <= 0) return null;

            string sql = @"
SELECT o.orderID, o.agentID,
    o.firstName+'.'+o.lastName as username, o.agentInv,
    o.actualAmount,
	o.agentBillAmount, 
    o.agentCmt, o.agentCredit, o.agentCredit-o.agentBillAmount as balance,
	o.numberAdult, o.numberChild, o.numberFree, o.orderDate,
	t.tourName, t.tourName_cn, s.subTitle, s.startDate
FROM orders AS o
	left join BusSchedule as s on o.scheduleID=s.scheduleID
	left join tours as t on s.tourID=t.tourID
WHERE o.agentRecvPrintID = @recvID and o.status!=7";
            SqlParameter[] para = {
                new SqlParameter("@recvID", recvID),
            };
            return m_dao.ExecuteDataSet(sql, para);
        }

        public DataSet GetAgentRecvInvoice(int recvID)
        {
            if(recvID<=0) return null;

            string sql = "select * from agentRecvInvoice where recvInvID=@recvID";
            SqlParameter[] para = {new SqlParameter("@recvID", recvID),};
            return m_dao.ExecuteDataSet(sql, para);
        }

        public bool ChangeOrderCommission(int orderID, decimal oldCommission, decimal newCommission)
        {
            string sql = @"
update orders
set agentCmt=@newCommission
where orderID=@orderID;

update orders
set agentCredit=agentCredit+@oldCommission-@newCommission
where orderID=@orderID

select @@ROWCOUNT;
";
            SqlParameter[] para = {
                new SqlParameter("@orderID", orderID),
                new SqlParameter("@oldCommission", oldCommission),
                new SqlParameter("@newCommission", newCommission),
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o != null)
                return (Convert.ToInt32(o) > 0);
            else
                return false;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet AgentRecvInvoices(int agentID)
        {
            string sql = @"
select
	ai.recvInvID, ai.agentID, 
	(select sum(actualAmount) from orders where agentRecvPrintID=ai.recvInvID and status!=7) as actualAmount, 
	(select sum(agentCmt) from orders where agentRecvPrintID=ai.recvInvID and status!=7) as agentCmt, 
	(select sum(agentCredit) from orders where agentRecvPrintID=ai.recvInvID and status!=7) as agentCredit, 
	(select sum(agentBillAmount) from orders where agentRecvPrintID=ai.recvInvID and status!=7) as agentBillAmount, 	
	ai.createDate, ai.lastUpdate, c.shortName
from agentRecvInvoice as ai
	left join company as c on ai.agentID=c.companyID";
            if (agentID > 0)
            {
                sql += " where ai.agentID=@agentID";
            }
            sql += " order by ai.recvInvID desc";
            SqlParameter[] para = { new SqlParameter("@agentID", agentID), };
            return m_dao.ExecuteDataSet(sql, para);
        }



        #region agent transfor
        public bool IsOrderMatched(int orderID)
        {
            string sql = @"
select count(*) from orders
where orderID=@orderID and matchID=0";
            SqlParameter[] para = { new SqlParameter("@orderID", orderID), };
            object o = m_dao.ExecuteScalar(sql, para);
            if (Convert.ToInt32(o) == 1)
                return true;
            else
                return false;
        }

        public bool ChangeAgentTransfor(int orderID, int agentID)
        {
            if (orderID <= 0) return false;

            string sql = @"
update orders
set agentTransfor=@agentID
where orderID=@orderID and matchID=0";
            SqlParameter[] para = {
                new SqlParameter("@orderID", orderID),
                new SqlParameter("@agentID", agentID),
            };
            int r = m_dao.ExecuteNoQuery(sql, para);
            return (r == 1);
        }

        
        #endregion


    }
}
