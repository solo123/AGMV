using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.OmeiAdminData;

namespace com.Omei.BLL.Admin
{
    public class MenuBiz : AdminBll
    {
        #region GetSubMenu
        public DS_Menu GetSubMenu(string menuType, string roleIds)
        {
            string sql = "select menuKey, title_cn as title, pageUrl from menuAdmin where menuType=@menuType order by menuOrder";
            SqlParameter[] para = {
                new SqlParameter("@menuType", menuType)
            };
            DS_Menu ds = new DS_Menu();
            m_dao.FillDataSet(ds, "MenuTbl", sql, para);
            return ds;
        }
        #endregion

    }
}
