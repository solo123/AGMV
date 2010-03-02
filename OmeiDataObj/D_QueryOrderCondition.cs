using System;
using System.Collections.Generic;
using System.Text;

namespace com.Omei.OmeiDataSet
{
    public class D_QueryOrderCondition
    {
        public int ScheduleID;
        public string CustomerName, Phone;
        public DateTime StartDate, EndDate;
        public int Status;
        public bool IsGetAll;

        public D_QueryOrderCondition()
        {
            ScheduleID = Status = 0;
            CustomerName = Phone = null;

            StartDate = DateTime.MinValue;
            EndDate = DateTime.MaxValue;

            IsGetAll = false;
        }

        public string GetCondition(string scheduleTablePre, string customerTablePre)
        {
            if (IsGetAll) return "";

            string pre = "";
            if(scheduleTablePre!=null && scheduleTablePre.Length>0)
            {
                pre = scheduleTablePre + ".";
            }
            string cpre = "";
            if(customerTablePre!=null && customerTablePre.Length>0)
            {
                cpre = customerTablePre + ".";
            }
            StringBuilder sb = new StringBuilder();

            if (ScheduleID > 0)
            {
                sb.Append(pre);
                sb.Append("scheduleID=");
                sb.Append(ScheduleID);
                sb.Append(" and ");
            }
            if (CustomerName != null && CustomerName.Length > 0)
            {
                sb.Append(cpre);
                sb.Append("firstName+'.'+");
                sb.Append(cpre);
                sb.Append("lastName like '");
                sb.Append(MakeQueryString(CustomerName));
                sb.Append("' and ");
            }
            if (Phone != null && Phone.Length > 0)
            {
                sb.Append(cpre);
                sb.Append("contactPhone like '");
                sb.Append(MakeQueryString(Phone));
                sb.Append("' and ");

            }
            if (StartDate.Year > 1900)
            {
                sb.Append(pre);
                sb.Append("startDate>='");
                sb.Append(StartDate.ToShortDateString());
                sb.Append("' and ");
            }
            if (EndDate.Year > 1900 && EndDate.Year < 2100)
            {
                sb.Append(pre);
                sb.Append("startDate<='");
                sb.Append(EndDate.ToShortDateString());
                sb.Append("' and ");
            }
            if (Status >= 0)
            {
                sb.Append(pre);
                sb.Append("status=");
                sb.Append(Status);
                sb.Append(" and ");
            }

            if (sb.Length > 5)
                sb.Remove(sb.Length - 5, 5);

            return sb.ToString();
        }

        private string MakeQueryString(string qry)
        {
            if (qry == null || qry.Length == 0) return "";

            string cn = qry.Replace("%", "%%");
            cn = cn.Replace('*', '%');
            cn = cn.Replace('?', '_');
            cn = cn.Replace("'", "''");
            if (cn[cn.Length - 1] != '%') cn += "%";
            return cn;
        }

    }
}
