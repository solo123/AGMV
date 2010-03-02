using System;
using System.Collections.Generic;
using System.Text;

using System.Data.SqlClient;

using com.Omei.OmeiDataSet;

namespace com.Omei.BLL.Admin
{
    public class EventLog : AdminBll
    {
        public void Log(string src, string sender, string errorString, int userId)
        {
            if (m_dao != null )
            {
                string sql = "insert OmeiLog.dbo.errorLog (src, sender, error, loginUser, errorDate) values (@src, @sender, @error, @userId, getdate());";
                SqlParameter[] para = {
                    new SqlParameter("@src", src),
                    new SqlParameter("@sender", sender),
                    new SqlParameter("@error", errorString),
                    new SqlParameter("@userId", userId)
                };
                m_dao.ExecuteNoQuery(sql, para);
            }
        }

        public static void OpLog(object loginUserInfo, string description, int opType, int relateID)
        {
            int employeeID = 0;
            if (loginUserInfo != null)
            {
                employeeID = ((D_LoginUserInfo)loginUserInfo).userId;
            }
            string sql = @"
insert OmeiLog.dbo.opLog
(employeeID, description, opType, relateID, opDate)
values
(@employeeID, @description, @opType,@relateID, getdate());
";
            SqlParameter[] para = {
                new SqlParameter("@employeeID", employeeID),
                new SqlParameter("@description", description),
                new SqlParameter("@opType", opType),
                new SqlParameter("@relateID", relateID),
            };
            m_dao.ExecuteNoQuery(sql, para);
        }

        public static string LogLink(string href, string text)
        {
            return "<a href='" + href + "' target='logWin'>" + text + "</a>";
        }
    }
}
