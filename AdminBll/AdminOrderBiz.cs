using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.OmeiAdminData;

using com.Omei.DLL;
using com.Omei.DLL.DS_OrdersTableAdapters;
using com.Omei.OmeiDataSet;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class AdminOrderBiz : AdminBll
    {

        private string ShowOrderRefUrl1(int orderID)
        {
            return "<a href='OrderDetail.aspx?id=" + orderID + "' target='logWin'>" + orderID + "</a>";
        }

        #region Hold
        public int HoldSeats(object userLoginInfo, int scheduleId, string seatList, string notes)
        {
            
            if (userLoginInfo==null || !CheckSeatsAvailable(scheduleId, seatList)) 
                return 0;

            D_LoginUserInfo ui = userLoginInfo as D_LoginUserInfo;
            if (ui.userId == 0) return 0;

            int orderId = AddEmptyOrder(scheduleId, ui.userId);
            if (orderId > 0)
            {
                UpdateOrderCustomer(orderId, 0, ui.username, ui.tel, notes);
                RecalculateOrder(orderId);
                AddSeats(scheduleId, orderId, seatList);
            }

            EventLog.OpLog(userLoginInfo, "Hold seats:" + seatList + ", order ID:" + orderId.ToString() + ", user:(" + ui.userId.ToString() +
                ")" + ui.username, 4, orderId);
            return orderId;
        }

        private bool CheckSeatsAvailable(int scheduleId, string seatList)
        {
            if (scheduleId < 1 || seatList == null || seatList == "")
                return false;

            // check db for seats available
            string sql = @"
select count(*) 
from BusSeats
where scheduleId=" + scheduleId.ToString() + " and seatNumber in (" + seatList + ")";
            object r = m_dao.ExecuteScalar(sql, null);
            if (r != null && Convert.ToInt32(r) > 0)
                return false;

            return true;
        }

        public int AddEmptyOrder(int scheduleId, int empId)
        {
            int orderId = 0;
            string sql = @"
INSERT INTO orders
    (scheduleId, empId, orderDate, status)
VALUES (@scheduleId, @empId, getdate(), 1);
SELECT SCOPE_IDENTITY();";   // status=1 hold

            SqlParameter[] para = {
                new SqlParameter("@scheduleId", scheduleId),
                new SqlParameter("@empId", empId)
            };

            object o = m_dao.ExecuteScalar(sql, para);
            if (o != null)
            {
                orderId = Convert.ToInt32(o);
            }
            return orderId;
        }
        private void UpdateOrderCustomer(int orderId, int custId, string custName, string custTel, string notes)
        {
            string sql = "update orders set memberId=@memberId, firstName=@firstName, contactPhone=@tel, remark=@remark where orderId=@orderId";
            SqlParameter[] para = {
                new SqlParameter("@orderId", orderId),
                new SqlParameter("@memberId", custId),
                new SqlParameter("@firstName", custName),
                new SqlParameter("@remark", notes),
                new SqlParameter("@tel", custTel)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        
        #endregion

        #region RecalculateOrder
        public void RecalculateOrder(int orderId)
        {
            if (orderId < 1) return;

            string sql = @"
update orders
	set 
		priceAdult=t.priceAdult, priceChild=t.priceChild,
		fare=numberAdult*t.priceAdult+numberChild*t.priceChild,
        suggestAmount=fare*(100-discount)/100 + miscCharge
from
	orders 
	left join BusSchedule as s on orders.scheduleId=s.scheduleId
    left join tours as t on s.tourID=t.tourID
where orders.orderId=@orderId ";
            SqlParameter[] para = {
                new SqlParameter("@orderId", orderId)
            };
            m_dao.ExecuteNoQuery(sql, para);

        }
        #endregion

        #region CheckSeatsInHold
        private bool CheckSeatsInHold(int scheduleId, string seatList)
        {
            if (scheduleId < 1 || seatList == null || seatList == "")
                return false; 

            // check db for seats in hold
            string sql = @"
select count(*)
from orders
where orderId in (
	select DISTINCT orderId
	from BusSeats
	where scheduleId="+ scheduleId.ToString() +" and seatNumber in ("+ seatList +") ) and status>1";

            object r = m_dao.ExecuteScalar(sql, null);
            if (r != null && Convert.ToInt32(r) > 0)
                return false;

            return true;
        }
        #endregion

        #region Add and Release Seats in seatList
        public void ReleaseSeats(int scheduleId, string seatList)
        {
            string sql = @"
delete BusSeats
where scheduleId=@scheduleId and seatNumber in (" + seatList + ")";
            SqlParameter[] para = {
                new SqlParameter("@scheduleId", scheduleId)
            };
            m_dao.ExecuteNoQuery(sql, para);
            SumScheduleBookNum(scheduleId); // 统计人数
        }

        public void AddSeats(int scheduleId, int orderId, string seatList)
        {
            string[] seats = seatList.Split(',');
            for (int i = 0; i < seats.Length; i++)
            {
                int seatNum = int.Parse(seats[i]);
                AddSeat(scheduleId, orderId, seatNum);
            }
            SumScheduleBookNum(scheduleId); // 统计人数
        }

        private void AddSeat(int scheduleId, int orderId, int seat)
        {
            string sql = @"
insert into BusSeats
	(seatNumber, scheduleId, orderId)
values
	(@seatNumber, @scheduleId, @orderId)
";
            SqlParameter[] para = {
                new SqlParameter("@seatNumber", seat),
                new SqlParameter("@scheduleId", scheduleId),
                new SqlParameter("@orderId", orderId)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        #endregion

        #region SeatList
        public string GetSeatList(int orderId)
        {
            string sql = "select seatNumber from busseats where orderId=@orderId";
            SqlParameter[] para = {
                new SqlParameter("@orderId", orderId)
            };
            IDataReader rd = m_dao.ExecuteReader(sql, para);
            StringBuilder sb = new StringBuilder();
            int cnt = 0;
            while (rd.Read())
            {
                cnt++;
                sb.Append(rd[0]);
                sb.Append(',');
            }
            if (sb.Length > 1)
                sb.Remove(sb.Length - 1, 1);

            return sb.ToString();
        }

        public string GetSeats(int orderId)
        {
            string sql = "select seatNumber from busseats where orderId=@orderId";
            SqlParameter[] para = {
                new SqlParameter("@orderId", orderId)
            };
            IDataReader rd = m_dao.ExecuteReader(sql, para);
            StringBuilder sb = new StringBuilder();
            int cnt = 0;
            while (rd.Read())
            {
                cnt++;
                sb.Append(rd[0]);
                sb.Append(',');
            }
            if (sb.Length > 1)
                sb.Remove(sb.Length - 1, 1);

            return sb.ToString();
        }
        #endregion

        #region payment
        public int Payment(object userLoginInfo,
            int orderId, 
            decimal amount, 
            int method, int reason, 
            int payEmpId, int opEmpId, 
            string remark)
        {
            if (orderId == 0 || amount <= 0) return -9;

            int r = 0;
            SqlParameter paraOut = new SqlParameter("@errCode", r);
            paraOut.Direction = ParameterDirection.Output;

            SqlParameter[] para = {
                new SqlParameter("@orderId", orderId),
                new SqlParameter("@amount", amount),
                new SqlParameter("@method", method),
                new SqlParameter("@reason", reason),
                new SqlParameter("@payEmployeeId", payEmpId),
                new SqlParameter("@opEmployeeId", opEmpId),
                new SqlParameter("@remark", remark),
                paraOut
            };

            m_dao.ExecuteNoQuery("osp_payment", para, true);
            int pid = (int)paraOut.Value;

            EventLog.OpLog(userLoginInfo, "Order Payment, Order ID:" + orderId.ToString() + ", Payment ID:" + pid.ToString() + ", amount:" + amount.ToString(), 4, orderId);
            return pid;
        }
        public void AddCreditId(int paymentId, int creditId)
        {
            string sql = "update payment set crId=@crId where paymentId=@paymentId";
            SqlParameter[] para = {
                new SqlParameter("@paymentId", paymentId),
                new SqlParameter("@crId", creditId)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }

        public int Refund(object userLoginInfo, int orderId, decimal amount, int method, int payEmpId, string remark)
        {
            if (orderId==0 || amount <= 0) return -9;

            int r = 0;
            SqlParameter paraOut = new SqlParameter("@errCode", r);
            paraOut.Direction = ParameterDirection.Output;

            int opEmpId = ((D_LoginUserInfo)userLoginInfo).userId;
            int reason = 2;
            if (payEmpId == 0) payEmpId = opEmpId;

            SqlParameter[] para = {
                new SqlParameter("@orderId", orderId),
                new SqlParameter("@amount", -amount),
                new SqlParameter("@method", method),
                new SqlParameter("@reason", reason),
                new SqlParameter("@payEmployeeId", payEmpId),
                new SqlParameter("@opEmployeeId", opEmpId),
                new SqlParameter("@remark", remark),
                paraOut
            };

            m_dao.ExecuteNoQuery("osp_payment", para, true);
            EventLog.OpLog(userLoginInfo, "Refund Order ID:" + orderId.ToString() + ", amount:" + amount.ToString() + " - (result:" + paraOut.Value.ToString() + ") " + remark, 4, orderId);
            return (int)paraOut.Value;
        }

        public bool CancelOrder(int orderId)
        {
            string sql = @"
if (select pay from orders where orderID=@orderID and status<7)=0
begin
    update orders  set status=7
    where orderId=@orderId and status<7;
end
";
            SqlParameter[] para = {
                new SqlParameter("@orderId", orderId)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            if (i == 1)
            {
                m_dao.ExecuteNoQuery("delete busseats where orderId=" + orderId.ToString(), null);
                return true;
            }
            else
                return false;
        }

        public decimal GetBalance(int orderId)
        {
            string sql = "select actualAmount-pay as balance from orders where orderId=@orderId";
            SqlParameter[] para = {
                new SqlParameter("@orderId", orderId)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            decimal balance = 0;
            if (o != null)
                balance = Convert.ToDecimal(o);

            return balance;
        }
        #endregion

        #region OrderEditable
        public bool OrderEditable(int orderId, string position)
        {
            if (position.IndexOf("[9]")>=0) return true;

            string sql = "select status from orders where orderId=" + orderId.ToString() ;
            object o = m_dao.ExecuteScalar(sql, null);
            if (o != null)
            {
                int status = (int)o;
                if (status < 3) return true;
            }
            return false;
        }
        #endregion

        #region Get & Edit order detail
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetOrderDetail(int orderId)
        {
            if (orderId <= 0) return null;

            string sql = @"
SELECT 
    o.orderId, o.orderType,o.scheduleId, o.pickup, o.numberAdult, o.numberChild, o.numberFree, 
    o.priceAdult, o.priceChild, o.bookRooms, o.roomShare, o.miscCharge, o.discount, 
    o.pay, o.suggestAmount, o.actualAmount, o.firstName, o.lastName, o.contactPhone, 
    o.email, o.memberId, o.orderDate, o.customers,
    o.actualAmount - o.pay AS balance, o.fare, o.status, o.remark, o.agentId,o.agentInv, o.agentTransfor,
    o.priceAdult * o.numberAdult AS fareAdult, 
    o.priceChild * o.numberChild AS fareChild, o.serviceFee, o.empId, o.notes, o.departureDate,
    s.subTitle, s.startDate, 
    c.companyName as fromAgent, ct.companyName as toAgent, e.nickname,
    t.TourDay, t.TourName, t.TourName_cn, t.isFloatPrice
FROM 
    orders AS o 
    left join BusSchedule AS s ON o.scheduleId = s.scheduleId 
    left join tours AS t ON s.tourId = t.TourID 
    left join Company AS c ON o.agentId = c.companyId
    left join Company AS ct ON o.agentTransfor = ct.companyId
    left join EmployeeInfo as e on o.empID=e.employeeID
WHERE (o.orderId = @orderID)";
            SqlParameter[] para = {
                new SqlParameter("@orderID", orderId),
            };

            return m_dao.ExecuteDataSet(sql, para);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetTicketDetail(int orderId)
        {
            if (orderId <= 0) return null;

            string sql = @"
SELECT 
    o.orderId, o.orderType, o.scheduleId, o.pickup, o.numberAdult, o.numberChild, o.numberFree, 
    o.priceAdult, o.priceChild, o.bookRooms, o.roomShare, o.miscCharge, o.discount, 
    o.pay, o.suggestAmount, o.actualAmount, o.firstName, o.lastName, o.contactPhone, 
    o.email, o.memberId, o.orderDate, o.customers,
    o.actualAmount - o.pay AS balance, o.fare, o.status, o.remark, o.agentId,o.agentInv, o.agentTransfor,
    o.priceAdult * o.numberAdult AS fareAdult, 
    o.priceChild * o.numberChild AS fareChild, o.serviceFee, o.empId, o.notes, 
    o.departureDate, 
    c.companyName as fromAgent, ct.companyName as toAgent, e.nickname,
    t.listTitle, t.listTitle_cn
FROM 
    orders AS o 
    left join Company AS c ON o.agentId = c.companyId
    left join Company AS ct ON o.agentTransfor = ct.companyId
    left join EmployeeInfo as e on o.empID=e.employeeID
	left join typeRef as t on t.listClass='TicketType' and listValue=o.orderType
WHERE (o.orderId = @orderID)
";
            SqlParameter[] para = {
                new SqlParameter("@orderID", orderId),
            };

            return m_dao.ExecuteDataSet(sql, para);
        }
        

        /// <summary>
        /// 修改订单信息－当订单状态<7时；
        /// </summary>
        /// <param name="original_orderId"></param>
        /// <param name="memberId"></param>
        /// <param name="firstName"></param>
        /// <param name="lastName"></param>
        /// <param name="contactPhone"></param>
        /// <param name="email"></param>
        /// <param name="pickup"></param>
        /// <param name="numberAdult"></param>
        /// <param name="numberChild"></param>
        /// <param name="numberFree"></param>
        /// <param name="roomShare"></param>
        /// <param name="bookRooms"></param>
        /// <param name="priceAdult"></param>
        /// <param name="priceChild"></param>
        /// <param name="suggestAmount"></param>
        /// <param name="actualAmount"></param>
        /// <param name="miscCharge"></param>
        /// <param name="discount"></param>
        /// <param name="fare"></param>
        /// <param name="remark"></param>
        /// <param name="agentId"></param>
        /// <returns></returns>
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public bool OrderUpdate( int original_orderId, object loginUserInfo, int orderType,
            int memberId, string firstName, string lastName, string customers,
            string contactPhone, string email,
            string pickup, int numberAdult, int numberChild, int numberFree, char roomShare, decimal bookRooms, 
            decimal priceAdult, decimal priceChild,
            decimal suggestAmount, decimal actualAmount, decimal miscCharge, decimal discount, decimal fare,
            string remark, string notes, string agentInv)
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
                new SqlParameter("@fare", fare)
            };
            int r = m_dao.ExecuteNoQuery(sql, para);
            EventLog.OpLog(loginUserInfo, "Edit Order " + original_orderId.ToString(), 4, original_orderId);

            SumScheduleBookNumAfterOrder(original_orderId); // 统计人数

            return (r == 1);
        }
        #endregion

        #region GetOrderType
        public int GetOrderType( int orderID)
        {
            if (orderID<=0) return 0;
            string sql = @"select orderType from orders where orderID=@orderID";
            SqlParameter[] para = { new SqlParameter("@orderID", orderID), };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null || o is DBNull)
                return 0;
            else
                return Convert.ToInt32(o);
        }
        #endregion

        #region GetOrderScheduleId
        public int GetOrderScheduleId(int orderId)
        {
            string sql = "SELECT scheduleId FROM orders WHERE orderId = " + orderId.ToString();
            object o = m_dao.ExecuteScalar(sql, null);
            if (o != null && o is int)
                return (int)o;
            else
                return 0;
        }
        #endregion

        #region GetOrderStatus, isAgentOrder
        public int GetOrderStatus(int orderId)
        {
            string sql = "SELECT status FROM orders WHERE orderId = " + orderId.ToString();
            object o = m_dao.ExecuteScalar(sql, null);
            if (o != null)
                return Convert.ToInt32(o);
            else
                return -1;
        }
        public bool IsAgentOrder(int orderID)
        {
            if (orderID <= 0) return false;
            string sql = "select agentID from orders where orderID=@orderID";
            SqlParameter[] para = { new SqlParameter("@orderID", orderID), };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o==null || o is DBNull)
                return false;
            else
                return (Convert.ToInt32(o)>0);
        }
        #endregion

        #region GetOrderCustomer
        public int GetOrderCustomer(int orderId)
        {
            string sql = "SELECT memberID FROM orders WHERE orderId = " + orderId.ToString();
            object o = m_dao.ExecuteScalar(sql, null);
            if (o != null)
                return Convert.ToInt32(o);
            else
                return -1;
        }
        #endregion

        #region GetOrderBalance
        public decimal GetOrderBalance(int orderID)
        {
            if(orderID==0) return (decimal)0;

            string sql = @"select actualAmount-pay as balance from orders where orderID=@orderID";
            SqlParameter[] para = {
                new SqlParameter("@orderID", orderID)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null)
                return (decimal)0;
            else
                return (decimal)o;

        }
        #endregion

        #region SumScheduleBookNum
        private void SumScheduleBookNum(int scheduleId)
        {
            if (scheduleId<=0) return;

            SqlParameter[] para = {
                new SqlParameter("@scheduleId", scheduleId)
            };
            m_dao.ExecuteNoQuery("ScheduleBookCount", para, true);
        }
        private void SumScheduleBookNumAfterOrder(int orderId)
        {
            string sql = @"
declare @sid int;
select @sid=scheduleId from orders where orderId=@orderId;
if(@sid is not null) exec ScheduleBookCount @scheduleId=@sid;";
            SqlParameter[] para = {
                new SqlParameter("@orderId", orderId)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        #endregion

        #region QueryOrders, GetOrdersByScheduleID
        
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet QueryOrders(D_QueryOrderCondition condition)
        {
            string sql = @"
select 
	o.orderId, o.scheduleId, o.orderType, t.tourName, t.tourName_cn,
	b.startDate,
	o.numberAdult, o.numberChild, o.numberFree,
	o.firstName, o.lastName,
	o.contactPhone, o.status, c.shortName, o.orderDate, e.nickname

from orders as o
	left join busSchedule as b on o.scheduleId=b.scheduleId
	left join tours as t on b.tourId=t.tourId
	left join Company as c on o.agentId=c.companyId
    left join employeeInfo as e on o.empId=e.employeeID
";

            string cnd = condition.GetCondition("b", "o");
            if (cnd != null && cnd.Length > 0)
                sql += " WHERE " + cnd;
            sql += " order by orderId desc";

            return m_dao.ExecuteDataSet(sql, null);
        }
         

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Orders.OrdersDataTable GetOrdersByScheduleID(int scheduleID)
        {
            if (scheduleID <= 0) return null;

            string sql = @"
SELECT o.orderId, o.scheduleId, o.pickup, o.numberAdult, o.numberChild, o.numberFree, 
      o.fare, o.bookRooms, o.roomShare, o.actualAmount, o.actualAmount-o.pay as balance, o.empId, o.firstName, 
      o.lastName, o.contactPhone, o.email, o.agentId, e.nickname, c.shortName
FROM orders AS o 
	left join EmployeeInfo AS e ON o.empId = e.employeeID
	left join Company AS c ON o.agentId = c.companyId
WHERE o.scheduleID=@scheduleID";
            DS_Orders ds = new DS_Orders();
            SqlParameter[] para = {
                new SqlParameter("@scheduleID", scheduleID)
            };
            m_dao.FillDataSet(ds, "Orders", sql, para);
            return ds.Orders;
        }
        #endregion

        #region FreeOrders
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetOpenOrdersByScheduleID(int scheduleID)
        {
            string sql = @"
select 
	orderId, a.scheduleId, 
	c.tourName_cn as tourName,
	b.startDate,
	ltrim(str(numberAdult)) + ' / ' + ltrim(str(numberChild)) as num,
	firstName+'.'+lastName as customerName,
	contactPhone, a.status

from orders as a
	left join busSchedule b on a.scheduleId=b.scheduleId
	left join tours c on b.tourId=c.tourId

where a.status<6 and a.scheduleId=@scheduleId

order by orderId desc
";
            SqlParameter[] para = {
                new SqlParameter("@scheduleId", scheduleID)
            };
            return m_dao.ExecuteDataSet(sql, para);
        }

        #endregion

        #region OrderPrice
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Orders.OrderPriceDataTable GetOrderPrice(int orderID)
        {
            if (orderID <= 0) return null;

            string sql = @"
SELECT orderId, scheduleId, priceAdult, priceChild
FROM orders
WHERE orderID=@orderID";
            SqlParameter[] para = {
                new SqlParameter("@orderID", orderID),
            };
            DS_Orders ds = new DS_Orders();
            m_dao.FillDataSet(ds, "OrderPrice", sql, para);
            return ds.OrderPrice;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public bool UpdateOrderPrice(int original_orderID, decimal priceAdult, decimal priceChild)
        {
            string sql = @"
update orders
    set priceAdult=@priceAdult, priceChild=@priceChild
where orderID=@orderID";
            SqlParameter[] para = {
                new SqlParameter("@priceAdult", priceAdult),
                new SqlParameter("@priceChild", priceChild),
                new SqlParameter("@orderID", original_orderID),
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }


        #endregion

        #region Order list
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetEmployeeOrders(int employeeID)
        {
            if (employeeID <= 0) return null;

            string sql = @"
select 
	o.orderId, o.scheduleId, o.orderType, t.tourName, t.tourName_cn,
	b.startDate,
	o.numberAdult, o.numberChild, o.numberFree,
	o.firstName, o.lastName,
	o.contactPhone, o.status, c.shortName as fromAgent, ct.shortName as toAgent, o.orderDate
from orders as o
	left join busSchedule as b on o.scheduleId=b.scheduleId
	left join tours as t on b.tourId=t.tourId
	left join Company as c on o.agentId=c.companyId
    left join Company as ct on o.agentTransfor=ct.companyID
where o.status<6 and o.empId=@empId
order by orderId desc";
            SqlParameter[] para = {
                new SqlParameter("@empId", employeeID),
            };
            return m_dao.ExecuteDataSet(sql, para);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetWebOrders()
        {
            string sql = @"
select 
	o.orderId, o.scheduleId, o.orderType, t.tourName, t.tourName_cn,
	b.startDate,
	o.numberAdult, o.numberChild, o.numberFree,
	o.firstName, o.lastName,
	o.contactPhone, o.status, c.shortName, o.orderDate
from orders as o
	left join busSchedule as b on o.scheduleId=b.scheduleId
	left join tours as t on b.tourId=t.tourId
	left join Company as c on o.agentId=c.companyId
where o.isWebOrder=1
order by orderId desc";
            return m_dao.ExecuteDataSet(sql, null);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetActiveOrders()
        {
            string sql = @"
select 
	o.orderId, o.scheduleId, o.orderType, t.tourName, t.tourName_cn,
	b.startDate,
	o.numberAdult, o.numberChild, o.numberFree,
	o.firstName, o.lastName,
	o.contactPhone, o.status, c.shortName as fromAgent, ct.shortName as toAgent, o.orderDate, e.nickname
from orders as o
	left join busSchedule as b on o.scheduleId=b.scheduleId
	left join tours as t on b.tourId=t.tourId
	left join Company as c on o.agentId=c.companyId
    left join Company as ct on o.agentTransfor=ct.companyId
	left join employeeInfo as e on o.empId=e.employeeID
where o.status<6
order by orderId desc";
            return m_dao.ExecuteDataSet(sql, null);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet SearchOrders(int scheduleID, string customerName, string phone, DateTime startDate, DateTime endDate)
        {
            string sql = @"
select 
	o.orderId, o.scheduleId, o.orderType, t.tourName, t.tourName_cn,
	b.startDate,
	o.numberAdult, o.numberChild, o.numberFree,
	o.firstName, o.lastName,
	o.contactPhone, o.status, c.shortName, o.orderDate, e.nickname
from orders as o
	left join busSchedule as b on o.scheduleId=b.scheduleId
	left join tours as t on b.tourId=t.tourId
	left join Company as c on o.agentId=c.companyId
	left join employeeInfo as e on o.empId=e.employeeID
where 
    (@scheduleId=0 or o.scheduleId=@scheduleId) and 
    (@customerName is null or firstName+' '+lastName like @customerName) and
    (@phone is null or contactPhone like @phone) and
    (b.startDate>=@startDate) and
    (b.startDate<=@endDate) and (@status>90 or o.status=@status)
order by orderId desc";
            SqlParameter[] para = {
                new SqlParameter("@scheduleID", scheduleID),
                new SqlParameter("@customerName", customerName),
                new SqlParameter("@phone", phone),
                new SqlParameter("@startDate", startDate),
                new SqlParameter("@endDate", endDate),
            };
            return m_dao.ExecuteDataSet(sql, para);
        }


        #endregion

        public int GetAgentID(int orderID) //应放入orderBiz
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


    }
}
