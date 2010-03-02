using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.DLL;


namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class HotelBiz : AdminBll
    {
        #region GetHotelList
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Hotels.HotelsDataTable GetHotelList(int status)
        {
            string sql = @"
SELECT hotelID, hotelName, starRank, description, priceInfo, contactInfo, 
      status
FROM Hotels
";
            if (status > 0)
            {
                sql += " where status>0";
            }
            sql += " order by hotelName";

            DS_Hotels ds = new DS_Hotels();
            m_dao.FillDataSet(ds, "Hotels", sql, null);
            return ds.Hotels;
        }
        #endregion

        #region GetHotelDetail, update, insert, delete
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Hotels.HotelsDataTable GetHotelDetail(int hotelID)
        {
            if (hotelID <= 0) return null;

            string sql = @"
SELECT hotelID, hotelName, starRank, description, priceInfo, contactInfo, 
      status
FROM Hotels
WHERE hotelID=@hotelID";
            SqlParameter[] para = {
                new SqlParameter("@hotelID", hotelID)
            };
            DS_Hotels ds = new DS_Hotels();
            m_dao.FillDataSet(ds, "Hotels", sql, para);
            return ds.Hotels;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public bool UpdateHotel(
            int original_hotelID,
            string hotelName, decimal starRank, 
            string description, string priceInfo, string contactInfo, 
            int status)
        {
            string sql = @"
update hotels
set hotelName=@hotelName, starRank=@starRank, description=@description, priceInfo=@priceInfo,
    contactInfo=@contactInfo, status=@status
where hotelID=@hotelID";

            SqlParameter[] para = {
                new SqlParameter("@hotelName", hotelName),
                new SqlParameter("@starRank", starRank),
                new SqlParameter("@description", description),
                new SqlParameter("@priceInfo", priceInfo),
                new SqlParameter("@contactInfo", contactInfo),
                new SqlParameter("@status", status),
                new SqlParameter("@hotelID", original_hotelID)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, false)]
        public bool AddHotel(
            string hotelName, decimal starRank,
            string description, string priceInfo, string contactInfo,
            int status)
        {
            string sql = @"
insert hotels
(hotelName, starRank, description, priceInfo,contactInfo, status)
values
(@hotelName, @starRank, @description, @priceInfo, @contactInfo, @status)";

            SqlParameter[] para = {
                new SqlParameter("@hotelName", hotelName),
                new SqlParameter("@starRank", starRank),
                new SqlParameter("@description", description),
                new SqlParameter("@priceInfo", priceInfo),
                new SqlParameter("@contactInfo", contactInfo),
                new SqlParameter("@status", status)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Delete, false)]
        public void DeleteHotel(int original_hotelID)
        {
            if (original_hotelID <= 0) return;

            string sql = @"
delete hotels where hotelID=@hotelID";
            SqlParameter[] para = {
                new SqlParameter("@hotelID", original_hotelID)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        #endregion
    }
}
