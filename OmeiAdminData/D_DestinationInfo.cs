using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.OmeiAdminData
{
    public class D_DestinationInfo
    {
        public int destinationId, titlePic;
        public string destinationName, destinationName_cn;
        public string city, state, country, description, description_cn;
        public byte status;

        public D_DestinationInfo()
        {
            destinationId = -1;
            titlePic = 0;
            destinationName = destinationName_cn =
                city = state = country =
                description = description_cn = "";
            status = 0;
        }
    }
}
