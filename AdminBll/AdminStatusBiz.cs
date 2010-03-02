using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;

namespace com.Omei.BLL.Admin
{
    public class AdminStatusBiz : AdminBll
    {
        public string GetStatusTitle(string status, string statusClass)
        {
            string sql = "select listTitle from typeRef where listClass=@listClass and listValue=@listValue";
            SqlParameter[] para = {
                new SqlParameter("@listClass", statusClass),
                new SqlParameter("@listValue", status)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o != null)
                return o.ToString();
            else
                return "&lt;Undifined:("+ status +")&gt;";
        }
    }
}
