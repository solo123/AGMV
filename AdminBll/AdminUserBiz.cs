using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.OmeiDataSet;
using com.Omei.OmeiAdminData;
using com.Omei.DLL;
using com.Omei.DLL.DS_UserInfoTableAdapters;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class AdminUserBiz :AdminBll
    {
        #region GetUserInfo, EmployInfo
        public D_UserInfo GetUserInfo(int userId)
        {
            D_UserInfo ui = new D_UserInfo();
            if (userId < 0)
                return ui;

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
        public D_EmployeeInfo GetEmployInfo(int userId)
        {
            D_EmployeeInfo ui = new D_EmployeeInfo();
            if (userId < 0)
                return ui;

            string sql = @"
select * from employeeInfo 
where userId=@userId
";
            SqlParameter[] para = {
                new SqlParameter("@userId", userId)
            };
            IDataReader dr = m_dao.ExecuteReader(sql, para);
            if (dr.Read())
            {
                ui.userId = (int)dr["userId"];
                ui.employDate = (DateTime)dr["employDate"];
                ui.ssn = (string)dr["ssn"];
                ui.roles = (string)dr["roles"];
                ui.positions = (string)dr["position"];
                ui.birthday = (DateTime)dr["birthday"];
                ui.companyId = (int)dr["companyId"];
                ui.status = (byte)dr["status"];
            }

            return ui;
        }
        #endregion

        #region Get,Update,Insert, Delete UserInfo
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_UserInfo.userInfoDataTable GetUserDetail(int userID)
        {
            userInfoTableAdapter adp = new userInfoTableAdapter();
            return adp.GetUserInfo(userID);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public bool UpdateUserDetail(
            int original_userID,
            string firstName, string lastName, 
            string address, string city, string state, string zip, string country,
            string homephone, string cellphone, string walkyphone, 
            string email, byte status
            )
        {
            string SQL = @"
update userInfo 
    set
        firstName=@firstName, lastName=@lastName,
        address=@address, city=@city, state=@state, zip=@zip, country=@country,
        homePhone=@homePhone, cellPhone=@cellPhone, walkyPhone=@walkyPhone,
        email=@email, status=@status
where userId=@userId
";
            SqlParameter[] para = {
                new SqlParameter("@userId", original_userID),

                new SqlParameter("@firstName", firstName),
                new SqlParameter("@lastName", lastName),

                new SqlParameter("@address", address),
                new SqlParameter("@city", city),
                new SqlParameter("@state", state),
                new SqlParameter("@zip", zip),
                new SqlParameter("@country", country),

                new SqlParameter("@homePhone", homephone),
                new SqlParameter("@cellPhone", cellphone),
                new SqlParameter("@walkyPhone", walkyphone),
                new SqlParameter("@email", email),
                new SqlParameter("@status", status)
            };
            int i = m_dao.ExecuteNoQuery(SQL, para);
            return (i==1);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, true)]
        public int InsertUserDetail(
            string firstName, string lastName,
            string address, string city, string state, string zip, string country,
            string homephone, string cellphone, string walkyphone,
            string email, byte status
            )
        {
            string sql = @"
insert userInfo 
(firstName, lastName, address, city, state, zip, country, homephone, cellphone, walkyphone, email, status)
values
(@firstName, @lastName, @address, @city, @state, @zip, @country, @homephone, @cellphone, @walkyphone, @email, @status);
select SCOPE_IDENTITY();";
            SqlParameter[] para = {
                new SqlParameter("@firstName", firstName),
                new SqlParameter("@lastName", lastName),

                new SqlParameter("@address", address),
                new SqlParameter("@city", city),
                new SqlParameter("@state", state),
                new SqlParameter("@zip", zip),
                new SqlParameter("@country", country),

                new SqlParameter("@homephone", homephone),
                new SqlParameter("@cellphone", cellphone),
                new SqlParameter("@walkyphone", walkyphone),
                new SqlParameter("@email", email),
                new SqlParameter("@status", status)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null)
                return 0;
            else
                return Convert.ToInt32(o);
        }

        public int SetUserStatus(string userIDs, int status)
        {
            if (userIDs == null || userIDs == string.Empty)
                return 0;

            string sql = "update userInfo set status=@status where userID in ("+ userIDs +") and status<>@status";
            SqlParameter[] para = {
                new SqlParameter("@status", status)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return i;
        }
        #endregion

        #region Add & update & Delete User
        public int Add(string loginname, string password)
        {
            string sql = @"
insert userInfo
(firstname)
values
(@firstname);
select SCOPE_IDENTITY() as id;
";
            SqlParameter[] para = {
                new SqlParameter("@firstname", loginname)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            int id = Convert.ToInt32(o);

            if (id > 0)
            {
                // add login info
                sql = @"
insert into userLogin 
    (userId, loginName, password) 
values 
    (@userId, @loginName, @password);";
                SqlParameter[] para1 = {
                    new SqlParameter("@userId", id),
                    new SqlParameter("@loginName", loginname),
                    new SqlParameter("@password", password)
                };
                m_dao.ExecuteNoQuery(sql, para1);

                // add employee info
                sql = "insert into employeeInfo (userId, ssn, companyId, status) values ("+ id.ToString() +", '', 0, 0)";
                m_dao.ExecuteNoQuery(sql, null);
            }
            return id;
        }

        public void Delete(int userId)
        {
            string SQL = @"
delete userInfo where userId=@userId;
delete userLogin where userId=@userId;";
            SqlParameter[] para = {
                new SqlParameter("@userId", userId)
            };
            m_dao.ExecuteNoQuery(SQL, para);
        }

        #endregion

        #region GetUserIdByName, ChangeLoginName
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
        
        #endregion

        #region SearchUser
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_UserInfo.UserListDataTable SearchUser(string searchText)
        {
            string sql = @"
SELECT userId, firstName, lastName, address, city, state, zip, country, homePhone, cellPhone, walkyPhone, email, status
FROM userInfo ";
            string qry = GetQueryString(searchText);
            if (qry != null)
            {
                string cnd = " WHERE (firstName like @searchStr or lastName like @searchStr or email like @searchStr) or " +
                    "( homePhone like @searchTel or cellPhone like @searchTel or walkyPhone like @searchTel  )";
                sql += cnd;
            }

            string tel = GetQueryString(GetCleanNumbers(searchText));
            if (qry == null) qry = string.Empty;
            if (tel == null) tel = string.Empty;
            SqlParameter[] para = {
                    new SqlParameter("@searchStr", qry),
                    new SqlParameter("@searchTel", tel),
                };
            DS_UserInfo ds = new DS_UserInfo();
            m_dao.FillDataSet(ds, "UserList", sql, para);
            return ds.UserList;

        }

        #region 清理非数字字符串
        private string GetCleanNumbers(string str)
        {
            if (str == null || str.Length == 0) return null;

            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < str.Length; i++)
            {
                if (str[i] >= '0' && str[i] <= '9')
                    sb.Append(str[i]);
            }
            return sb.ToString();
        }
        #endregion

        private string GetQueryString(string qryString)
        {
            if (qryString == null || qryString.Trim().Length == 0)
                return null;
            else
            {
                string s = qryString.Trim();
                if (s.IndexOf('*') >= 0 || s.IndexOf('?') >= 0)
                {
                    s = s.Replace('*', '%');
                    s = s.Replace('?', '_');
                    if (!s.EndsWith("%"))
                        s += "%";

                    return s;
                }
                else
                {
                    return s + "%";
                }
            }
        }
        #endregion

    }
}
