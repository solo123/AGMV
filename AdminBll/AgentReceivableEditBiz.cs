using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.DLL;
using com.Omei.DLL.DS_AgentTableAdapters;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class AgentReceivableEditBiz : AdminBll
    {
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
        public DS_Agent.AgentReceivablesDataTable GetAgentOrder(int orderID)
        {
            string sql = @"
SELECT a.orderID, o.firstName+'.'+o.lastName as username,
 a.agentID, a.agentReceivable, a.agentPaid, a.orderClosedDate, 
      c.companyName, c.companyName_cn, a.status
FROM AgentOrders AS a LEFT OUTER JOIN
      Company AS c ON a.agentID = c.companyId
left join orders as o on a.orderID=o.orderID
WHERE a.orderID=@orderID";
            DS_Agent ds = new DS_Agent();
            SqlParameter[] para = {
                new SqlParameter("@orderID", orderID)
            };
            m_dao.FillDataSet(ds, "NewAgentOrders", sql, para);
            return ds.AgentReceivables;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, true)]
        public bool UpdateAgentOrderReceivable(int original_orderID, decimal agentReceivable)
        {
            string sql = @"
update agentOrders
    set agentReceivable=@agentReceivable
where orderID=@orderID and status<7";
            SqlParameter[] para = {
                new SqlParameter("@orderID", original_orderID),
                new SqlParameter("@agentReceivable", agentReceivable)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }
    }
}
