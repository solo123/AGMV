using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.OmeiDataSet;
namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class AgentTransforBiz : AdminBll
    {
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetTransforOrders(int agentID)
        {
            string sql = @"
select 
	o.orderID, o.scheduleID, o.firstName+'.'+o.lastName as customer, 
	o.actualAmount, o.orderDate, o.empID,
	e.nickname as employee,
	t.tourName, t.tourName_cn
from orders as o
	left join employeeInfo as e on o.empID=e.employeeID
	left join busSchedule as s on o.scheduleID=s.scheduleID
	left join tours as t on s.tourID=t.tourID
where agentTransfor>0 and matchID=0";
            if (agentID > 0) sql += " and o.agentTransfor=@agentID";
            SqlParameter[] para = {
                new SqlParameter("@agentID", agentID),
            };
            return m_dao.ExecuteDataSet(sql, para);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetTransforAgents()
        {
            string sql = @"
select companyID as agentID, companyName + '/' + companyName_cn as agentName 
from company
where companyID in (
	select distinct o.agentTransfor
	from orders as o
	where agentTransfor>0 and matchID=0
)
order by agentName";
            return m_dao.ExecuteDataSet(sql, null);
        }

        



    }
}
