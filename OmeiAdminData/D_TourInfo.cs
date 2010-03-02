using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.OmeiAdminData
{
    public class D_TourInfo
    {
        public int tourId, tourOrder;
        public string tourName, tourName_cn;
        public decimal priceAdult, priceChild;
        public int tourDay, tourNight;
        public string description, description_cn;
        public byte tourType;
        public byte status;

        public D_TourInfo()
        {
            tourId = -1;
            tourOrder = 0;
            tourName = tourName_cn = description = description_cn = "";
            tourDay = tourNight = tourType = status = 0;
            priceAdult = priceChild = 0;
        }
    }
}
