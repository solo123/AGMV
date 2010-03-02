using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.OmeiDataSet;

namespace com.Omei.BLL.Authenticate
{
    public class UserLoginBiz : OmeiBll
    {
        public int userId = -1;

        #region UserLogin
        public bool UserLogin(string email, string password)
        {
            bool b = false;
            string sql = @"
select userid 
from userLogin 
where userid=(
    select top 1 userid 
        from userInfo 
        where email=@email
    ) and password=@password";
            
            SqlParameter[] para = {
                new SqlParameter("@email", email),
                new SqlParameter("@password", password)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o != null)
            {
                userId = (int)o;
                b = true;
            }
            return b;
        }
        #endregion

        #region AddUser
        public bool AddUser(D_UserInfo userInfo, string password)
        {
            if (!CheckEmailNotDup(userInfo.email))
            {
                ErrorMessage = "該Email已經註冊，您可以點擊連接<a href=\"RecoverPassword.aspx\">\"忘記密碼?\"</a>從郵箱獲取新密碼。";
                return false;
            }

            userInfo.userId = AddNewUser();
            if (userInfo.userId <= 0)
            {
                ErrorMessage = "添加新用戶失敗，請檢查。";
                return false;
            }

            UpdateUserInfo(userInfo);
            AddLogin(userInfo.userId, password);
            return true;
        }

        private bool CheckEmailNotDup(string email)
        {
            string sql = "select count(*) from userInfo where email=@email";
            SqlParameter[] para = {
                new SqlParameter("@email", email)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            return ((int)o == 0);
        }

        private int AddNewUser()
        {
            string sql = @"
insert userInfo (firstname) values (''); 
select SCOPE_IDENTITY() as id;";

            int userId = Convert.ToInt32(m_dao.ExecuteScalar(sql,null));
            return userId;
        }
        private void AddLogin(int userId, string password)
        {
            string sql = "insert userlogin (userId, loginName, password) values (@userId, 'OMei_'+ ltrim(str(@userId)) , @password)";
            SqlParameter[] para = {
                new SqlParameter("@userId", userId),
                new SqlParameter("@password", password)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        #endregion

        #region Update, ChangePassword
        public void UpdateUserInfo(D_UserInfo userInfo)
        {
            string SQL_UPDATE_USERINFO = @"
update userInfo 
    set
        firstName=@firstName, middleName=@middleName, lastName=@lastName,
        address=@address, city=@city, state=@state, zip=@zip, country=@country,
        homephone=@homephone, cellphone=@cellphone,
        email=@email, mailList=@mailList
where userId=@userId
";
            if (userInfo.firstName == null || userInfo.firstName == "")
            {
                int p = userInfo.email.IndexOf('@');
                if (p > 0)
                    userInfo.firstName = userInfo.email.Substring(0, p);
            }
            SqlParameter[] para = {
                new SqlParameter("@userId", userInfo.userId),
                new SqlParameter("@firstName", userInfo.firstName),
                new SqlParameter("@middleName", userInfo.middleName),
                new SqlParameter("@lastName", userInfo.lastName),

                new SqlParameter("@address", userInfo.address),
                new SqlParameter("@city", userInfo.city),
                new SqlParameter("@zip", userInfo.zip),
                new SqlParameter("@state", userInfo.state),
                new SqlParameter("@country", userInfo.country),

                new SqlParameter("@homephone", userInfo.homepnone),
                new SqlParameter("@cellphone", userInfo.cellphone),

                new SqlParameter("@email", userInfo.email),
                new SqlParameter("@mailList", userInfo.mailList)
            };

            m_dao.ExecuteNoQuery(SQL_UPDATE_USERINFO, para);

        }
        public bool ChangePassword(int userId, string newPassword)
        {
            string sql = "update userlogin set password=@password where userId=@userId";
            SqlParameter[] para = {
                new SqlParameter("@userId", userId),
                new SqlParameter("@password", newPassword)
            };
            int r = m_dao.ExecuteNoQuery(sql, para);
            return (r == 1);
        }
        #endregion

        #region RecoverPassword
        public string RecoverPassword(string email)
        {
            UserBiz biz = new UserBiz();
            int userId = biz.GetUserIdByEmail(email);
            if (userId < 0)
            {
                base.ErrorMessage = "此Email帳戶沒有註冊，請到<a href=\"signup.aspx\">新用戶註冊頁免費註冊。</a>";
                return null;
            }

            string newPassword = RandomPassword.Generate(4);
            if (ChangePassword(userId, newPassword))
                return newPassword;
            else
                return null;
        }
        #endregion

        public DS_UserInfo GetUserInfo(int userId)
        {
            string SQL_READ_USERINFO = "select * from userInfo where userId=@userId";
            DS_UserInfo ds = new DS_UserInfo();
            SqlParameter[] para = {
                new SqlParameter("@userId", userId)
            };
            m_dao.FillDataSet(ds, "UserInfoTbl", SQL_READ_USERINFO, para);
            return ds;
        }

        

//-------------------
        private string GetUserRoleIds(int userId)
        {
            StringBuilder sb = new StringBuilder();
            string sql = "select roleId from userRole where userId=@userId";
            SqlParameter[] para = {
                new SqlParameter("@userId", userId)
            };
            IDataReader dr = m_dao.ExecuteReader(sql, para);
            while (dr.Read())
            {
                sb.Append('[');
                sb.Append(dr[0].ToString());
                sb.Append(']');
            }
            return sb.ToString();
        }

    }
}
