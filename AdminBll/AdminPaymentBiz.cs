using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.DLL;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class AdminPaymentBiz : AdminBll
    {
        #region GetPaymentsByDay
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetPaymentsByDay(DateTime date)
        {
            string sql = @"
SELECT p.paymentId, p.amount, p.method, p.reason, 
    p.payDate, 
    p.afterPay, 
    p.remark, p.crId, 
	p.payEmployeeID, p.opEmployeeID,
	u1.nickname AS employeeName,
	u2.nickname AS opEmpName
FROM payment as p 
	left join employeeInfo as u1 ON p.payEmployeeId = u1.employeeID
    left join employeeInfo as u2 on p.opEmployeeId = u2.employeeID
WHERE p.payDate>=@pdate and p.payDate<dateadd(day,1,@pdate)
";
            SqlParameter[] para = {
                new SqlParameter("@pdate", date)
            };
            return m_dao.ExecuteDataSet(sql, para);
        }
        #endregion

        #region GetPaymentBriefList
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetPaymentBriefList(int orderID)
        {
            if (orderID <= 0) return null;

            string sql = @"
select p.amount, 'by ' + t.listTitle as method
from payment as p
	left join typeRef as t on t.listClass='PaymentMethod' and p.method=t.listValue
where orderID=@orderID";

            SqlParameter[] para ={
                new SqlParameter("@orderID", orderID),
            };
            DataSet ds = m_dao.ExecuteDataSet(sql, para);
            return ds;
        }
        #endregion

        #region PaymentList
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetPaymentList(int orderID)
        {
            string sql = @"
SELECT p.paymentId, p.amount, p.method, p.reason, 
    p.payDate, 
    p.afterPay, 
    p.remark, p.crId, 
	p.payEmployeeID, p.opEmployeeID,
	u1.firstName + '.' + u1.lastName AS employeeName,
	u2.firstName + '.' + u2.lastName AS opEmpName
FROM payment as p 
	LEFT OUTER JOIN
      employeeInfo as e ON p.payEmployeeId = e.employeeID
	left join userInfo as u1 on e.userID=u1.userID
      left outer join employeeInfo as e2 on p.opEmployeeId=e2.employeeID
	left join userInfo as u2 on e2.userID=u2.userID
WHERE (p.orderId = @orderId)
ORDER BY p.paymentID desc";
            SqlParameter[] para = {
                new SqlParameter("@orderID", orderID),
            };

            return m_dao.ExecuteDataSet(sql, para);
        }
        #endregion


    }
}
