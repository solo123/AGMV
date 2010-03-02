using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.OmeiDataSet
{
    public class D_ScheduleInfo
    {
        public int ScheduleId;
        public int TourId;
        public string TourName, TourName_cn;
        public int TourDay;
        public int TourType;
        public decimal PriceAdult, PriceChild;
        public DateTime StartDate, EndDate;

        public D_ScheduleInfo()
        {
            ScheduleId = TourId = TourType = TourDay = 0;
            TourName = TourName_cn = "";
            PriceAdult = PriceChild = 0;
            StartDate = EndDate = DateTime.MinValue;
        }
    }
}
