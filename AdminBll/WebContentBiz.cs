using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.OmeiDataSet;
namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class WebContentBiz : AdminBll
    {
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetContentList()
        {
            string sql = @"
select contentID,contentKey,lastUpdate, employee, e.nickname as employeeName
from webcontent as w
	left join employeeInfo as e on w.employee=e.employeeID";
            return m_dao.ExecuteDataSet(sql, null);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DataSet GetContentDetail(int contentID)
        {
            string sql = @"
select contentID,contentKey, contentDetail, lastUpdate
from webcontent
where contentID=@contentID";
            SqlParameter[] para = { new SqlParameter("@contentID", contentID), };
            return m_dao.ExecuteDataSet(sql, para);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public bool UpdateContent(object loginUserAccount, int original_contentID, 
            string contentKey, string contentDetail)
        {
            D_LoginUserInfo ui = loginUserAccount as D_LoginUserInfo;
            if (ui==null || original_contentID<=0) return false;

            string sql = @"
update webcontent
set
    contentKey=@contentKey, contentDetail=@contentDetail,
    lastUpdate=getdate(), employee=@employeeID
where contentID=@contentID";

            SqlParameter[] para = {
                new SqlParameter("@contentID", original_contentID),
                new SqlParameter("@contentKey", contentKey),
                new SqlParameter("@contentDetail", contentDetail),
                new SqlParameter("@employeeID", ui.userId),
            };
            int r = m_dao.ExecuteNoQuery(sql, para);
            return (r == 1);
        }

        public int AddContent()
        {
            string sql = @"
insert webcontent
(contentKey, contentDetail, lastUpdate, employeeID)
values
('[new]','',getdate(),0);
select SCOPE_IDENTITY();";
            object o = m_dao.ExecuteScalar(sql, null);
            if (o == null)
                return 0;
            else
                return Convert.ToInt32(o);
        }
    }
}
