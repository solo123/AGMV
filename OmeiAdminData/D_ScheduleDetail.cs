using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.OmeiAdminData
{
    public class D_ScheduleDetail
    {
        public int scheduleId, tourId, maxSeats;
        public string tourName;
        public DateTime startDate, returnDate;
        public int vehicleId, driverId, driverAssId, tourGuideId, tourGuideAssId;
        public decimal priceAdult, priceChild;
        public int bookCustomers, actualCustomers;
        public byte status, createMode;

        public D_ScheduleDetail()
        {
            scheduleId = tourId = maxSeats =
                vehicleId = driverId = driverAssId = tourGuideId = tourGuideAssId = -1;
            tourName = "";
            startDate = returnDate = new DateTime(1900, 1, 1);
            priceAdult = priceChild = 0;

            bookCustomers = actualCustomers = 0;

            status = createMode = 0;
        }
    }
}
