using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.OmeiAdminData
{
    public class D_MenuInfo
    {
        public int menuId, menuOrder, parentId;
        public string title, title_cn, commandName, navigateUrl, pageName;
        public string confirmMessage, confirmMessage_cn;
        public byte needConfirm, status;

        public D_MenuInfo()
        {
            menuId = menuOrder = parentId = 0;
            title = title_cn = commandName = navigateUrl = confirmMessage = confirmMessage_cn = 
                pageName = "";
            needConfirm = status = 0;
        }
    }
}
