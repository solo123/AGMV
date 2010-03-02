using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.OmeiDataSet;
using com.Omei.OmeiAdminData;

namespace com.Omei.BLL.Admin
{
    public class PhotoBiz :AdminBll
    {
        public enum PhotoType
        {
            Undefined = 0,
            DestinationPhoto,
            TourIcon,
        };

        #region Photo Operate
        public int AddPhoto(PhotoType photoType)
        {
            string SQL = @"
insert into Photos (picOrder,picType,status) values (10,@photoType,0);
select SCOPE_IDENTITY() as picId;
";
            SqlParameter[] para = {
                new SqlParameter("@photoType", photoType)
            };
            object o = m_dao.ExecuteScalar(SQL, para);
            int id = Convert.ToInt32(o);
            return id;
        }

        public void DeletePhoto(int picId)
        {
            string SQL = "delete Photos where picId=@picId";
            SqlParameter[] para = {
                new SqlParameter("@picId", picId)
            };
            m_dao.ExecuteNoQuery(SQL, para);
        }

        public D_PhotoDetail GetPhotoDetail(int photoId)
        {
            D_PhotoDetail pd = new D_PhotoDetail();
            if (photoId <= 0) 
                return pd;

            string sql = "select * from Photos where picId=@picId";
            SqlParameter[] para = {
                new SqlParameter("@picId", photoId)
            };
            IDataReader dr = m_dao.ExecuteReader(sql, para);
            if (dr.Read())
            {
                pd.picId = (int)dr["picId"];
                pd.relateId = (int)dr["relateId"];
                pd.title = (string)dr["title"];
                pd.title_cn = (string)dr["title_cn"];
                pd.description = (string)dr["description"];
                pd.description_cn = (string)dr["description_cn"];
                pd.picOrder = (int)dr["picOrder"];
                pd.photoType = (byte)dr["picType"];
                pd.status = (byte)dr["status"];
            }
            return pd;
        }

        public bool UpdatePhotoDetail(D_PhotoDetail photoDetail)
        {
            string sql = @"
update Photos
set
    relateId=@relateId,
    picOrder=@picOrder,
    picType=@photoType,
    title=@title,
    title_cn=@title_cn,
    description=@description,
    description_cn=@description_cn,
    status=@status
where picId=@picId
";
            SqlParameter[] para = {
                new SqlParameter("@picId", photoDetail.picId),
                new SqlParameter("@relateId", photoDetail.relateId),
                new SqlParameter("@picOrder", photoDetail.picOrder),
                new SqlParameter("@photoType", photoDetail.photoType),
                new SqlParameter("@title", photoDetail.title),
                new SqlParameter("@title_cn", photoDetail.title_cn),
                new SqlParameter("@description", photoDetail.description),
                new SqlParameter("@description_cn", photoDetail.description_cn),
                new SqlParameter("@status", photoDetail.status)
            };
            m_dao.ExecuteNoQuery(sql, para);
            return true;
        }

        /*
        public DS_DestinationPhotoList GetAllDestinationPhotoList(int relateId, PhotoType photoType)
        {
            string SQL = "select picId as photoId, title_cn as photoTitle, status from Photos where relateId=@relateId and picType=@photoType";
            DS_DestinationPhotoList ds = new DS_DestinationPhotoList();
            SqlParameter[] para = {
                new SqlParameter("@relateId", relateId),
                new SqlParameter("@photoType", photoType)
            };
            m_dao.FillDataSet(ds, "PhotoListTbl", SQL, para);
            return ds;
        }
         */
        #endregion
    }
}
