using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class BookmarkBiz : AdminBll
    {
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetBookmark(int status)
        {
            string sql = @"select * from bookmark ";
            if (status > 0) sql += " where status>0 and status<>7";
            sql += " order by bookmarkid";
            return m_dao.ExecuteDataSet(sql, null);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public void UpdateBookmark(
            int original_bookmarkID, string title, string url, int status)
        {
            string sql = @"
update bookmark
set title=@title, url=@url, status=@status
where bookmarkID=@bookmarkID";
            SqlParameter[] para = {
                new SqlParameter("@title", title),
                new SqlParameter("@url", url),
                new SqlParameter("@status", status),
                new SqlParameter("@bookmarkID", original_bookmarkID),
            };
            m_dao.ExecuteNoQuery(sql, para);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, false)]
        public void AddBookmark()
        {
            string sql = @"
insert bookmark
(title, url, status)
values
('', '', 0)";
            m_dao.ExecuteNoQuery(sql, null);
        }
    }
}
