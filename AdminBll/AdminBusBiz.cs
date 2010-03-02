using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.OmeiDataSet;
using com.Omei.OmeiAdminData;
using com.Omei.DLL;

namespace com.Omei.BLL.Admin
{
    public class AdminBusBiz : AdminBll
    {
        

        #region GetVehicleDetail
        public D_BusInfo GetVehicleDetail(int vehicleId)
        {
            string SQL = "SELECT * FROM vehicles WHERE vehicleId=@vehicleId";
            SqlParameter[] para = { new SqlParameter("@vehicleId", vehicleId) };
            IDataReader dr = m_dao.ExecuteReader(SQL, para);
            D_BusInfo bi = new D_BusInfo();
            if (dr.Read())
            {
                bi.vehicleId = (int)dr["vehicleId"];
                bi.vehicleName = (string)dr["vehicleName"];
                bi.vehicleType = (byte)dr["vehicleType"];
                bi.customerSeatNum = (int)dr["customerSeatNum"];
                bi.plateNumber = (string)dr["plateNumber"];
                bi.vinNumber = (string)dr["vinNumber"];
                bi.inspectionDate = (DateTime)dr["inspectionDate"];
                bi.status = (byte)dr["status"];
                bi.notes = (string)dr["notes"];
                bi.own = (byte)dr["own"];
            }
            return bi;
        }
        #endregion

        #region Add & update & Delete
        public bool Update(D_BusInfo businfo)
        {
            string sql = @"
update vehicles 
    set
        vehicleName=@vehicleName, vehicleType=@vehicleType,
        customerSeatNum=@customerSeatNum, plateNumber=@plateNumber, vinNumber=@vinNumber,
        inspectionDate=@inspectionDate, notes=@notes,
        status=@status, own=@own
where vehicleId=@vehicleId
";
            SqlParameter[] para = {
                new SqlParameter("@vehicleId", businfo.vehicleId),
                new SqlParameter("@vehicleName", businfo.vehicleName),
                new SqlParameter("@vehicleType", businfo.vehicleType),
                new SqlParameter("@customerSeatNum", businfo.customerSeatNum),
                new SqlParameter("@plateNumber", businfo.plateNumber),
                new SqlParameter("@vinNumber", businfo.vinNumber),
                new SqlParameter("@inspectionDate", businfo.inspectionDate),
                new SqlParameter("@status", businfo.status),
                new SqlParameter("@notes", businfo.notes),
                new SqlParameter("@own", businfo.own)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i==1);
        }

        public int Add()
        {
            string SQL = @"
insert vehicles
(status, own)
values
(0,1);
select SCOPE_IDENTITY() as id;
";
            object o = m_dao.ExecuteScalar(SQL, null);
            int id = Convert.ToInt32(o);
            return id;
        }

        public void Delete(int vehicleId)
        {
            string SQL = @"
delete vehicles where vehicleId=@vehicleId
";
            SqlParameter[] para = {
                new SqlParameter("@vehicleId", vehicleId)
            };
            m_dao.ExecuteNoQuery(SQL, para);
        }

        #endregion

        #region GetBusUsageList
        public DS_BusUsage GetBusUsageList(int vehicleId)
        {
            string sql = @"
select *
from vehicleUsage
where vehicleId=@vehicleId
order by startDate;
";
            SqlParameter[] para = {
                new SqlParameter("@vehicleId", vehicleId)
            };
            DS_BusUsage ds = new DS_BusUsage();
            m_dao.FillDataSet(ds, "BusUsageTbl", sql, para);
            return ds;
        }
        #endregion


        #region AddBusUsage, DelBusUsage
        public void AddBusUsage(int vehicleId, DateTime startDate, DateTime endDate)
        {
            string sql = @"
insert into vehicleUsage
(vehicleId, startDate, endDate)
values
(@vehicleId, @startDate, @endDate)
";
            SqlParameter[] para = {
                new SqlParameter("@vehicleId", vehicleId),
                new SqlParameter("@startDate", startDate),
                new SqlParameter("@endDate", endDate)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        public void DelBusUsage(int original_usageId)
        {
            string sql = "delete vehicleUsage where usageId=@usageId";
            SqlParameter[] para = {
                new SqlParameter("@usageId", original_usageId)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        #endregion
    }
}
