using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.DLL;
using com.Omei.OmeiDataSet;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class CommissionBiz : AdminBll
    {
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Commission.commissionDataTable GetCommissionConfig()
        {
            string sql = @"
select omeiConfig.*, employeeInfo.nickname 
from omeiConfig 
left join employeeinfo on omeiConfig.employeeID=employeeInfo.employeeID 
where configName='commissionRate'
order by omeiConfig.configValue
";
            DS_Commission.commissionDataTable dt = new DS_Commission.commissionDataTable();
            IDataReader dr = m_dao.ExecuteReader(sql, null);
            while (dr.Read())
            {
                DS_Commission.commissionRow row = dt.NewcommissionRow();
                row.id = (int)dr["id"];
                if (!(dr["createDate"] is DBNull)) row.createDate = (DateTime)dr["createDate"];
                if (!(dr["lastUpdate"] is DBNull)) row.lastUpdate = (DateTime)dr["lastUpdate"];
                row.employeeID = (int)dr["employeeID"];
                row.description = (string)dr["description"];
                if (!(dr["nickname"] is DBNull)) row.employee = (string)dr["nickname"];
                string v = (string)dr["configValue"];
                if (v.Length > 3)
                {
                    string[] vs = v.Split(',');
                    if (vs != null && vs.Length>2)
                    {
                        row.amountFrom = Convert.ToInt32(vs[0]);
                        row.amountTo = Convert.ToInt32(vs[1]);
                        row.commissionRate = Convert.ToDecimal(vs[2]);
                    }
                }
                dt.AddcommissionRow(row);
            }
            return dt;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public void UpdateCommission(
            int original_id, decimal amountFrom, decimal amountTo, decimal commissionRate, string description, D_LoginUserInfo ui)
        {
            string sql = @"
update omeiConfig
set configValue=@configValue, description=@description,
    lastUpdate=getdate(), employeeID=@employeeID
where id=@id
";
            if (description == null) description = "";
            string configValue = amountFrom.ToString() + "," + amountTo.ToString() + "," + commissionRate.ToString();
            SqlParameter[] para = {
                new SqlParameter("@id", original_id),
                new SqlParameter("@configValue", configValue),
                new SqlParameter("@description", description),
                new SqlParameter("@employeeID", ui.userId),
            };
            m_dao.ExecuteNoQuery(sql, para);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, false)]
        public void AddNewCommission(D_LoginUserInfo ui)
        {
            string sql = "insert into omeiConfig (configName,createDate, lastUpdate, employeeID) values ('commissionRate',getdate(), getdate(), @employeeID)";
            SqlParameter[] para = {
                new SqlParameter("@employeeID", ui.userId),
            };
            m_dao.ExecuteNoQuery(sql, para);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Delete, false)]
        public void DeleteCommission(int original_id)
        {
            string sql = "delete omeiConfig where id=@id";
            SqlParameter[] para = { new SqlParameter("@id", original_id), };
            m_dao.ExecuteNoQuery(sql, para);
        }



    }
}
