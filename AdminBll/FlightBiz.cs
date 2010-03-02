using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.DLL;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class FlightBiz : AdminBll
    {
        #region GetFlights, GetFlight
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Flight.FlightDetailDataTable GetFlights(int status)
        {
            string sql = @"
SELECT flightId, airportFrom, airportTo, airline, flight, roundTrip, nonStop, priceAdult, 
      priceChild, notes, status
FROM Flights where status>=@status
order by flightId desc";
            SqlParameter[] para = {
                new SqlParameter("@status", status)
            };
            DS_Flight ds = new DS_Flight();
            m_dao.FillDataSet(ds, "FlightDetail", sql, para);
            return ds.FlightDetail;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Flight.FlightDetailDataTable GetFlight(int flightID)
        {
            string sql = @"
SELECT flightID, airportFrom, airportTo, airline, flight, roundTrip, nonStop, priceAdult, 
      priceChild, notes, status
FROM Flights where flightID=@flightID";
            SqlParameter[] para = {
                new SqlParameter("@flightID", flightID)
            };
            DS_Flight ds = new DS_Flight();
            m_dao.FillDataSet(ds, "FlightDetail", sql, para);
            return ds.FlightDetail;
        }
        #endregion

        #region Update
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public bool UpdateFlight(int original_flightID, 
            string airportFrom, string airportTo, string airline, string flight,
            bool roundTrip, bool nonStop,
            decimal priceAdult, decimal priceChild,
            string notes, int status)
        {
            if (original_flightID <= 0) return false;

            string sql = @"
update Flights
set airportFrom=upper(@airportFrom), airportTo=upper(@airportTo), airline=upper(@airline), flight=@flight, 
    roundTrip=@roundTrip, nonStop=@nonStop, 
    priceAdult=@priceAdult, priceChild=@priceChild, notes=@notes, status=@status
where flightID=@flightID";
            SqlParameter[] para = {
                new SqlParameter("@flightID", original_flightID),
                new SqlParameter("@airportFrom", airportFrom),
                new SqlParameter("@airportTo", airportTo),
                new SqlParameter("@airline", airline),
                new SqlParameter("@flight", flight),
                new SqlParameter("@roundTrip", roundTrip),
                new SqlParameter("@nonStop", nonStop),
                new SqlParameter("@priceAdult", priceAdult),
                new SqlParameter("@priceChild", priceChild),
                new SqlParameter("@notes", notes),
                new SqlParameter("@status", status)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, false)]
        public bool AddFlight(
            string airportFrom, string airportTo, string airline, string flight,
            bool roundTrip, bool nonStop,
            decimal priceAdult, decimal priceChild,
            string notes, int status)
        {
            string sql = @"
insert Flights
(airportFrom, airportTo, airline, flight, 
    roundTrip, nonStop, 
    priceAdult, priceChild, notes, status)
values
(upper(@airportFrom), upper(@airportTo), upper(@airline), @flight, 
    @roundTrip, @nonStop, 
    @priceAdult, @priceChild, @notes, @status)";
            SqlParameter[] para = {
                new SqlParameter("@airportFrom", airportFrom),
                new SqlParameter("@airportTo", airportTo),
                new SqlParameter("@airline", airline),
                new SqlParameter("@flight", flight),
                new SqlParameter("@roundTrip", roundTrip),
                new SqlParameter("@nonStop", nonStop),
                new SqlParameter("@priceAdult", priceAdult),
                new SqlParameter("@priceChild", priceChild),
                new SqlParameter("@notes", notes),
                new SqlParameter("@status", status)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Delete, false)]
        public void DeleteFlight(int original_flightID)
        {
            string sql = "update flights set status=0 where flightID=@flightID";
            SqlParameter[] para = {
                new SqlParameter("@flightID", original_flightID)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        #endregion

    }
}
