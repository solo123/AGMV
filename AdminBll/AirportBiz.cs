using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.DLL;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class AirportBiz : AdminBll
    {
        #region SearchAirport
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Flight.AirportCodeDataTable SearchAirport(string airport)
        {
            DS_Flight ds = new DS_Flight();
            StringBuilder sb = new StringBuilder();
            

            sb.Append("SELECT airportID, airportCode, [name], name_cn, country FROM AirportCode");
            if (airport != null && airport.Trim().Length > 0)
            {
                string s = SqlCleanString(airport);
                sb.Append(" WHERE [name] like '");
                sb.Append(s);
                sb.Append("' or name_cn like '");
                sb.Append(s);
                sb.Append("' or airportCode='");
                sb.Append(airport.Trim());
                sb.Append("'");
            }
            sb.Append(" order by airportCode");

            m_dao.FillDataSet(ds, "AirportCode", sb.ToString(), null);
            return ds.AirportCode;
        }
        #endregion

        #region EditAirport
        public bool UpdateAirportCode(int original_airportID, string airportCode, string name, string name_cn, string country)
        {
            string sql = @"
update airportCode
    set airportCode=@airportCode, [name]=@airportName, name_cn=@name_cn, country=@country
where airportID=@airportID";
            SqlParameter[] para = {
                new SqlParameter("@airportID", original_airportID),
                new SqlParameter("@airportCode", airportCode.ToUpper()),
                new SqlParameter("@airportName", name),
                new SqlParameter("@name_cn", name_cn),
                new SqlParameter("@country", country)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }

        public bool AddAirportCode(string airportCode, string name, string name_cn, string country)
        {
            string sql = @"
insert into airportCode
(airportCode, [name], name_cn, country)
values
(@airportCode, @airportName, @name_cn, @country)";
            SqlParameter[] para = {
                new SqlParameter("@airportCode", airportCode.ToUpper()),
                new SqlParameter("@airportName", name),
                new SqlParameter("@name_cn", name_cn),
                new SqlParameter("@country", country)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }

        public void DeleteAirportCode(int original_airportID)
        {
            string sql = "delete airportCode where airportID=@airportID";
            SqlParameter[] para = {
                new SqlParameter("@airportCode", original_airportID)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        #endregion

        #region Update
        public void Update(DS_Flight.AirportCodeDataTable airportTable)
        {
            if (airportTable != null && airportTable.Rows.Count > 0)
            {
                for (int i = 0; i < airportTable.Rows.Count; i++)
                {
                    DS_Flight.AirportCodeRow row = airportTable.Rows[i] as DS_Flight.AirportCodeRow;
                    if (row.RowState == DataRowState.Added)
                    {
                        AddAirportCode(row.airportCode, row.name, row.name_cn, row.country);
                    }
                    else if (row.RowState == DataRowState.Modified)
                        UpdateAirportCode(row.airportID, row.airportCode, row.name, row.name_cn, row.country);
                }
                
            }
        }
        #endregion

        #region ValidateAirportCode
        public bool ValidateAirportCode(string airportCode)
        {
            string sql = "select count(*) from AirportCode where airportCode=@airportCode";
            SqlParameter[] para = {
                new SqlParameter("@airportCode", airportCode)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            return (o != null && Convert.ToInt32(o) > 0);
        }
        #endregion



    }
}
