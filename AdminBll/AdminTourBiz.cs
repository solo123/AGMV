using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.OmeiDataSet;
using com.Omei.OmeiAdminData;

using com.Omei.DLL;
using com.Omei.DLL.DS_ToursTableAdapters;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class AdminTourBiz : AdminBll
    {
        private const string SQL_TOUR_LIST = @"
SELECT 
    tourId as id, 
    tourName as title,
    tourName_cn as title_cn,
    tourType,
    status 
FROM tours";

        #region GetTourInfo, GetTourName
        public D_TourInfo GetTourInfo(int tourId)
        {
            string SQL = "SELECT * FROM tours WHERE tourId=@tourId";
            SqlParameter[] para = { new SqlParameter("@tourId", tourId) };
            IDataReader dr = m_dao.ExecuteReader(SQL, para);
            D_TourInfo di = new D_TourInfo();
            if (dr.Read())
            {
                di.tourId = (int)dr["tourId"];
                di.tourOrder = (int)dr["tourOrder"];
                di.tourName = (string)dr["tourName"];
                di.tourName_cn = (string)dr["tourName_cn"];
                di.tourDay = (byte)dr["tourDay"];
                di.tourNight = di.tourDay > 1 ? di.tourDay - 1 : 0;
                di.description = (string)dr["description"];
                di.description_cn = (string)dr["description_cn"];
                di.tourType = (byte)dr["tourType"];

                di.priceAdult = (decimal)dr["priceAdult"];
                di.priceChild = (decimal)dr["priceChild"];
                di.status = (byte)dr["status"];
            }
            return di;
        }
        public string GetTourName(int tourId)
        {
            string sql = "select tourName_cn as tourName from tours where tourId=@tourId";
            SqlParameter[] para = {
                new SqlParameter("@tourId", tourId)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o != null)
                return Convert.ToString(o);
            else
                return "";
        }
        #endregion

        #region Add & update & DeleteTour
        public int AddTour()
        {
            string SQL = @"
insert tours
(status)
values
(0);
select SCOPE_IDENTITY() as id;
";
            object o = m_dao.ExecuteScalar(SQL, null);
            int id = Convert.ToInt32(o);
            return id;
        }

        public void DeleteTour(int tourId)
        {
            string SQL = "delete tours where tourId=@tourId";
            SqlParameter[] para = {
                new SqlParameter("@tourId", tourId)
            };
            m_dao.ExecuteNoQuery(SQL, para);
        }

        public bool UpdateTourInfo(D_TourInfo tourInfo)
        {
            string sql = @"
update tours
set
    tourName=@tourName,
    tourName_cn=@tourName_cn,
    description=@description,
    description_cn=@description_cn,
    tourDay=@tourDay,
    tourType=@tourType,
    tourOrder=@tourOrder,
    status=@status
where tourId=@tourId
";
            SqlParameter[] para = {
                new SqlParameter("@tourId", tourInfo.tourId),
                new SqlParameter("@tourName", tourInfo.tourName),
                new SqlParameter("@tourName_cn", tourInfo.tourName_cn),
                new SqlParameter("@description", tourInfo.description),
                new SqlParameter("@description_cn", tourInfo.description_cn),
                new SqlParameter("@tourDay", tourInfo.tourDay),
                new SqlParameter("@tourType", tourInfo.tourType),
                new SqlParameter("@tourOrder", tourInfo.tourOrder),
                new SqlParameter("@status", tourInfo.status)
            };
            m_dao.ExecuteNoQuery(sql, para);
            return true;
        }

        #endregion

        #region GetWeekly, SaveWeekly
        /// <summary>
        /// 格式:第1個字符為Y/N=是否自動齣團，其后為0～7位數字，錶示週一至週日齣團
        /// </summary>
        /// <param name="tourId"></param>
        /// <returns></returns>
        public string GetWeekly(int tourId)
        {
            string SQL = "select autoGenSchedule, weekly from tours where tourId=@tourId";

            SqlParameter[] para = {
                new SqlParameter("@tourId", tourId)
            };
            DataSet ds = m_dao.ExecuteDataSet(SQL, para);
            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                string pre, weekly;
                DataRow row = ds.Tables[0].Rows[0];
                pre = ( (byte)row["autoGenSchedule"] == 1 ? "Y" : "N" );
                weekly = row["weekly"].ToString();
                return pre + weekly;
            }
            else
            {
                return "N";
            }
        }

        public void SetWeekly(int tourId, string weekly)
        {
            string SQL = "update tours set autoGenSchedule=@autoGenSchedule, weekly=@weekly where tourId=@tourId";
            SqlParameter[] para = {
                new SqlParameter("@tourId", tourId),
                new SqlParameter("@autoGenSchedule", weekly[0]=='Y' ? 1 : 0 ),
                new SqlParameter("@weekly", weekly.Substring(1))
            };
            m_dao.ExecuteNoQuery(SQL, para);
        }

        #endregion

        #region TourDestination
        
        #region GetTourDays
        public int GetTourDays(int tourId)
        {
            string SQL = "select tourDay from tours where tourId=@tourId";
            SqlParameter[] para = {
                new SqlParameter("@tourId", tourId)
            };
            object o = m_dao.ExecuteScalar(SQL, para);
            int days = 0;
            if (o != null)
                days = (byte)o;

            return days;
        }

        #endregion

        #region AddTourDest
        public void AddTourDest(int tourId)
        {
            string sql = "insert into tourDestinations (tourId) values (@tourId)";
            SqlParameter[] para = {
                new SqlParameter("@tourId", tourId)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        #endregion

        #endregion

        #region GetTourList, UpdateTourPrice
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetTourList(int tourType, bool showOnWeb)
        {
            string sql = @"
SELECT TourID, TourName, TourName_cn, TourDay, priceAdult, priceChild, 
      weekly,tourType,status
FROM tours
";
            StringBuilder cnd = new StringBuilder();
            if (tourType > 0)
            {
                cnd.Append("tourType=");
                cnd.Append(tourType);
                cnd.Append(" and ");
            }
            if (showOnWeb)
                cnd.Append(" status>0 and ");
            else
                cnd.Append(" status=0 and ");

            if (cnd.Length > 5)
            {
                cnd.Remove(cnd.Length - 5, 5);
                cnd.Insert(0, " WHERE ");
            }
            cnd.Insert(0, sql);
            cnd.Append(" ORDER BY TourDay, tourOrder");

            return m_dao.ExecuteDataSet(cnd.ToString() , null);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public bool UpdateTourPrice(int original_tourID, decimal priceAdult, decimal priceChild)
        {
            string sql = @"update tours set priceAdult=@priceAdult, priceChild=@priceChild where tourID=@tourID";
            SqlParameter[] para = {
                new SqlParameter("@tourID", original_tourID),
                new SqlParameter("@priceAdult", priceAdult),
                new SqlParameter("@priceChild", priceChild)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }
        #endregion

        #region TourNameList
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetTourNameList(int tourType)
        {
            string sql = @"select tourID, tourName, tourName_cn from tours where tourType=@tourType and status>0";
            SqlParameter[] para = {
                new SqlParameter("@tourType", tourType)
            };
            DataSet ds = m_dao.ExecuteDataSet(sql, para);
            return ds;
        }
        #endregion

        // ------------------------------

        #region Select, Update, Insert, Delete TourDetail
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Tours.tourDetailDataTable GetTourDetail(int tourID)
        {
            string sql = @"
SELECT TourID, TourName, TourName_cn, tourOrder, TourDay, Description, 
      Description_cn, TourType, status, hasSeatTable, isFloatPrice
FROM tours
WHERE (TourID = @tourId)";
            SqlParameter[] para = {
                new SqlParameter("@tourID", tourID),
            };
            DS_Tours ds = new DS_Tours();
            m_dao.FillDataSet(ds, "tourDetail", sql, para);
            return ds.tourDetail;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public bool UpdateTourDetail(
            string tourName, string tourName_cn, int tourOrder, byte tourDay, 
            string description, string description_cn, byte tourType, byte status,
            bool hasSeatTable, bool isFloatPrice,
            int original_tourID)
        {
            string sql = @"
update tours
    set tourName=@tourName, tourName_cn=@tourName_cn, tourOrder=@tourOrder, tourDay=@tourDay,
        description=@description, description_cn=@description_cn, tourType=@tourType, status=@status,
        hasSeatTable=@hasSeatTable, isFloatPrice=@isFloatPrice
where tourID=@tourID
";
            SqlParameter[] para = {
                new SqlParameter("@tourName", tourName),
                new SqlParameter("@tourName_cn", tourName_cn),
                new SqlParameter("@tourOrder", tourOrder),
                new SqlParameter("@tourDay", tourDay),
                new SqlParameter("@description", description),
                new SqlParameter("@description_cn", description_cn),
                new SqlParameter("@tourType", tourType),
                new SqlParameter("@status", status),
                new SqlParameter("@hasSeatTable", hasSeatTable),
                new SqlParameter("@isFloatPrice", isFloatPrice),
                new SqlParameter("@tourID", original_tourID)
            };

            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, false)]
        public int InsertTour(
            string tourName, string tourName_cn, int tourOrder, byte tourDay, 
            string description, string description_cn, byte tourType, byte status, bool hasSeatTable, bool isFloatPrice)
        {
            string sql = @"
insert into tours
(tourName, tourName_cn, tourOrder, tourDay, description,description_cn, tourType, hasSeatTable, isFloatPrice, status)
values
(@tourName, @tourName_cn, @tourOrder, @tourDay, @description, @description_cn, @tourType, @hasSeatTable, @isFloatPrice, @status);
select SCOPE_IDENTITY();
";
            SqlParameter[] para = {
                new SqlParameter("@tourName", tourName),
                new SqlParameter("@tourName_cn", tourName_cn),
                new SqlParameter("@tourOrder", tourOrder),
                new SqlParameter("@tourDay", tourDay),
                new SqlParameter("@description", description),
                new SqlParameter("@description_cn", description_cn),
                new SqlParameter("@tourType", tourType),
                new SqlParameter("@hasSeatTable", hasSeatTable),
                new SqlParameter("@isFloatPrice", isFloatPrice),
                new SqlParameter("@status", status)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            int id = Convert.ToInt32(o);
            return id;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Delete, false)]
        public bool DelTour(int original_tourID)
        {
            string sql = @"
update tours set status=0
where tourID=@tourID";
            SqlParameter[] para = {
                new SqlParameter("@tourID", original_tourID)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }

        #endregion



    }
}
