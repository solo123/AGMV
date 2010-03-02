using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;

using com.Omei.DLL;
using com.Omei.DLL.DS_MenuTableAdapters;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class AdminMenuBiz :AdminBll
    {
        #region MenuItems select, update, add
        public DS_Menu.MenuItemDataTable GetMenuItems(bool getAllItems)
        {
            string sql = @"
SELECT menuID, parentID, title, description, pageName, menuOrder, navigateUrl, status, 
      menuType
FROM AdminMenu";
            if (!getAllItems)
                sql += " WHERE status=1";

            DS_Menu ds = new DS_Menu();
            m_dao.FillDataSet(ds, "MenuItem", sql, null);
            return ds.MenuItem;
        }
        public DS_Menu.MenuItemDataTable GetMenuItemsByRoles(string roles)
        {
            DS_Menu ds = new DS_Menu();
            string sql = @"
SELECT menuID, parentID, title, description, pageName, menuOrder, navigateUrl, status, menuType
FROM AdminMenu
WHERE menuID in (
	select DISTINCT menuID 
	from authRoleAction
	where menuID>0 and roleID in (0,"+ roles +")) and status=1 and menuType=10";
            m_dao.FillDataSet(ds, "MenuItem", sql, null);
            return ds.MenuItem;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
        public DS_Menu.MenuItemDataTable GetMenuItemByID(int menuID)
        {
            MenuItemTableAdapter adp = new MenuItemTableAdapter();
            return adp.GetMenuItemByID(menuID);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, true)]
        public bool UpdateMenuItem(int original_menuID,
            int parentID, string title, string description, string pageName,
            int menuOrder, string navigateUrl, int status, int menuType)
        {
            string sql = @"
UPDATE AdminMenu
SET parentID = @parentID, title = @title, description = @description, pageName=@pageName,
      menuOrder = @menuOrder, navigateUrl = @navigateUrl, status = @status, 
      menuType = @menuType
WHERE (menuID = @menuID)";

            SqlParameter[] para = {
                new SqlParameter("@menuID", original_menuID),
                new SqlParameter("@title", title),
                new SqlParameter("@description", description),
                new SqlParameter("@pageName", pageName),
                new SqlParameter("@menuOrder", menuOrder),
                new SqlParameter("@parentId", parentID),
                new SqlParameter("@navigateUrl", navigateUrl),
                new SqlParameter("@menuType", menuType),
                new SqlParameter("@status", status)
            };
            int r = m_dao.ExecuteNoQuery(sql, para);
            return (r == 1);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, true)]
        public bool AddMenuItem(
            int parentID, string title, string description, string pageName,
            int menuOrder, string navigateUrl, int status, int menuType)
        {
            string sql = @"
INSERT INTO AdminMenu
      (title, description, pageName, menuOrder, parentId, navigateUrl, status, menuType)
VALUES (@title,@description, @pageName, @menuOrder,@parentId,@navigateUrl,@status,@menuType)";

            SqlParameter[] para = {
                new SqlParameter("@title", title),
                new SqlParameter("@description", description),
                new SqlParameter("@pageName", pageName),
                new SqlParameter("@menuOrder", menuOrder),
                new SqlParameter("@parentId", parentID),
                new SqlParameter("@navigateUrl", navigateUrl),
                new SqlParameter("@menuType", menuType),
                new SqlParameter("@status", status)
            };

            int r = m_dao.ExecuteNoQuery(sql, para);
            return (r == 1);
        }
        #endregion

        /*
        public int MainMenuSelectIndex, SubMenuSelectIndex, MainMenuSelectValue;

        public AdminMenuBiz()
        {
            MainMenuSelectIndex = SubMenuSelectIndex = MainMenuSelectValue = 0;
        }

        #region GetMenuInfo
        public D_MenuInfo GetMenuInfo(int menuId)
        {
            D_MenuInfo mi = new D_MenuInfo();
            string sql = "select * from adminmenu where menuId=@menuId";
            SqlParameter[] para = {
                new SqlParameter("@menuId", menuId)
            };
            IDataReader dr = m_dao.ExecuteReader(sql, para);
            if (dr.Read())
            {
                mi.menuId = (int)dr["menuId"];
                mi.pageName = (string)dr["pageName"];
                mi.title = (string)dr["title"];
                mi.title_cn = (string)dr["title_cn"];
                mi.menuOrder = (int)dr["menuOrder"];
                mi.parentId = (int)dr["parentId"];
                mi.commandName = (string)dr["commandName"];
                mi.navigateUrl = (string)dr["navigateUrl"];
                mi.needConfirm = (byte)dr["needConfirm"];
                mi.confirmMessage = (string)dr["confirmMessage"];
                mi.confirmMessage_cn = (string)dr["confirmMessage_cn"];
                mi.status = (byte)dr["status"];
            }
            return mi;
        }

        #endregion

        #region UpdateMenu
        public void UpdateMenu(D_MenuInfo menuInfo)
        {
            string sql = @"
update adminmenu
set
    pageName=@pageName,
    title=@title,
    title_cn=@title_cn,
    menuOrder=@menuOrder,
    parentId=@parentId,
    commandName=@commandName,
    navigateUrl=@navigateUrl,
    needConfirm=@needConfirm,
    confirmMessage=@confirmMessage,
    confirmMessage_cn=@confirmMessage_cn,
    status=@status
where menuId=@menuId;
";
            SqlParameter[] para = {
                new SqlParameter("@menuId", menuInfo.menuId),
                new SqlParameter("@pageName", menuInfo.pageName),
                new SqlParameter("@title", menuInfo.title),
                new SqlParameter("@title_cn", menuInfo.title_cn),
                new SqlParameter("@menuOrder", menuInfo.menuOrder),
                new SqlParameter("@parentId", menuInfo.parentId),
                new SqlParameter("@commandName", menuInfo.commandName),
                new SqlParameter("@navigateUrl", menuInfo.navigateUrl),
                new SqlParameter("@needConfirm", menuInfo.needConfirm),
                new SqlParameter("@confirmMessage", menuInfo.confirmMessage),
                new SqlParameter("@confirmMessage_cn", menuInfo.confirmMessage_cn),
                new SqlParameter("@status", menuInfo.status)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        #endregion

        #region AddMenu
        public void AddMenu(int menuId, string title)
        {
            string sql = "insert adminMenu (menuId, title, title_cn, status) values (@menuId, @title, @title, 0)";
            SqlParameter[] para = {
                new SqlParameter("@menuId", menuId),
                new SqlParameter("@title", title)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        #endregion

        #region UpdateRoles
        public void UpdateRoles(int menuId, string roleIds)
        {
            string sql = "update adminmenu set roleIds=@roleIds where menuId=@menuId";
            SqlParameter[] para = {
                new SqlParameter("@menuId", menuId),
                new SqlParameter("@roleIds", roleIds)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        #endregion

        #region GetPageRoles
        public string GetPageRoles(string pageName)
        {
            string sql = "select top 1 roleIds from adminmenu where pageName=@pageName and status=1 and commandName=''";
            SqlParameter[] para = {
                new SqlParameter("@pageName", pageName)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null)
                return "";
            else
                return (string)o;
        }
        #endregion

        #region Static RPInIt
        public bool RPInIt(string alist, string allowList)
        {
            if (allowList == "")
            {
                if (alist==null || alist == "")
                    return true;
                else
                    return false;
            }
            if (alist == null || alist == "") return false;

            string[] arrList = alist.Split(']');
            for (int i = 0; i < arrList.Length; i++)
            {
                if (arrList[i] != null && arrList[i] != "")
                {
                    if (allowList.IndexOf(arrList[i] + "]") >= 0)
                        return true;
                }
            }
            return false;
        }
        #endregion

        #region page access
        public string GetPageRoleAndPosition(string pageUrl)
        {
            string sql = @"
select top 1 roleIds +',' + positionIds from adminMenu
where menuType=2 and navigateUrl<>'' and patindex('%'+navigateUrl+'%', @pageUrl)>0";
            SqlParameter[] para = {
                new SqlParameter("@pageUrl", pageUrl)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o != null && o is string)
            {
                return o.ToString();
            }
            return string.Empty;
        }
        #endregion

        // -------- New menu operate --------

        #region GetMenuData
        public com.Omei.DLL.DS_Menu.AdminMenuDataTable GetMenus()
        {
            com.Omei.DLL.DS_MenuTableAdapters.AdminMenuTableAdapter adp = new AdminMenuTableAdapter();
            return adp.GetData();
        }

        #endregion

*/
    }
}
