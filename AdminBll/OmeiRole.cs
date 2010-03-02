using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;

namespace com.Omei.BLL.Admin
{
    public class OmeiRole : AdminBll
    {

        public void AddUserToRole(string username, string rolename)
        {}

        public void AddRole(string rolename)
        {}

        public bool DeleteRole(string rolename)
        {
            return false;
        }

        public string[] GetAllRoles()
        {
            return new string[] { "ISEMPLOYEE" };
        }

        public string[] GetRolesForUser(string username)
        {
            if (IsEmployee(username))
                return new string[] { "ISEMPLOYEE" };
            else
                return new string[0];
        }

        public string[] GetUsersInRole(string rolename)
        {
            if (rolename != "ISEMPLOYEE")
                return new string[0];

            StringBuilder sb = new StringBuilder();
            IDataReader rd;

            string sql = "select loginName from userLogin where userId in (select userId from employeeInfo where status>0)";
            rd = m_dao.ExecuteReader(sql, null);
            while (rd.Read())
            {
                sb.Append(rd[0].ToString());
                sb.Append(',');
            }

            if (sb.Length > 0)
            {
                sb.Remove(sb.Length - 1, 1);
                return sb.ToString().Split(',');
            }
            else
                return new string[0];
        }

        private bool IsEmployee(string username)
        {
            string sql = @"
select count(*) from employeeInfo
where userId=(
	select top 1 userId from userlogin where loginName=@username
) and status>0";

            SqlParameter[] para = {
                new SqlParameter("@username", username)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            return (o != null && (int)o == 1);
        }

        public bool IsUserInRole(string username, string rolename)
        {
            if (rolename == "ISEMPLOYEE")
                return IsEmployee(username);
            else
                return false;
        }

        public void RemoveUserFromRole(string username, string rolename)
        {
        }

        public bool RoleExists(string rolename)
        {
            return (rolename == "ISEMPLOYEE");
        }

        public string[] FindUsersInRole(string rolename, string userToMatch)
        {
            if (rolename != "ISEMPLOYEE")
                return new string[0];

            StringBuilder sb = new StringBuilder();
            string sql = "select loginName from userLogin where userId in (select userId from employeeInfo where status>0) and loginName like @userToMatch";
            SqlParameter[] para = {
                    new SqlParameter("@userToMatch", userToMatch)
                };
            IDataReader rd = m_dao.ExecuteReader(sql, para);
            while (rd.Read())
            {
                sb.Append(rd[0].ToString());
                sb.Append(',');
            }
            if (sb.Length > 0)
            {
                sb.Remove(sb.Length - 1, 1);
                return sb.ToString().Split(',');
            }
            else
                return new string[0];

        }

    }
}
