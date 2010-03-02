using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.OmeiDataSet;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class TicketBiz : AdminBll
    {
        #region GetTicketDetail
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetTicketById(int orderId)
        {
            if (orderId <= 0) return null;

            string sql = @"
SELECT 
    o.orderId, o.scheduleId, o.pickup, o.numberAdult, o.numberChild, o.numberFree, 
    o.priceAdult, o.priceChild, o.bookRooms, o.roomShare, o.miscCharge, o.discount, 
    o.pay, o.suggestAmount, o.actualAmount, o.firstName, o.lastName, o.contactPhone, 
    o.email, o.memberId, o.orderDate, o.customers,
    o.actualAmount - o.pay AS balance, o.fare, o.status, o.remark, o.agentId,o.agentInv, 
    o.priceAdult * o.numberAdult AS fareAdult, 
    o.priceChild * o.numberChild AS fareChild, o.serviceFee, o.empId, o.notes, 
    getdate() as startDate, 
    o.orderType, o.departureDate,
    c.companyName, e.nickname
FROM 
    orders AS o 
    left join Company AS c ON o.agentId = c.companyId
    left join EmployeeInfo as e on o.empID=e.employeeID
WHERE (o.orderId = @orderID)
";
            SqlParameter[] para = {
                new SqlParameter("@orderID", orderId),
            };

            return m_dao.ExecuteDataSet(sql, para);
        }
        #endregion

        #region AddTicket
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, false)]
        public int AddTicket(object loginUserInfo, int orderType,
            int memberId, string firstName, string lastName,
            string contactPhone, string email, string customers,
            string pickup, int numberAdult, int numberChild, int numberFree, char roomShare, decimal bookRooms,
            decimal priceAdult, decimal priceChild,
            decimal suggestAmount, decimal actualAmount, decimal miscCharge, decimal discount, decimal fare,
            string remark, string notes, string agentInv, DateTime departureDate)
        {
            if (loginUserInfo == null || !(loginUserInfo is D_LoginUserInfo))
                return 0;

            string sql = @"
insert orders
    (memberId, scheduleID, firstName, lastName, contactPhone, email, customers,
    pickup, numberAdult, numberChild, 
    numberFree, roomShare,
    priceAdult, priceChild,
    bookRooms, suggestAmount, 
    actualAmount, miscCharge, discount, fare,
    remark, notes, agentInv,
    empId, orderDate, orderType, departureDate, status)
values
    (@memberId, 
    0, @firstName, @lastName, @contactPhone, @email, @customers,
    @pickup, @numberAdult, @numberChild, 
    @numberFree, @roomShare,
    @priceAdult, @priceChild,
    @bookRooms, @suggestAmount, 
    @actualAmount, @miscCharge, @discount, @fare,
    @remark, @notes, @agentInv,
    @empID, getdate(), @orderType, @departureDate, 2)

select SCOPE_IDENTITY();
";

            if (agentInv == null) agentInv = "";
            D_LoginUserInfo ui = loginUserInfo as D_LoginUserInfo;
            SqlParameter[] para = {
                new SqlParameter("@memberId", memberId),
                new SqlParameter("@orderType", orderType),
                new SqlParameter("@firstName", firstName),
                new SqlParameter("@lastName", lastName),
                new SqlParameter("@contactPhone", contactPhone),
                new SqlParameter("@email", email),
                new SqlParameter("@pickup", pickup),
                new SqlParameter("@numberAdult", numberAdult),
                new SqlParameter("@numberChild", numberChild),
                new SqlParameter("@numberFree", numberFree),
                new SqlParameter("@roomShare", roomShare),
                new SqlParameter("@bookRooms", bookRooms),
                new SqlParameter("@suggestAmount", suggestAmount),
                new SqlParameter("@actualAmount", actualAmount),
                new SqlParameter("@miscCharge", miscCharge),
                new SqlParameter("@discount", discount),
                new SqlParameter("@remark", remark),
                new SqlParameter("@notes", notes),
                new SqlParameter("@agentInv", agentInv),
                new SqlParameter("@priceAdult", priceAdult),
                new SqlParameter("@priceChild", priceChild),
                new SqlParameter("@fare", fare),
                new SqlParameter("@customers", customers),
                new SqlParameter("@empID", ui.userId),
                new SqlParameter("@departureDate", departureDate),
            };
            object o = m_dao.ExecuteScalar(sql, para);
            int newOrderID = 0;
            if (o != null && !(o is DBNull))
                newOrderID = Convert.ToInt32(o);

            EventLog.OpLog(loginUserInfo, "New ticket " + newOrderID.ToString(), 4, newOrderID);
            return newOrderID;
        }
        #endregion

        #region UpdateTicket
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public bool UpdateTicket(int original_orderId, object loginUserInfo, int orderType,
            int memberId, string firstName, string lastName, string customers,
            string contactPhone, string email,
            string pickup, int numberAdult, int numberChild, int numberFree, char roomShare, decimal bookRooms,
            decimal priceAdult, decimal priceChild,
            decimal suggestAmount, decimal actualAmount, decimal miscCharge, decimal discount, decimal fare,
            string remark, string notes, string agentInv, DateTime departureDate)
        {
            string sql = @"
UPDATE orders
SET orderType=@orderType,
    memberId = @memberId, firstName = @firstName, 
    lastName = @lastName, contactPhone = @contactPhone, email = @email, customers=@customers,
    pickup = @pickup, numberAdult = @numberAdult, numberChild = @numberChild, 
    numberFree=@numberFree, roomShare=@roomShare,
    priceAdult=@priceAdult, priceChild=@priceChild,
    bookRooms = @bookRooms, suggestAmount = @suggestAmount, 
    actualAmount = @actualAmount, miscCharge = @miscCharge, discount = @discount, fare=@fare,
    remark=@remark, notes=@notes, agentInv=@agentInv,
    departureDate=@departureDate,
    status = CASE WHEN @actualAmount>0 and pay<@actualAmount THEN 2 WHEN @actualAmount>0 and pay>=@actualAmount THEN 3 ELSE 1 END
WHERE (orderId = @original_orderId and status<7)";

            if (agentInv == null) agentInv = "";

            SqlParameter[] para = {
                new SqlParameter("@orderType", orderType),
                new SqlParameter("@memberId", memberId),
                new SqlParameter("@firstName", firstName),
                new SqlParameter("@lastName", lastName),
                new SqlParameter("@contactPhone", contactPhone),
                new SqlParameter("@customers", customers),
                new SqlParameter("@email", email),
                new SqlParameter("@pickup", pickup),
                new SqlParameter("@numberAdult", numberAdult),
                new SqlParameter("@numberChild", numberChild),
                new SqlParameter("@numberFree", numberFree),
                new SqlParameter("@roomShare", roomShare),
                new SqlParameter("@bookRooms", bookRooms),
                new SqlParameter("@suggestAmount", suggestAmount),
                new SqlParameter("@actualAmount", actualAmount),
                new SqlParameter("@miscCharge", miscCharge),
                new SqlParameter("@discount", discount),
                new SqlParameter("@remark", remark),
                new SqlParameter("@notes", notes),
                new SqlParameter("@agentInv", agentInv),
                new SqlParameter("@original_orderId", original_orderId ),
                new SqlParameter("@priceAdult", priceAdult),
                new SqlParameter("@priceChild", priceChild),
                new SqlParameter("@fare", fare),
                new SqlParameter("@departureDate", departureDate),
            };
            int r = m_dao.ExecuteNoQuery(sql, para);
            EventLog.OpLog(loginUserInfo, "Edit Ticket " + original_orderId.ToString(), 4, original_orderId);
            return (r == 1);
        }
        #endregion

    }
}
