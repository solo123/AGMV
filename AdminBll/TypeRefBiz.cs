using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.DLL;
using com.Omei.DLL.DS_TypeRefTableAdapters;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class TypeRefBiz : AdminBll
    {
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_TypeRef.DListDataTable GetAllListValue(string listClass)
        {
            DListTableAdapter adp = new DListTableAdapter();
            return adp.GetList(listClass);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_TypeRef.DListDataTable GetListValueByID(int tid)
        {
            DListTableAdapter adp = new DListTableAdapter();
            return adp.GetListByID(tid);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
        public DS_TypeRef.DListDataTable GetValidListValue(string listClass)
        {
            DListTableAdapter adp = new DListTableAdapter();
            return adp.GetValidList(listClass);
        }


        #region OmeiStatus
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_TypeRef.OmeiStatusDataTable GetStatusByClass(string listClass)
        {
            DS_TypeRef ds = new DS_TypeRef();
            string sql = @"
SELECT tid, listClass, listTitle, listTitle_cn, listValue, listStyle, listBack, status
FROM TypeRef
WHERE listClass=@listClass";
            SqlParameter[] para = {
                new SqlParameter("@listClass", listClass)
            };
            m_dao.FillDataSet(ds, "OmeiStatus", sql, para);
            return ds.OmeiStatus;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_TypeRef.OmeiStatusDataTable GetStatusByID(int tid)
        {
            DS_TypeRef ds = new DS_TypeRef();
            string sql = @"
SELECT tid, listClass, listTitle, listTitle_cn, listValue, listStyle, listBack, status
FROM TypeRef
WHERE tid=@tid";
            SqlParameter[] para = {
                new SqlParameter("@tid", tid)
            };
            m_dao.FillDataSet(ds, "OmeiStatus", sql, para);
            return ds.OmeiStatus;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public bool UpdateOmeiStatus(int original_tid, string listClass, string listTitle, string listTitle_cn, string listValue, string listStyle, string listBack, int status)
        {
            string sql = @"
update typeref
set listClass=@listClass, listTitle=@listTitle, listTitle_cn=@listTitle_cn, listValue=@listValue, listStyle=@listStyle, listBack=@listBack, status=@status
where tid=@tid
";
            if (listTitle == null) listTitle = "";
            if (listTitle_cn == null) listTitle_cn = listTitle;
            if (listStyle == null) listStyle = "";
            if (listBack == null) listBack = "";

            SqlParameter[] para = {
                new SqlParameter("@tid", original_tid),
                new SqlParameter("@listClass", listClass),
                new SqlParameter("@listTitle", listTitle),
                new SqlParameter("@listTitle_cn", listTitle_cn),
                new SqlParameter("@listValue", listValue),
                new SqlParameter("@listStyle", listStyle),
                new SqlParameter("@listBack", listBack),
                new SqlParameter("@status", status)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, false)]
        public bool AddOmeiStatus(string listClass, string listTitle, string listTitle_cn, string listValue, string listStyle, string listBack)
        {
            string sql = @"
insert typeref
(listClass, listTitle, listTitle_cn, listValue, listStyle, listBack, status)
values
(@listClass, @listTitle, @listTitle_cn, @listValue, @listStyle, @listBack, 1);";

            if (listStyle == null) listStyle = "";
            if (listBack == null) listBack = "";
            if (listTitle_cn == null) listTitle_cn = listTitle;

            SqlParameter[] para = {
                new SqlParameter("@listClass", listClass),
                new SqlParameter("@listTitle", listTitle),
                new SqlParameter("@listTitle_cn", listTitle_cn),
                new SqlParameter("@listValue", listValue),
                new SqlParameter("@listStyle", listStyle),
                new SqlParameter("@listBack", listBack)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Delete, true)]
        public void DeleteOmeiStatus(int original_tid)
        {
            string sql = @"delete TypeRef where tid=@tid";
            SqlParameter[] para = {
                new SqlParameter("@tid", original_tid)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public bool UpdateType(int original_tid, string listTitle, string listTitle_cn, string listValue, string listStyle, string listBack, int status)
        {
            string sql = @"
update typeref
set listTitle=@listTitle, listTitle_cn=@listTitle_cn, listValue=@listValue, listStyle=@listStyle, listBack=@listBack, status=@status
where tid=@tid
";
            if (listTitle == null) listTitle = "";
            if (listTitle_cn == null) listTitle_cn = listTitle;
            if (listStyle == null) listStyle = "";
            if (listBack == null) listBack = "";

            SqlParameter[] para = {
                new SqlParameter("@tid", original_tid),
                new SqlParameter("@listTitle", listTitle),
                new SqlParameter("@listTitle_cn", listTitle_cn),
                new SqlParameter("@listValue", listValue),
                new SqlParameter("@listStyle", listStyle),
                new SqlParameter("@listBack", listBack),
                new SqlParameter("@status", status)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, false)]
        public bool AddType(string listClass, string listTitle, string listTitle_cn, string listValue, string listStyle, string listBack)
        {
            string sql = @"
insert typeref
(listClass, listTitle, listTitle_cn, listValue, listStyle, listBack, status)
values
(@listClass, @listTitle, @listTitle_cn, @listValue, @listStyle, @listBack, 1);";

            if (listStyle == null) listStyle = "";
            if (listBack == null) listBack = "";
            if (listTitle_cn == null) listTitle_cn = listTitle;

            SqlParameter[] para = {
                new SqlParameter("@listClass", listClass),
                new SqlParameter("@listTitle", listTitle),
                new SqlParameter("@listTitle_cn", listTitle_cn),
                new SqlParameter("@listValue", listValue),
                new SqlParameter("@listStyle", listStyle),
                new SqlParameter("@listBack", listBack)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }
        #endregion


    }
}
