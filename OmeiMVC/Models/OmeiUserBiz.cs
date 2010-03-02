using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using OmeiWebModel;

namespace OmeiMVC.Models
{
    public class OmeiUserBiz
    {
        public string ErrorMessage = null;
        public int ErrorCode = 0;

        #region GetUserInfo, UpdateUserInfo
        public UserInfo GetUserInfo(int userId)
        {
            OmeiTravelEntities db = new OmeiTravelEntities();
            UserInfo dt = (from d in db.UserInfoSet
                     where d.userId == userId
                     select d).FirstOrDefault();
            return dt;
        }

        public bool UpdateUserInfo(UserInfo userinfo)
        {
            return false;
        }
        #endregion

        #region UserLogin
        /// <summary>
        /// UserLogin
        /// </summary>
        /// <param name="email"></param>
        /// <param name="password"></param>
        /// <returns>userID, 0 for null email or password, -1 for email not exist, -2 for password incorrect.</returns>
        public int UserLogin(string email, string password)
        {
            if (email == null || password == null || email == string.Empty || password == string.Empty)
                return 0;

            OmeiTravelEntities db = new OmeiTravelEntities();
            UserInfo ui = (from d in db.UserInfoSet
                           where d.email == email
                           select d).FirstOrDefault();
            if (ui != null && ui.userId > 0)
            {
                if (ui.pin == password)
                    return ui.userId;
                else
                    return -2;
            }
            else
                return -1;

        }
        #endregion

        #region AddUser
        public bool AddUser(UserInfo userInfo)
        {
            ErrorCode = -1;
            if (!CheckUniqueEmail(userInfo.email))
            {
                ErrorMessage = "Email already exist.";
                return false;
            }

            userInfo.userId = 0;
            userInfo.userType = 0;
            userInfo.addDate = userInfo.updateDate = DateTime.Now;
            
            OmeiTravelEntities db = new OmeiTravelEntities();
            db.AddToUserInfoSet(userInfo);
            db.SaveChanges();
            ErrorCode = 0;
            return true;
        }

        public bool CheckUniqueEmail(string email)
        {
            OmeiTravelEntities db = new OmeiTravelEntities();
            UserInfo ui = (from d in db.UserInfoSet
                           where d.email == email
                           select d).FirstOrDefault();
            return ui == null;
        }

        private int AddNewUser(string email)
        {
            return 0;
        }

        private void AddLogin(int userId, string password)
        {
        }
        #endregion

        #region Password: Get, Change
        public string GetPassword(int userId)
        {
            return null;
        }

        public bool ChangePassword(int userId, string newPassword)
        {
            return false;
        }

        public bool ChangePassword(int userId, string oldPassword, string newPassword)
        {
            return false;
        }
        #endregion

    }
}
