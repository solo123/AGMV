using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.DLL;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class OpLogBiz : AdminBll
    {
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
        public DS_Log.OpLogDataTable Query(int employeeID, int opType, DateTime startDate, DateTime endDate, string description)
        {
            string sql = @"
SELECT l.logID, l.employeeID, e.nickname as employeeName, l.description, l.opType, l.opDate, l.relateID
FROM OmeiLog.dbo.OpLog as l
    left join employeeInfo as e on l.employeeID=e.employeeID
";
            StringBuilder sb = new StringBuilder();
            if (employeeID > 0)
                sb.Append(" l.employeeID=" + employeeID.ToString() + " and ");

            if (opType > 0)
                sb.Append(" l.opType=" + opType.ToString() + " and ");

            if (startDate > new DateTime(1900,1,1))
                sb.Append(" l.opDate>='" + startDate.ToShortDateString() + "' and ");

            if (endDate > new DateTime(1900,1,1))
                sb.Append(" l.opDate<='" + endDate.AddDays(1).ToShortDateString() + "' and ");

            if (description != null && description.Length > 0)
                sb.Append(" l.description like '%"+ description +"%' and ");

            if (sb.Length > 5)
            {
                sb.Insert(0, " WHERE ");
                sb.Remove(sb.Length - 5, 5);
            }

            sb.Append(" ORDER BY l.logID desc");

            DS_Log ds = new DS_Log();
            m_dao.FillDataSet(ds, "OpLog", sql + sb.ToString(), null);
            return ds.OpLog;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Log.OpLogDataTable GetRelateLog(int opType, int relateID)
        {
            string sql = @"
SELECT l.logID, l.employeeID, e.nickname as employeeName, l.description, l.opType, l.opDate, l.relateID
FROM OmeiLog.dbo.OpLog as l
    left join employeeInfo as e on l.employeeID=e.employeeID
WHERE l.opType=@opType and l.relateID=@relateID
ORDER by l.logID desc;";

            SqlParameter[] para = {
                new SqlParameter("@opType", opType),
                new SqlParameter("@relateID", relateID),
            };
            DS_Log ds = new DS_Log();
            m_dao.FillDataSet(ds, "OpLog", sql, para);
            return ds.OpLog;
        }

    }
}
