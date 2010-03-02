using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.OmeiDataSet
{
    public class D_UserInfo
    {
        public int userId;
        public string firstName, middleName, lastName;
        public string address, city, state, zip, country;
        public string homephone, cellphone, walkyphone;
        public string email, mailList;

        public D_UserInfo()
        {
            userId = -1;
            firstName = middleName = lastName =
                address = city = state = zip = country =
                homephone = cellphone = walkyphone =
                email = mailList = "";
        }
    }
}
