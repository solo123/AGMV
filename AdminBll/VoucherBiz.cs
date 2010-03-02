using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;

using com.Omei.OmeiDataSet;
namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class VoucherBiz : AdminBll
    {
        public DataSet GetVoucherDetail(int voucherID)
        {
            if (voucherID <= 0) return null;

            string sql = @"
select *
from creditVoucher
where voucherID=@voucherID and status=1";
            SqlParameter[] para = {
                new SqlParameter("@voucherID", voucherID),
            };
            return m_dao.ExecuteDataSet(sql, para);
        }

        public int CreateVoucher(
            int orderID, int preVoucherID, decimal amount, int userID)
        {
            string sql = @"
insert creditVoucher
(amount,createDate, expireDate, refundOrder, preVoucherID, operator, payDate, status)
values
(@amount, getdate(), dateadd(year, 1, getdate()), @orderID, @preVoucherID, @userID, null, 1);
select SCOPE_IDENTITY();";
            SqlParameter[] para = {
                new SqlParameter("@amount", amount),
                new SqlParameter("@orderID", orderID),
                new SqlParameter("@preVoucherID", preVoucherID),
                new SqlParameter("@userID", userID),
            };

            object o = m_dao.ExecuteScalar(sql, para);
            if (o != null)
                return Convert.ToInt32(o);
            else
                return 0;

        }

        public bool VoucherPayment(object loginUserAccount, int voucherID, decimal amount, int orderID)
        {
            if (loginUserAccount==null || voucherID<=0 || orderID<=0) return false;
            if (!CheckVoucherPaymentValid(voucherID, amount)) return false;

            string sql = @"
update creditVoucher
set
    payOrder=@orderID, payAmount=@amount,payDate=getdate(), status=8
where voucherID=@voucherID;

if (select count(*) from creditVoucher where voucherID=@voucherID and amount>payAmount) > 0
begin
    insert creditVoucher
        (amount,createDate, expireDate, refundOrder, preVoucherID, operator, payDate, status)
    select amount-payAmount as amount, getdate() as createDate, expireDate, refundOrder, voucherID as preVoucherID, @operator as operator, 
        null as payDate, 1 as status
    from creditVoucher
    where voucherID=@voucherID
end";
            SqlParameter[] para = {
                new SqlParameter("@voucherID", voucherID),
                new SqlParameter("@amount", amount),
                new SqlParameter("@orderID", orderID),
                new SqlParameter("@operator", ((D_LoginUserInfo)loginUserAccount).userId),
            };
            m_dao.ExecuteNoQuery(sql, para);
            return true;
        }

        public bool CheckVoucherPaymentValid(int voucherID, decimal amount)
        {
            string sql = @"
select count(*) from creditVoucher 
where voucherID=@voucherID and expireDate>getdate() and payOrder=0 and status=1 and amount>=@amount";
            SqlParameter[] para = {
                new SqlParameter("@voucherID", voucherID),
                new SqlParameter("@amount", amount),
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null || Convert.ToInt32(o) == 0)
                return false;
            else
                return (Convert.ToInt32(o) == 1);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetVoucherList()
        {
            string sql = @"
select voucherID, amount, expireDate, refundOrder, preVoucherID, 
	c.operator, e.nickname as employee, payAmount,payOrder, payDate,c.status
from creditvoucher as c
	left join employeeInfo as e on c.operator=e.employeeID";
            return m_dao.ExecuteDataSet(sql, null);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetOrderVoucherList(int orderID)
        {
            string sql = @"
select voucherID, amount, expireDate, status
from creditvoucher as c
where refundOrder=@orderID";
            SqlParameter[] para = { new SqlParameter("@orderID", orderID), };
            return m_dao.ExecuteDataSet(sql, para);
        }

    }
}
