using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.OmeiAdminData
{
    public class D_MasterPageInfo
    {
        public int MainMenuSelectIndex;
        public int SubMenuSelectIndex;

        public D_MasterPageInfo()
        {
            MainMenuSelectIndex = SubMenuSelectIndex = -1;
        }
    }
}
