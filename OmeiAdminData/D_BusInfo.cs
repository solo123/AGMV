using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.OmeiAdminData
{
    public class D_BusInfo
    {
        public int vehicleId;
        public string vehicleName;
        public byte vehicleType;
        public int customerSeatNum;
        public string plateNumber, vinNumber;
        public DateTime inspectionDate;
        public byte status, own;
        public string notes;

        public D_BusInfo()
        {
            vehicleId = -1;
            customerSeatNum = 0;
            vehicleName = plateNumber = vinNumber = notes = "";
            vehicleType = status = own = 0;
            inspectionDate = new DateTime(1900, 1, 1);
        }
    }
}
