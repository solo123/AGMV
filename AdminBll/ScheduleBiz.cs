using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.DLL;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class ScheduleBiz : AdminBll
    {
        #region SearchSchedules
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Schedules.SchedulesSearchDataTable SearchSchedules(
            int tourID, int tourType, DateTime startDate, DateTime endDate, int showAll)
        {
            string sql = @"
SELECT s.scheduleId, s.subTitle, t.tourDay, s.startDate, s.maxSeats, 
    s.bookCustomers, s.tourId, s.actualCustomers, t.priceAdult, t.priceChild,
    t.hasSeatTable,
    t.TourName, t.TourName_cn, drvu.firstName + '.' + drvu.lastName AS driver, 
    tgu.nickname AS tourGuide, s.status
FROM BusSchedule as s
    INNER JOIN tours as t ON s.tourId = t.TourID 
    LEFT OUTER JOIN userInfo AS drvu ON s.driverId = drvu.userId 
    LEFT OUTER JOIN employeeInfo AS tgu ON s.tourGuideId = tgu.employeeID";

            StringBuilder sb = new StringBuilder();
            if (tourID > 0)
            {
                sb.Append("s.tourID=");
                sb.Append(tourID);
                sb.Append(" and ");
            }
            if (tourType > 0)
            {
                sb.Append("t.tourType=");
                sb.Append(tourType);
                sb.Append(" and ");
            }
            if (startDate != null && startDate.Year > 1900)
            {
                sb.Append("s.startDate>='");
                sb.Append(startDate.ToShortDateString());
                sb.Append("' and ");
            }
            if (endDate != null && endDate.Year > 1900)
            {
                sb.Append("s.endDate<='");
                sb.Append(endDate.ToShortDateString());
                sb.Append("' and ");
            }
            if (showAll!=1)
            {
                sb.Append("s.status<7 and ");
            }
            if (sb.Length > 5)
            {
                sb.Remove(sb.Length - 5, 5);
                sb.Insert(0, " WHERE ");
            }

            sb.Insert(0, sql);
            sb.Append(" ORDER BY s.startDate");

            DS_Schedules ds = new DS_Schedules();
            m_dao.FillDataSet(ds, "SchedulesSearch", sb.ToString(), null);

            return ds.SchedulesSearch;
        }
        #endregion

        #region FreeSchedule process
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Schedules.FreeSchedulesDataTable GetFreeScheduleDetail(int scheduleID)
        {
            if (scheduleID <= 0) return null;

            string sql = @"
SELECT scheduleId, tourId, subTitle, bookCustomers, actualCustomers, status
FROM BusSchedule
WHERE scheduleId=@scheduleId";
            SqlParameter[] para = {
                new SqlParameter("@scheduleId", scheduleID)
            };
            DS_Schedules ds = new DS_Schedules();
            m_dao.FillDataSet(ds, "FreeSchedules", sql, para);
            return ds.FreeSchedules;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public bool UpdateFreeSchedule(
            int original_scheduleId,
            string subTitle, decimal priceChild, decimal priceAdult, int status)
        {
            string sql = @"
update BusSchedule
set
    subTitle=@subTitle, status=@status
where scheduleId=@scheduleId";
            SqlParameter[] para = {
                new SqlParameter("@subTitle", subTitle),
                new SqlParameter("@status", status),
                new SqlParameter("@scheduleId", original_scheduleId)
            };
            int c = m_dao.ExecuteNoQuery(sql, para);
            return (c == 1);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, false)]
        public void AddFreeSchedule(
            int tourId,
            string subTitle, decimal priceChild, decimal priceAdult, int status)
        {
            string sql = @"
insert BusSchedule
(tourId,subTitle, status)
values
(@tourId,@subTitle, @status)";
            SqlParameter[] para = {
                new SqlParameter("@tourId", tourId),
                new SqlParameter("@subTitle", subTitle),
                new SqlParameter("@status", status),
            };
            int c = m_dao.ExecuteNoQuery(sql, para);
        }
        #endregion


        #region ScheduleEdit
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Schedules.ScheduleBaseInfoDataTable GetSchedulleInfo(int scheduleID)
        {
            if (scheduleID <= 0) return null;

            string sql = @"
SELECT s.scheduleId, s.maxSeats, v.vehicleName, v.customerSeatNum, s.tourId, t.hasSeatTable,
      t.priceAdult, t.priceChild, 
      u1.firstName + '.' + u1.lastName AS driverName, 
      u2.firstName + '.' + u2.lastName AS driverAssName, 
      u3.nickname AS tourGuideName, 
      u4.nickname AS tourGuideAssName, s.vehicleId, s.driverId, s.maxWebSeats,
      s.driverAssistanceId, s.tourGuideId, s.tourGuideAssistanceId, t.tourDay, s.status, s.subTitle, s.startDate, s.endDate
FROM BusSchedule AS s LEFT OUTER JOIN
      vehicles AS v ON s.vehicleId = v.vehicleId LEFT OUTER JOIN
      userInfo AS u1 ON s.driverId = u1.userId LEFT OUTER JOIN
      userInfo AS u2 ON s.driverAssistanceId = u2.userId LEFT OUTER JOIN
      employeeInfo AS u3 ON s.tourGuideId = u3.employeeID LEFT OUTER JOIN
      employeeInfo AS u4 ON s.tourGuideAssistanceId = u4.employeeID left outer join 
      tours as t on s.tourId=t.tourId
WHERE (s.scheduleID = @scheduleId)";
            SqlParameter[] para = {
                new SqlParameter("@scheduleID", scheduleID),
            };

            DS_Schedules ds = new DS_Schedules();
            m_dao.FillDataSet(ds, "ScheduleBaseInfo", sql, para);
            return ds.ScheduleBaseInfo;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public bool UpdateScheduleBaseInfo(
            int original_scheduleID,
            int vehicleID, int maxSeats, int driverID, int driverAssistanceID,
            int tourGuideID, int tourGuideAssistanceID,
            int status, string subTitle, 
            decimal priceAdult, decimal priceChild)
        {
            
            string sql = @"
UPDATE [BusSchedule] 

SET [vehicleId] = @vehicleId, [maxSeats] = @maxSeats, 
[driverId] = @driverId, [driverAssistanceId] = @driverAssistanceId, 
[tourGuideId] = @tourGuideId, [tourGuideAssistanceId] = @tourGuideAssistanceId,
status=@status, subTitle=@subTitle
WHERE (([scheduleId] = @Original_scheduleId))";
            SqlParameter[] para = {
                new SqlParameter("@vehicleID", vehicleID),
                new SqlParameter("@maxSeats", maxSeats),
                new SqlParameter("@driverID", driverID),
                new SqlParameter("@driverAssistanceID", driverAssistanceID),
                new SqlParameter("@tourGuideID", tourGuideID),
                new SqlParameter("@tourGuideAssistanceID", tourGuideAssistanceID),
                new SqlParameter("@status", status),
                new SqlParameter("@subTitle", subTitle),
                new SqlParameter("@Original_scheduleId", original_scheduleID),
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }
        #endregion

    }
}
