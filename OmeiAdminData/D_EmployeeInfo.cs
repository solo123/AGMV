using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.OmeiAdminData
{
    public class D_EmployeeInfo
    {
        public int userId;
        public DateTime employDate, birthday;
        public string ssn, roles, positions;
        public int companyId;
        public byte status;

        public D_EmployeeInfo()
        {
            userId = companyId = 0;
            ssn = roles = positions = "";
            status = 0;
        }
    }
}
