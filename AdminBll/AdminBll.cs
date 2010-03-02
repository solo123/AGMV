using System;
using System.Collections.Generic;
using System.Text;

using com.jimmy.DLL;

namespace com.Omei.BLL.Admin
{
    public class AdminBll
    {
        protected static DAO m_dao = new DAO();

        // 0-ÖÐÎÄ£¬ 1-Ó¢ÎÄ
        protected static int m_languageId = 0;

        public string ErrorMessage;

        protected string SqlCleanString(string str)
        {
            if (str == null || str.Trim() == string.Empty) return string.Empty;

            string s = str.Trim().Replace("%", "%%");
            s = s.Replace("'", "''");
            s = s.Replace("*", "%");

            if (s[0] != '%') s = "%" + s;
            if (s[s.Length - 1] != '%') s = s + "%";
            return s;
        }
    }
}
