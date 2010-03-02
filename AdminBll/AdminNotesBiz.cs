using System;
using System.Collections.Generic;
using System.Text;

using System.Data.SqlClient;
using com.Omei.OmeiAdminData;

namespace com.Omei.BLL.Admin
{
    
    public class AdminNotesBiz :AdminBll
    {
        /*
        #region GetNotes
        public DS_Notes GetNotes(int refid, NotesType notesType, byte status)
        {
            string sql = @"
select n.*, u.firstName+'.'+u.lastName as username
from notes as n
	left join userinfo as u on n.userId=u.userId 
where refid=@refid and notesType=@notesType and (n.status=1 or n.status=@status)
order by notesDate desc;
";
            SqlParameter[] para = {
                new SqlParameter("@refid", refid),
                new SqlParameter("@notesType", notesType),
                new SqlParameter("@status", status)
            };
            DS_Notes ds = new DS_Notes();
            m_dao.FillDataSet(ds, "NotesTbl", sql, para);
            return ds;
        }
        #endregion
*/
        #region AddNotes, UpdateNotes
        public int AddNotes(int refid, NotesType notesType)
        {
            string sql = @"
insert Notes
(refid, notesType)
values
(@refid, @notesType);
select SCOPE_IDENTITY() as id;
";
            SqlParameter[] para = {
                new SqlParameter("@refid", refid),
                new SqlParameter("@notesType", notesType)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            int id = Convert.ToInt32(o);
            return id;
        }
        public void UpdateNotes(D_Notes notes)
        {
            if (notes.notesId <= 0)
            {
                notes.notesId = AddNotes(notes.refid, notes.notesType);
                if (notes.notesId <= 0) return;
            }

            string sql = @"
update notes
set
    notes=@notes,
    userId=@userId,
    notesDate=getdate(),
    status=@status
where notesId=@notesId;
";
            SqlParameter[] para = {
                new SqlParameter("@notesId", notes.notesId),
                new SqlParameter("@notes", notes.notes),
                new SqlParameter("@userId", notes.userId),
                new SqlParameter("@status", notes.status)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }

        public void UpdateNotes(int notesId, int userId, string notes, int status)
        {
            if (notesId <= 0) return;

            string sql = @"
update notes
set
    notes=@notes,
    notesDate=getdate(),
    status=@status
where notesId=@notesId and userId=@userId;
";
            SqlParameter[] para = {
                new SqlParameter("@notesId", notesId),
                new SqlParameter("@notes", notes),
                new SqlParameter("@userId", userId),
                new SqlParameter("@status", status)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }

        public void DeleteNotes(int notesId)
        {
            if (notesId <= 0) return;
            string sql = "update notes set status=1 where notesId=@notesId";
            SqlParameter[] para = {
                new SqlParameter("@notesId", notesId)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }

        #endregion

    }
}
