using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.DLL;
using com.Omei.DLL.DS_DestinationsTableAdapters;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class AdminDestinationBiz : AdminBll
    {

        #region GetDestinationName By ID
        public string GetDestinationName(int destId)
        {
            string sql = "SELECT destinationName, destinationName_cn FROM destination WHERE destinationId=@destinationId";
            SqlParameter[] para = {
                new SqlParameter("@destinationId", destId)
            };
            IDataReader dr = m_dao.ExecuteReader(sql, para);
            string n = "";
            if (dr.Read())
            {
                n = dr[0].ToString() + " / " + dr[1].ToString();
            }
            return n;
        }
        #endregion

        #region Select, Update, Insert
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
        public DS_Destinations.DestDetailDataTable GetDestinationDetail(int destinationID)
        {
            DestDetailTableAdapter adp = new DestDetailTableAdapter();
            return adp.GetDestinationDetail(destinationID);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, true)]
        public bool UpdateDestination(
            object loginUserInfo,
            int original_DestinationId,
            string DestinationName, 
            string DestinationName_cn,
            string city,
            string state,
            string country,
            string Description,
            string Description_cn,
            int status)
        {
            string sql = @"
UPDATE Destination
SET DestinationName = @DestinationName, 
      DestinationName_cn = @DestinationName_cn, city = @city, state = @state, 
      country = @country, Description = @Description, Description_cn = @Description_cn, 
      status = @status
WHERE (DestinationID = @original_DestinationId)";
            SqlParameter[] para = {
                new SqlParameter("@original_DestinationId", original_DestinationId),
                new SqlParameter("@DestinationName", DestinationName), 
                new SqlParameter("@DestinationName_cn", DestinationName_cn),
                new SqlParameter("@city", city),
                new SqlParameter("@state", state),
                new SqlParameter("@country", country),
                new SqlParameter("@Description", Description),
                new SqlParameter("@Description_cn", Description_cn),
                new SqlParameter("@status", status)
            };
            int r = m_dao.ExecuteNoQuery(sql, para);

            EventLog.OpLog(loginUserInfo, "Updated destination:" + DestinationName, 5, original_DestinationId);
            return (r == 1);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, true)]
        public int AddDestination(
            object loginUserInfo,
            string DestinationName,
            string DestinationName_cn,
            string city,
            string state,
            string country,
            string Description,
            string Description_cn,
            int status )
        {
            string sql = @"
INSERT INTO Destination
(DestinationName, DestinationName_cn, city, state, country, 
      Description, Description_cn, status)
values
(@DestinationName, @DestinationName_cn, @city, @state, @country, 
      @Description, @Description_cn, @status);

select SCOPE_IDENTITY();";
            SqlParameter[] para = {
                new SqlParameter("@DestinationName", DestinationName), 
                new SqlParameter("@DestinationName_cn", DestinationName_cn),
                new SqlParameter("@city", city),
                new SqlParameter("@state", state),
                new SqlParameter("@country", country),
                new SqlParameter("@Description", Description),
                new SqlParameter("@Description_cn", Description_cn),
                new SqlParameter("@status", status)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null)
                return 0;
            else
            {
                int d = Convert.ToInt32(o);
                EventLog.OpLog(loginUserInfo, "New Destination:" + DestinationName, 5, d);
                return d;
            }
        }
        #endregion


    }
}
