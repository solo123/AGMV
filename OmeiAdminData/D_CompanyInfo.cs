using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.OmeiAdminData
{
    public class D_CompanyInfo
    {
        public int companyId;
        public string companyName, companyName_cn;
        public string address, city, state, zip, country;
        public string telephone, fax, contactPerson, email;
        public byte companyType;
        public string iconUrl, website, description, description_cn;
        public byte status;

        public D_CompanyInfo()
        {
            companyId = 0;
            companyName = companyName_cn =
                address = city = state = zip = country =
                telephone = fax = contactPerson = email =
                iconUrl = website = description = description_cn = "";
            companyType = status = 0;
        }
    }
}
