using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.BLL.Admin;
using com.Omei.OmeiDataSet;
using com.Omei.OmeiAdminData;

namespace com.Omei.BLL.Authenticate
{
    public class UserBiz : AdminBll
    {
        public int GetUserIdByName(string loginName)
        {
            string SQL_SELECT_USER_BY_LOGINNAME = "select userId from userLogin where loginName=@loginName";
            SqlParameter[] para = {
                new SqlParameter("@loginName", loginName)
            };
            object o = m_dao.ExecuteScalar(SQL_SELECT_USER_BY_LOGINNAME, para);
            if (o != null)
                return (int)o;
            else
                return -1;
        }

        public int GetUserIdByEmail(string email)
        {
            string SQL_SELECT_USER_BY_LOGINNAME = "select top 1 userId from userInfo where email=@email";
            SqlParameter[] para = {
                new SqlParameter("@email", email)
            };
            object o = m_dao.ExecuteScalar(SQL_SELECT_USER_BY_LOGINNAME, para);
            if (o != null)
                return (int)o;
            else
                return -1;
        }

        public int GetRoleIdByRolename(string roleName)
        {
            string SQL_SELECT_ROLE_BY_NAME = "select roleId from roles where roleName=@roleName";
            SqlParameter[] para = {
                new SqlParameter("@roleName", roleName)
            };
            object o = m_dao.ExecuteScalar(SQL_SELECT_ROLE_BY_NAME, para);
            if (o != null)
                return (int)o;
            else
                return -1;
        }

 //       #region UserList
        /*
        /// <summary>
        /// Get UsersInRole
        /// </summary>
        /// <param name="roleId"></param>
        /// <returns></returns>
        public DS_UserList GetUsersInRole(int roleId)
        {
            if (roleId == 0)
                return GetEmployee();

            string SQL_SELECT_USERS_IN_ROLE = @"
select 
	userId as id, 
	firstName+' '+middleName+' '+lastName as name, 
	homephone as phone, 
	cellphone as cell, 
	walkyphone as pager 
from userInfo
where userId in (
	select userId from userRole where roleId=@roleId
)
";
            DS_UserList ds = new DS_UserList();
            SqlParameter[] para = {
                new SqlParameter("@roleId", roleId)
            };
            m_dao.FillDataSet(ds, "UserTbl", SQL_SELECT_USERS_IN_ROLE, para);
            return ds;
        }
         */

        /*
        public DS_UserList GetEmployee()
        {
            string SQL = @"
select 
	userId as id, 
	firstName+'.'+middleName+'.'+lastName as name, 
	homephone as phone, 
	cellphone as cell, 
	walkyphone as pager 
from userInfo
where userId in (
    select userId from EmployeeInfo
);
";
            DS_UserList ds = new DS_UserList();
            m_dao.FillDataSet(ds, "UserTbl", SQL, null);
            return ds;
        }*/

        /*
        public DS_UserList GetAllUsers()
        {
            string SQL = @"
select 
	userId as id, 
	firstName+' '+middleName+' '+lastName as name, 
	homephone as phone, 
	cellphone as cell, 
	walkyphone as pager 
from userInfo
";
            DS_UserList ds = new DS_UserList();
            m_dao.FillDataSet(ds, "UserTbl", SQL, null);
            return ds;
        }

        /// <summary>
        /// Get UsersToMatch
        /// </summary>
        /// <param name="roleId"></param>
        /// <returns></returns>
        public DS_UserList GetUsersToMatch(string userToMatch)
        {
            string SQL_SELECT_USERS_TO_MATCH = @"
select 
    a.userId as id, 
    a.firstName+' '+a.middleName+' '+a.lastName as name, 
    a.homephone as phone, 
    a.cellphone as cell, 
    a.walkyphone as pager 
from userInfo a, userLogin b
where a.userId=b.userId and ( a.firstName+' ' +a.middleName+' ' +a.lastName like @match or b.loginName like @match)
";
            DS_UserList ds = new DS_UserList();
            SqlParameter[] para = {
                new SqlParameter("@match", userToMatch)
            };
            m_dao.FillDataSet(ds, "UserTbl", SQL_SELECT_USERS_TO_MATCH, para);
            return ds;
        }*/
        /*
        public DS_Roles GetRoles()
        {
            string SQL_ROLES = "select roleId, roleName from roles";

            DS_Roles ds = new DS_Roles();
            m_dao.FillDataSet(ds, "RoleTbl", SQL_ROLES, null);
            return ds;
        }

        #endregion
*/

        #region get & set rolename
        public string GetRoleNameById(int roleId)
        {
            string SQL = "select roleName from roles where roleId=@roleId";
            SqlParameter[] para = {
                new SqlParameter("@roleId",roleId)
            };
            return m_dao.ExecuteScalar(SQL, para).ToString();
        }
        public void UpdateRoleName(int roleId, string roleName)
        {
            string SQL = "update roles set roleName=@roleName where roleId=@roleId";
            SqlParameter[] para = {
                new SqlParameter("@roleId", roleId),
                new SqlParameter("@roleName", roleName)
            };
            m_dao.ExecuteNoQuery(SQL, para);
        }
        #endregion

        public D_UserInfo GetUserInfo(int userId)
        {
            D_UserInfo ui = new D_UserInfo();
            string sql = @"
select * from userInfo where userId=@userId
";
            SqlParameter[] para = {
                new SqlParameter("@userId", userId)
            };
            IDataReader dr = m_dao.ExecuteReader(sql, para);
            if (dr.Read())
            {
                ui.userId = (int)dr["userId"];
                ui.firstName = dr["firstName"].ToString();
                ui.middleName = dr["middleName"].ToString();
                ui.lastName = dr["lastName"].ToString();

                ui.address = dr["address"].ToString();
                ui.city = dr["city"].ToString();
                ui.state = dr["state"].ToString();
                ui.zip = dr["zip"].ToString();
                ui.country = dr["country"].ToString();
                ui.homephone = dr["homephone"].ToString();
                ui.cellphone = dr["cellphone"].ToString();
                ui.walkyphone = dr["walkyPhone"].ToString();

                ui.email = dr["email"].ToString();
                ui.mailList = dr["mailList"].ToString();
            }

            return ui;
        }

        public D_LoginUserInfo GetLoginUserInfo(int employeeID)
        {
               D_LoginUserInfo ui = new D_LoginUserInfo();
            string sql = @"
select firstName+'.'+lastName as username, loginName, userinfo.homePhone as tel
from employeeInfo
    left join userinfo on employeeInfo.userId=userinfo.userId
where 
    employeeInfo.employeeID=@employeeID
";
            SqlParameter[] para = {
                new SqlParameter("@employeeID", employeeID)
            };
            IDataReader dr = m_dao.ExecuteReader(sql, para);
            if (dr.Read())
            {
                ui.userId = employeeID;
                ui.username = (string)dr["username"];
                if (ui.username==".")  ui.username = (string)dr["loginName"];
                ui.tel = (string)dr["tel"];

                ActionAuthorization actBiz = new ActionAuthorization();
                ui.positionIds = actBiz.GetEmployeePositions(employeeID);
                ui.roleIds = actBiz.GetEmployeeRoles(employeeID);
            }
            return ui;
        }

    }
}
