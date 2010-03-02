using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.BLL.Admin
{
    public class JimmySqlBiz : AdminBll
    {
        public int RunSqlText(string sql)
        {
            if (sql == "" || sql == null) 
                return 0;
            else
                return m_dao.ExecuteNoQuery(sql, null);
        }
    }
}
