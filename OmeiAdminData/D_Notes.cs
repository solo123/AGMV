using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.OmeiAdminData
{
    public enum NotesType
    {
        N_A = 0,
        ScheduleNotes,
        TourNotes,
        VehicleNotes,
        TestNotes = 999
    }

    public class D_Notes
    {
        public int notesId, refid, userId;
        public NotesType notesType;
        public string notes;
        public bool status;
        public DateTime notesDate;

        public D_Notes()
        {
            notesId = refid = userId = 0;
            notesType = NotesType.N_A;
            notes = "";
            status = false;
            notesDate = new DateTime(1900, 1, 1);
        }
    }
}
