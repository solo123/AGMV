using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.DLL;


namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class AirlineBiz : AdminBll
    {
        #region SearchAirport
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Airline.AirlineCodeDataTable SearchAirline(string airline)
        {
            DS_Airline ds = new DS_Airline();
            StringBuilder sb = new StringBuilder();


            sb.Append("SELECT airlineID, airlineCode, [name], name_cn FROM AirlineCode");
            string al = SqlCleanString(airline);
            if (al != null && al.Length > 0)
            {
                sb.Append(" WHERE [name] like '");
                sb.Append(al);
                sb.Append("' or name_cn like '");
                sb.Append(al);
                sb.Append("' or airlineCode='");
                sb.Append(airline.Trim());
                sb.Append("'");
            }
            sb.Append(" order by airlineCode");

            m_dao.FillDataSet(ds, "AirlineCode", sb.ToString(), null);
            return ds.AirlineCode;
        }
        
        #endregion

        #region Update
        public bool UpdateAirlineCode(int airlineID, string airlineCode, string name, string name_cn)
        {
            string sql = @"
update airlineCode
    set airlineCode=@airlineCode, [name]=@name, name_cn=@name_cn
where airlineID=@airlineID";
            SqlParameter[] para = {
                new SqlParameter("@airlineID", airlineID),
                new SqlParameter("@airlineCode", airlineCode.ToUpper()),
                new SqlParameter("@name", name),
                new SqlParameter("@name_cn", name_cn)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }

        public bool AddAirlineCode(string airlineCode, string name, string name_cn)
        {
            string sql = @"
insert into airlineCode
(airlineCode, [name], name_cn)
values
(@airlineCode, @name, @name_cn)";
            SqlParameter[] para = {
                new SqlParameter("@airlineCode", airlineCode.ToUpper()),
                new SqlParameter("@name", name),
                new SqlParameter("@name_cn", name_cn)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }

        public void DeleteAirlineCode(int airlineID)
        {
            string sql = "delete airlineCode where airlineID=@airlineID";
            SqlParameter[] para = {
                new SqlParameter("@airportCode", airlineID)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }

        public void Update(DS_Airline.AirlineCodeDataTable airlineTable)
        {
            if (airlineTable != null && airlineTable.Rows.Count > 0)
            {
                for (int i = 0; i < airlineTable.Rows.Count; i++)
                {
                    DS_Airline.AirlineCodeRow row = airlineTable.Rows[i] as DS_Airline.AirlineCodeRow;
                    if (row.RowState == DataRowState.Added)
                    {
                        AddAirlineCode(row.airlineCode, row.name, row.name_cn);
                    }
                    else if (row.RowState == DataRowState.Modified)
                        UpdateAirlineCode(row.airlineID, row.airlineCode, row.name, row.name_cn);
                }

            }
        }

        #endregion

        #region ValidateAirlineCode
        public bool ValidateAirlineCode(string airlineCode)
        {
            string sql = "select count(*) from AirlineCode where airlineCode=@airlineCode";
            SqlParameter[] para = {
                new SqlParameter("@airlineCode", airlineCode)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            return (o != null && Convert.ToInt32(o) > 0);
        }
        #endregion

    }
}
