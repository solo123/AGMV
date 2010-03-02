using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.DLL;
using com.Omei.DLL.DS_AuthorizationTableAdapters;
using com.Omei.OmeiDataSet;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class ActionAuthorization : AdminBll
    {
        #region RolesMenu
        
        /*
        public DS_Menu.MenuItemDataTable GetRolesMenu(string roles)
        {
            string r;
            if (roles == null || roles == string.Empty)
                r = "0";
            else
                r = "0," + roles;

            DS_Authorization ds = new DS_Authorization();
            string sql = @"
select DISTINCT m.menuID, parentID, title, description, menuOrder, navigateUrl, status, 
      menuType
from authRoleAction as r
	inner join AdminMenu as m on m.menuID=r.menuID
where r.menuID>0 and m.menutype=10 and r.actionID=0 and roleID in (" + r +") order by m.menuOrder";
            m_dao.FillDataSet(ds, "MenuItems", sql, null);
            return ds.MenuItems;
        }
        */
        #endregion
        
        #region GetActions
        public DS_Authorization.AuthActionDataTable GetActions()
        {
            AuthActionTableAdapter adp = new AuthActionTableAdapter();
            return adp.GetActions();
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
        public DS_Authorization.AuthActionDataTable GetActionByID(int actionID)
        {
            AuthActionTableAdapter adp = new AuthActionTableAdapter();
            return adp.GetActionByID(actionID);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, true)]
        public bool UpdateAction(string description, int itemType, int menuID, int showOrder, int original_actionID)
        {
            AuthActionTableAdapter adp = new AuthActionTableAdapter();
            int i = adp.UpdateAction(description, itemType, menuID, showOrder, original_actionID);
            return (i == 1);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Delete, true)]
        public bool DeleteAction(int original_actionID)
        {
            string sql = @"
delete authAction where actionID=@actionID;
delete authRoleAction where actionID=@actionID;";
            SqlParameter[] para = {
                new SqlParameter("@actionID", original_actionID)
            };
            m_dao.ExecuteNoQuery(sql, para);
            return true;
        }
        #endregion

        #region RoleAuth

        public string GetEmployeeRoles(int employeeID)
        {
            return GetEmpRoleOrPosition(employeeID, 1);
        }
        public string GetEmployeePositions(int employeeID)
        {
            return GetEmpRoleOrPosition(employeeID, 2);
        }
        private string GetEmpRoleOrPosition(int employeeID, int roleType)
        {
            string sql = "select roleID from userRole where roleType=@roleType and employeeID=@employeeID";
            SqlParameter[] para = {
                new SqlParameter("@employeeID", employeeID),
                new SqlParameter("@roleType", roleType)
            };
            IDataReader dr = m_dao.ExecuteReader(sql, para);
            StringBuilder sb = new StringBuilder();
            while (dr.Read())
            {
                sb.Append(dr["roleID"]);
                sb.Append(',');
            }
            if (sb.Length > 1) sb.Remove(sb.Length - 1, 1);
            return sb.ToString();
        }

        public DS_Authorization.RoleActionDataTable GetRoleAuth(int roleID)
        {
            RoleActionTableAdapter adp = new RoleActionTableAdapter();
            return adp.GetRoleAuth(roleID);
        }
        public void AddRoleAuth(int roleID, int actionID, int menuID)
        {
            string sql = @"
if(select count(*) from authRoleAction where roleID=@roleID and actionID=@actionID and menuID=@menuID)=0
begin
    insert into authRoleAction
    (roleID, actionID, menuID)
    values
    (@roleID, @actionID, @menuID);
end;
";
            SqlParameter[] para = {
                new SqlParameter("@roleID", roleID),
                new SqlParameter("@actionID", actionID),
                new SqlParameter("@menuID", menuID)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        public void DelRoleAuthNotIn(int roleID, string actions, string menus)
        {
            string sql = @"delete authRoleAction where roleID=@roleID ";
            if (actions != null && actions.Length>0)
                sql += " and (actionID>0 and actionID not in (" + actions + "))";
            if (menus!=null && menus.Length>0)
                sql += " and ( menuID>0 and menuID not in (" + menus + "))";
            SqlParameter[] para = {
                new SqlParameter("@roleID", roleID)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        #endregion

        #region CheckAuthorization

        public bool CheckAuthorization(object loginUserInfo, string actionName)
        {
            if (actionName == null || actionName == "" || loginUserInfo==null || !(loginUserInfo is D_LoginUserInfo) )
                return false;

            D_LoginUserInfo ui = loginUserInfo as D_LoginUserInfo;

            string sql = @"
declare @cnt int;
select @cnt=count(*)
from authAction as act
	left join authRoleAction as rol on act.actionID=rol.actionID
where actionName=@actionName and rol.roleID in (0";

            if (ui.roleIds != null && ui.roleIds != "")
                sql += "," + ui.roleIds;
            
            sql += @");

if (@cnt<1)
begin
    if (select count(*) from authAction where actionName=@actionName) < 1
    begin
        insert authAction
        (actionName, description, itemType, menuID, showOrder)
        values
        (@actionName,@actionName, 0, 0, 100);
    end
end;

select @cnt;
";
            SqlParameter[] para = {
                new SqlParameter("@actionName", actionName)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null || Convert.ToInt32(o) < 1)
                return false;
            else
                return true;
        }

        public bool CheckPageAuthorization(object loginUserInfo, string pageUrl, string pageName)
        {
            if(pageUrl==null || pageUrl=="" || loginUserInfo==null || !(loginUserInfo is D_LoginUserInfo))
                return false;
            return true;

            D_LoginUserInfo ui = loginUserInfo as D_LoginUserInfo;
            if (ui.roleIds == "")
            {
                EventLog.OpLog( loginUserInfo, "Access Denided:<a href='" + pageUrl +"' targert='logWin'>"+ pageUrl+"</a>", 3, ui.userId);
                return false;
            }

            string sql = @"
select top 1 m.description 
from adminmenu as m
	left join authRoleAction as a on m.menuID=a.menuID
where m.pageName=@pageName and a.roleID in (0," + ui.roleIds + ")";
            SqlParameter[] para = {
                new SqlParameter("@pageName", pageName)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null)
            {
                EventLog.OpLog(loginUserInfo, "Access Denided:<a href='" + pageUrl+"' target='logWin'>" + pageUrl+"</a>", 3, ui.userId);
                return false;
            }
            else
            {
                EventLog.OpLog(loginUserInfo, "Browse:<a href='" + pageUrl+"' target='logWin'>"+ o.ToString() + "</a>", 2, ui.userId);
                return true;
            }
        }

        public bool GetPageAuthorization(object loginUserInfo, string pageName)
        {
            if (loginUserInfo == null || !(loginUserInfo is D_LoginUserInfo))
                return false;

            D_LoginUserInfo ui = loginUserInfo as D_LoginUserInfo;
            if (ui.roleIds == "") return false;

            string sql = @"
select count(*) 
from adminmenu as m
	left join authRoleAction as a on m.menuID=a.menuID
where m.pageName=@pageName and a.roleID in (0," + ui.roleIds + ")";
            SqlParameter[] para = {
                new SqlParameter("@pageName", pageName)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null || Convert.ToInt32(o)<1)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        #endregion
    }
}
