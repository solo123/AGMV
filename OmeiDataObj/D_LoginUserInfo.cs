using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.OmeiDataSet
{
    public class D_LoginUserInfo
    {
        public string username;
        public int userId;
        public string ticket, roleIds, positionIds;
        public string tel;

        public D_LoginUserInfo()
        {
            userId = -1;
            username = ticket = roleIds = positionIds = tel = "";
        }

        public bool IsAdmin()
        {
            return (roleIds != null && roleIds.IndexOf("9") >= 0);
        }
        public bool IsDirector()
        {
            return (positionIds != null && positionIds.IndexOf("9") >= 0);
        }
    }
}
