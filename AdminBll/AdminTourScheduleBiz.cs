using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.OmeiAdminData;
using com.Omei.OmeiDataSet;
using com.Omei.DLL;
using com.Omei.DLL.DS_SchedulesTableAdapters;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class AdminTourScheduleBiz :AdminBll
    {
        #region GetScheduleList
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Schedules.TourScheduleListDataTable GetCurrentSchedulesByTourID(int tourID)
        {
            string sql = @"
SELECT s.scheduleId, s.startDate, s.endDate, 
      s.createMode, s.status, s.maxSeats, 
      s.bookCustomers, t.priceAdult, t.priceChild, 
      tg.nickname AS tourGuide, 
      dr.firstName + '.' + dr.middleName AS Driver
FROM BusSchedule as s 
    left join employeeInfo as tg ON s.tourGuideId = tg.employeeID 
    left join userInfo as dr ON s.driverId = dr.userId
    left join tours as t on s.tourID=t.tourID
WHERE s.tourId=@tourID and s.startDate>=(getdate()-1)
ORDER BY s.startDate
";
            SqlParameter[] para = {
                new SqlParameter("@tourID", tourID)
            };
            DS_Schedules ds = new DS_Schedules();
            m_dao.FillDataSet(ds, "TourScheduleList", sql, para);
            return ds.TourScheduleList;
        }

        #endregion

        #region GenSchedule
        public void GenSchedule(int tourId, string weekly, int tourDays)
        {
            DateTime today = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day);
            for (int i = 0; i < 90; i++)
            {
                DateTime stdate = today.AddDays(i);
                if (weekly.IndexOf(stdate.DayOfWeek.ToString("d")) >= 0)
                {
                    AddSchedule(tourId, stdate, tourDays, 1);
                }
            }
        }
        public int GenSepcialSchedule(int tourId, DateTime startDate, int days)
        {
            string sql = @"
declare @pa decimal;
declare @pc decimal;
select @pa=priceAdult, @pc=priceChild from tours where tourId=@tourId;

insert BusSchedule 
(tourId, startDate, endDate, status, createMode, priceAdult, priceChild)
values
(@tourId, @startDate, @startDate+@days-1, 1, 2, @pa, @pc);
select SCOPE_IDENTITY() as id;
";
            SqlParameter[] para = {
                new SqlParameter("@tourId", tourId),
                new SqlParameter("@startDate", startDate),
                new SqlParameter("@days", days)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            return Convert.ToInt32(o);
        }
        #endregion

        #region Add & update & Delete
        public void AddSchedule(int tourId, DateTime startDate, int days, byte createMode)
        {
            int r = 0;
            SqlParameter successFlag = new SqlParameter("@successFlag", r);
            successFlag.Direction = ParameterDirection.Output;
            SqlParameter[] para = {
                new SqlParameter("@tourId", tourId),
                new SqlParameter("@startDate", startDate),
                new SqlParameter("@days", days),
                new SqlParameter("@createMode", createMode),
                successFlag
            };
            m_dao.ExecuteNoQuery("GenSchedule", para, true);

            r = (int)successFlag.Value;
            // 对返回值的处理
            // ....
        }

        public void GetPriceFromTour()
        {
            string sql = @"
update busSchedule
set 
	priceAdult=t.priceAdult, 
	priceChild=t.priceChild
from busSchedule a
	join tours t on a.tourId=t.tourId
where a.priceAdult=0;";
            m_dao.ExecuteNoQuery(sql, null);
        }

        public int Add()
        {
            string SQL = @"
insert BusSchedule
(status)
values
(0);
select SCOPE_IDENTITY() as id;
";
            object o = m_dao.ExecuteScalar(SQL, null);
            int id = Convert.ToInt32(o);
            return id;
        }

        public void DeleteTour(int scheduleId)
        {
            string SQL = "delete BusSchedule where scheduleId=@scheduleId";
            SqlParameter[] para = {
                new SqlParameter("@scheduleId", scheduleId)
            };
            m_dao.ExecuteNoQuery(SQL, para);
        }

//        public bool Update(Dictionary<string, object> row)
//        {
//            string SQL = @"
//update BusSchedule
//set
//    tourId=@tourId,
//    startDate=@startDate,
//    endDate=@endDate,
//    maxSeats=@maxSeats,
//    status=@status,
//    createMode=@createMode
//where scheduleId=@scheduleId
//";
//            SqlParameter[] para = new SqlParameter[row.Count];
//            int i = 0;
//            foreach (KeyValuePair<string, object> kvp in row)
//            {
//                para[i++] = new SqlParameter("@" + kvp.Key, kvp.Value);
//            }
//            m_dao.ExecuteNoQuery(SQL, para);
//            return true;
//        }

        public void ChangeStatus(string ids, byte status)
        {
            string sql = @"
update BusSchedule
    set status=@status
    where scheduleId in (" + ids +") and status<8;";
            SqlParameter[] para = {
                new SqlParameter("@status", status)
            };
            m_dao.ExecuteNoQuery(sql, para);
            //LOG it
        }
        #endregion

        #region GetScheduleDetail
        public D_ScheduleDetail GetScheduleDetail(int scheduleId)
        {
            string sql = @"
select *
from BusSchedule
where scheduleId=@scheduleId;
";
            SqlParameter[] para = {
                new SqlParameter("@scheduleId", scheduleId)
            };
            D_ScheduleDetail si = new D_ScheduleDetail();
            IDataReader dr = m_dao.ExecuteReader(sql, para);
            if (dr.Read())
            {
                si.scheduleId = (int)dr["scheduleId"];
                si.tourId = (int)dr["tourId"];
                si.startDate = (DateTime)dr["startDate"];
                si.returnDate = (DateTime)dr["endDate"];
                si.priceAdult = (decimal)dr["priceAdult"];
                si.priceChild = (decimal)dr["priceChild"];
                si.maxSeats = (int)dr["maxSeats"];
                si.vehicleId = (int)dr["vehicleId"];
                si.driverId = (int)dr["driverId"];
                si.driverAssId = (int)dr["driverAssistanceId"];
                si.tourGuideId = (int)dr["tourGuideId"];
                si.tourGuideAssId = (int)dr["tourGuideAssistanceId"];
                si.bookCustomers = (int)dr["bookCustomers"];
                si.actualCustomers = (int)dr["actualCustomers"];
                si.status = (byte)dr["status"];
                si.createMode = (byte)dr["createMode"];
            }
            return si;
        }
        #endregion

        #region AddScheduleHotels, UpdateScheduleHotel
        public void AddScheduleHotels(int scheduleID, int nights)
        {
            if (scheduleID == 0 || nights==0) return;

            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < nights; i++)
            {
                sb.Append("insert into ScheduleHotel (scheduleID, hotelID, night) values (");
                sb.Append(scheduleID);
                sb.Append(", ");
                sb.Append("0, ");
                sb.Append(i+1);
                sb.Append(");\n");
            }
            m_dao.ExecuteNoQuery(sb.ToString(), null);
        }

        public void UpdateScheduleHotel(int scheduleHotelID, int hotelID, int night)
        {
            string sql = "update ScheduleHotel set hotelID=@hotelID, night=@night where scheduleHotelID=@scheduleHotelID";
            SqlParameter[] para = {
                new SqlParameter("@scheduleHotelID", scheduleHotelID),
                new SqlParameter("@hotelID", hotelID),
                new SqlParameter("@night", night)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        #endregion

        #region scheduleStatics
        public void ScheduleStatics(int scheduleID)
        {
            if (scheduleID > 0)
            {
                string sql = @"
declare @bookCustomers int, @actualCustomers int, @actualRooms decimal(18,2);

select @bookCustomers = sum(numberAdult+numberChild+numberFree),
    @actualRooms = sum(bookRooms)
from orders
where scheduleID=@scheduleID and status<>7;

select @actualCustomers=sum(numberAdult+numberChild+numberFree)
from orders
where scheduleID=@scheduleID and (status=3 or status=8);

if @bookCustomers is null set @bookCustomers=0;
if @actualCustomers is null set @actualCustomers=0;
if @actualRooms is null set @actualRooms=0;

update busSchedule
set bookCustomers=@bookCustomers, actualCustomers=@actualCustomers, actualRooms=@actualRooms
where scheduleID=@scheduleID;
";
                SqlParameter[] para = {
                    new SqlParameter("@scheduleID", scheduleID)
                };
                m_dao.ExecuteNoQuery(sql, para);
            }
        }
        #endregion

    }
}
