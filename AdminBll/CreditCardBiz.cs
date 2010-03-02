using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.OmeiDataSet;
using com.Omei.DLL;
using com.Omei.DLL.DS_CreditCardsTableAdapters;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class CreditCardBiz : AdminBll
    {
        #region GetCreditDetail, AddCreditCard, UpdateCreditDetail
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
        public DS_CreditCards.CCDetailDataTable GetCreditDetail(int crId)
        {
            if (crId <= 0) return null;

            CCDetailTableAdapter adp = new CCDetailTableAdapter();
            return adp.GetData(crId);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, false)]
        public int AddCreditCard(
            object loginUserInfo, int orderID, int paymentID,
            string firstname, string lastname,
            string address, string city, string state, string zip, string country,
            string cardType, string cardNumber, string csc, string validDate,
            decimal amount, decimal serviceFee, decimal totalAmount,
            string profCode, string notes)
        {
            if (loginUserInfo == null) return 0;
            D_LoginUserInfo ui = loginUserInfo as D_LoginUserInfo;


            string sql = @"
insert CreditCard
(   orderId, paymentId,
    firstName, lastName,
    address, city, state, zip, country,
    cardType, cardNumber, csc, validDate,
    amount, serviceFee, totalAmount,
    profCode, notes, orderDate, payDate, isWebOrder, status
)
values
(   @orderId, @paymentID,
    @firstName, @lastName,
    @address, @city, @state, @zip, @country,
    @cardType, @cardNumber, @csc, @validDate,
    @amount, @serviceFee, @totalAmount,
    @profCode, @notes, getdate(), getdate(), 0, 8
);
select SCOPE_IDENTITY();
";
            SqlParameter[] para = {
                new SqlParameter("@orderId", orderID),
                new SqlParameter("@paymentID", paymentID),
                new SqlParameter("@firstName", firstname),
                new SqlParameter("@lastName", lastname),
                new SqlParameter("@address", address),
                new SqlParameter("@city", city),
                new SqlParameter("@state", state),
                new SqlParameter("@zip", zip),
                new SqlParameter("@country", country),
                new SqlParameter("@cardType", cardType),
                new SqlParameter("@cardNumber", cardNumber),
                new SqlParameter("@csc", csc),
                new SqlParameter("@validDate", validDate),
                new SqlParameter("@amount", amount),
                new SqlParameter("@serviceFee", serviceFee),
                new SqlParameter("@totalAmount", totalAmount),
                new SqlParameter("@profCode", profCode),
                new SqlParameter("@notes", notes)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null)
                return 0;
            else
                return Convert.ToInt32(o);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, true)]
        public bool UpdateCreditDetail(
            int original_crId,
            string firstname, string lastname,
            string address, string city, string state, string zip, string country,
            string cardType, string cardNumber, string csc, string validDate,
            decimal amount, decimal serviceFee, decimal totalAmount,
            string profCode, string notes)
        {
            string sql = @"
update CreditCard
set 
    firstName=@firstName, lastName=@lastName,
    address=@address, city=@city, state=@state, zip=@zip, country=@country,
    cardType=@cardType, cardNumber=@cardNumber, csc=@csc, validDate=@validDate,
    amount=@amount, serviceFee=@serviceFee, totalAmount=@totalAmount,
    profCode=@profCode, notes=@notes
where crId=@original_crId
";
            SqlParameter[] para = {
                new SqlParameter("@firstName", firstname),
                new SqlParameter("@lastName", lastname),
                new SqlParameter("@address", address),
                new SqlParameter("@city", city),
                new SqlParameter("@state", state),
                new SqlParameter("@zip", zip),
                new SqlParameter("@country", country),
                new SqlParameter("@cardType", cardType),
                new SqlParameter("@cardNumber", cardNumber),
                new SqlParameter("@csc", csc),
                new SqlParameter("@validDate", validDate),
                new SqlParameter("@amount", amount),
                new SqlParameter("@serviceFee", serviceFee),
                new SqlParameter("@totalAmount", totalAmount),
                new SqlParameter("@profCode", profCode),
                new SqlParameter("@notes", notes),
                new SqlParameter("@original_crId", original_crId)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }
        #endregion


        #region CreditCardPayment
        public bool CreditCardPayment(object loginUserInfo, int crId)
        {
            if (loginUserInfo == null || crId == 0) return false;

            D_LoginUserInfo ui = loginUserInfo as D_LoginUserInfo;

            DS_CreditCards.CCDetailDataTable dt = GetCreditDetail(crId);
            if (dt == null || dt.Rows.Count < 1) return false;

            DS_CreditCards.CCDetailRow row = dt.Rows[0] as DS_CreditCards.CCDetailRow;

            AdminOrderBiz biz = new AdminOrderBiz();
            int paymentId = biz.Payment( loginUserInfo,
                    row.orderId, row.totalAmount,
                    2, 0, ui.userId, ui.userId,
                    "[" + row.cardType + "] " + MaskedCardNumber(row.cardNumber));
            if (paymentId <= 0) return false;

            string sql = @"
update CreditCard
    set paymentId=@paymentId, status=8, payDate=getdate()
where crId=@crId;
";
            SqlParameter[] para = {
                new SqlParameter("@crId", crId),
                new SqlParameter("@paymentId", paymentId)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }

        private string MaskedCardNumber(string cardNumber)
        {
            string maskCardNumber;
            if (cardNumber != null && cardNumber.Length > 4)
                maskCardNumber = "****" + cardNumber.Substring(cardNumber.Length - 4, 4);
            else
                maskCardNumber = cardNumber;
            return maskCardNumber;
        }
        #endregion

        #region GetCreditCardsByOrderId
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
        public DataSet GetCreditCardsByOrderId(int orderID)
        {
            if (orderID <= 0) return null;

            string sql = @"
select crID, paymentID, cardType, cardNumber, firstName+'.'+lastName as username, isWebOrder, status 
from creditcard
where orderID=@orderID";
            SqlParameter[] para = { new SqlParameter("@orderID", orderID), };
            return m_dao.ExecuteDataSet(sql, para);
        }
        #endregion

    }
}
