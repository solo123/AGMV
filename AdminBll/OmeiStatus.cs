using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using com.Omei.DLL;
using com.Omei.DLL.DS_TypeRefTableAdapters;

namespace com.Omei.BLL.Admin
{
    public class OmeiStatus : AdminBll
    {
        private DS_TypeRef _dsStatus;

        public OmeiStatus()
        {
            _dsStatus = new DS_TypeRef();
            ReLoad();
        }

        public void ReLoad()
        {
            OmeiStatusTableAdapter adp = new OmeiStatusTableAdapter();
            adp.Fill(_dsStatus.OmeiStatus);
        }

        public string GetPrompt(string typeName, string typeValue, string lang)
        {
            if (_dsStatus == null || _dsStatus.OmeiStatus.Count < 1)
                return null;

            DataRow[] rows = _dsStatus.OmeiStatus.Select("listClass='" + typeName + "' and listValue='" + typeValue + "'");
            if (rows.Length > 0)
            {
                StringBuilder sb = new StringBuilder();
                string s = rows[0]["listStyle"].ToString();
                if (s != null)
                {
                    string[] ss = s.Split(',');
                    if (ss.Length > 0) sb.Append("color:" + ss[0] +";");
                    if (ss.Length > 1) sb.Append("font-size:" + ss[1] +";");
                    if (ss.Length > 2)
                    {
                        string st = ss[2];
                        if (st.IndexOf('B') >= 0) sb.Append("font-weight:bold;");
                        if (st.IndexOf('I') >= 0) sb.Append("font-style:italic;");
                        if (st.IndexOf('U') >= 0) sb.Append("decoration:underline;");
                    }
                }
                if (sb.Length > 0)
                {
                    sb.Insert(0, "<span style='");
                    sb.Append("'>");
                    if (lang == "cn")
                        sb.Append(rows[0]["listTitle_cn"]);
                    else
                        sb.Append(rows[0]["listTitle"]);
                    sb.Append("</span>");
                    return sb.ToString();
                }
                else
                {
                    if (lang == "cn")
                        return rows[0]["listTitle_cn"].ToString();
                    else
                        return rows[0]["listTitle"].ToString();
                }
            }
            else
                return null;
        }

        public string GetBackColor(string typeName, string typeValue)
        {
            if (_dsStatus == null || _dsStatus.OmeiStatus.Count < 1)
                return null;

            DataRow[] rows = _dsStatus.OmeiStatus.Select("listClass='" + typeName + "' and listValue='" + typeValue + "'");
            if (rows.Length > 0)
            {
                if (rows[0]["listBack"] is DBNull || "" == rows[0]["listBack"].ToString())
                    return null;
                else
                    return rows[0]["listBack"].ToString();
            }
            else
                return null;
        }
    }
}
