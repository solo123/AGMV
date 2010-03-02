using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.DLL;
using com.Omei.DLL.DS_EmployeeTableAdapters;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class EmployeeBiz : AdminBll
    {
        #region GetEmployeeDetail
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
        public DS_Employee.EmployeeDetailDataTable GetEmployeeDetail(int employeeID)
        {
            EmployeeDetailTableAdapter adp = new EmployeeDetailTableAdapter();
            return adp.GetEmployeeDetail(employeeID);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
        public DS_Employee.EmployeeListDataTable GetEmployeeList(int roleID, int positionID, byte status)
        {
            EmployeeListTableAdapter adp = new EmployeeListTableAdapter();
            return adp.GetEmployeeList(status, roleID, positionID);
        }

        public string GetEmployeeName(int employeeID)
        {
            string sql = @"
select u.firstName+'.'+u.lastName + ' ('+ e.loginName + ')' as username 
from employeeInfo as e
	left join userInfo as u on e.userID=u.userID
where e.employeeID=@employeeID
";
            SqlParameter[] para = {
                new SqlParameter("@employeeID", employeeID)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o == null)
                return "*not exist*";
            else
                return o.ToString();
        }
        #endregion

        #region UpdateEmployeeDetail
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, true)]
        public void UpdateEmployeeDetail(
            object userLoginInfo,
            int original_employeeID, int original_userId,
            DateTime employDate, string ssn, DateTime birthday,
            int companyId, int status,
            string firstName, string lastName, string nickname,
            string address,
            string city, string state, string zip, string country,
            string homephone, string cellphone, string walkyphone,
            string email
            )
        {
            string sql = @"
update employeeInfo
set employDate=@employDate, ssn=@ssn, birthday=@birthday, nickname=@nickname,
    companyId=@companyId, status=@status
where employeeID=@original_employeeID;

update userInfo
set firstName=@firstName, lastName=@lastName, address=@address, city=@city, state=@state, zip=@zip, country=@country,
    homephone=@homephone, cellphone=@cellphone, walkyphone=@walkyphone,
    email=@email
where userId=@original_userId";

            SqlParameter[] para = {
                new SqlParameter("@original_employeeID", original_employeeID),
                new SqlParameter("@original_userId", original_userId),
                new SqlParameter("@employDate", employDate),
                new SqlParameter("@ssn", ssn),
                new SqlParameter("@birthday", birthday),
                new SqlParameter("@companyId", companyId),
                new SqlParameter("@status", status),
                new SqlParameter("@firstName", firstName),
                new SqlParameter("@lastName", lastName),
                new SqlParameter("@nickname", nickname),
                new SqlParameter("@address", address),
                new SqlParameter("@city", city),
                new SqlParameter("@state", state),
                new SqlParameter("@zip", zip),
                new SqlParameter("@country", country),
                new SqlParameter("@homephone", homephone),
                new SqlParameter("@cellphone", cellphone),
                new SqlParameter("@walkyphone", walkyphone),
                new SqlParameter("@email", email)
            };
            m_dao.ExecuteNoQuery(sql, para);

        }
        #endregion

        #region UpdateMyAccount
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, true)]
        public void UpdateMyAccount(
            object userLoginInfo,
            int original_employeeID, int original_userId,
            DateTime employDate, string ssn, DateTime birthday,
            int companyId,
            string firstName, string lastName, string nickname,
            string address,
            string city, string state, string zip, string country,
            string homephone, string cellphone, string walkyphone,
            string email
            )
        {
            string sql = @"
update employeeInfo
set employDate=@employDate, ssn=@ssn, birthday=@birthday, nickname=@nickname,
    companyId=@companyId
where employeeID=@original_employeeID;

update userInfo
set firstName=@firstName, lastName=@lastName, address=@address, city=@city, state=@state, zip=@zip, country=@country,
    homephone=@homephone, cellphone=@cellphone, walkyphone=@walkyphone,
    email=@email
where userId=@original_userId";

            SqlParameter[] para = {
                new SqlParameter("@original_employeeID", original_employeeID),
                new SqlParameter("@original_userId", original_userId),
                new SqlParameter("@employDate", employDate),
                new SqlParameter("@ssn", ssn),
                new SqlParameter("@birthday", birthday),
                new SqlParameter("@companyId", companyId),
                new SqlParameter("@firstName", firstName),
                new SqlParameter("@lastName", lastName),
                new SqlParameter("@nickname", nickname),
                new SqlParameter("@address", address),
                new SqlParameter("@city", city),
                new SqlParameter("@state", state),
                new SqlParameter("@zip", zip),
                new SqlParameter("@country", country),
                new SqlParameter("@homephone", homephone),
                new SqlParameter("@cellphone", cellphone),
                new SqlParameter("@walkyphone", walkyphone),
                new SqlParameter("@email", email)
            };
            m_dao.ExecuteNoQuery(sql, para);

        }
        #endregion

        #region AddEmployee
        public int AddEmployee(string loginname, string password)
        {
            string sql = "select count(*) from employeeInfo where loginName=@loginName";
            SqlParameter[] para = {
                new SqlParameter("@loginName", loginname)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o != null && Convert.ToInt32(o) > 0)
                return 0;

            sql = @"
insert userInfo
(firstname)
values
(@firstname);
select SCOPE_IDENTITY();
";
            SqlParameter[] para1 = {
                new SqlParameter("@firstname", loginname)
            };
            o = m_dao.ExecuteScalar(sql, para1);
            int userId = Convert.ToInt32(o);

            // add employee info
            sql = @"
insert into employeeInfo 
(userId, loginName, password, ssn, companyId, status) 
values 
(@userId, @loginName, @password,  '', 0, 0);
select SCOPE_IDENTITY();";
            SqlParameter[] para2 = {
                new SqlParameter("@userId", userId),
                new SqlParameter("@loginName", loginname),
                new SqlParameter("@password", password)
            };
            o = m_dao.ExecuteScalar(sql, para2);
            if (o == null)
                return 0;
            else
                return Convert.ToInt32(o);
        }
        #endregion

        #region GetAvailableDriver
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
        public DS_Employee.NameListDataTable GetAvalibleDriver(int scheduleID)
        {
            string sql = @"
declare @fromDate DateTime
declare @toDate DateTime

select @fromDate=startDate, @toDate=endDate
from BusSchedule
where scheduleID=@scheduleID;

SELECT userId, firstName as username
FROM userInfo
WHERE userType=3 and
	userId not in 
(
	select DISTINCT  driverId as userId
	from busSchedule
	where not (endDate<@fromDate or startDate>@toDate) and (scheduleId<>@scheduleId)

	union

	select DISTINCT  driverAssistanceId as userId
	from busSchedule
	where not (endDate<@fromDate or startDate>@toDate) and (scheduleId<>@scheduleId)
)";
            SqlParameter[] para = {
                new SqlParameter("@scheduleID", scheduleID)
            };
            DS_Employee ds = new DS_Employee();
            m_dao.FillDataSet(ds, "NameList", sql, para);
            return ds.NameList;
        }
        #endregion

        #region GetAvailableTourGuideList
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
        public DS_Employee.NameListDataTable GetAvailableTourGuideList(int scheduleID)
        {
            // --jimmy, 2006.12.22
            // in schedule, use UserID for tourGuide, not employeeID. just for easier to get username.
            // TODO: change to employeeID??
            string sql = @"
declare @fromDate DateTime
declare @toDate DateTime

select @fromDate=startDate, @toDate=endDate
from BusSchedule
where scheduleID=@scheduleID;

SELECT employeeID as userId, nickname as username
FROM EmployeeInfo
WHERE 
	(@fromDate is not null and @toDate is not null ) and 
	(status = 1) and 
	(employeeID in 
		(select employeeID from userRole where roleType=2 and roleID=1))
	and 
	employeeID not in 
(
	select DISTINCT  tourGuideId as employeeID
	from busSchedule
	where not (endDate<@fromDate or startDate>@toDate) and (scheduleId<>@scheduleId)

	union

	select DISTINCT  tourGuideAssistanceId as employeeID
	from busSchedule
	where not (endDate<@fromDate or startDate>@toDate) and (scheduleId<>@scheduleId)
)";

            SqlParameter[] para = {
                new SqlParameter("@scheduleID", scheduleID)
            };
            DS_Employee ds = new DS_Employee();
            m_dao.FillDataSet(ds, "NameList", sql, para);
            return ds.NameList;
        }
        #endregion

        #region GetAvailableBus
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, true)]
        public DS_Employee.NameListDataTable GetAvalibleBus(int scheduleID)
        {
            string sql = @"
declare @fromDate DateTime
declare @toDate DateTime

select @fromDate=startDate, @toDate=endDate
from BusSchedule
where scheduleID=@scheduleID;

SELECT vehicleName as username, vehicleId as userId
FROM vehicles
where status=1 and vehicleId in (
	select vehicleId
	from vehicleUsage
	where startDate<=@fromDate and endDate>=@toDate
) and vehicleId not in (
	select DISTINCT  vehicleId
	from busSchedule
	where not (endDate<@fromDate or startDate>@toDate) and (scheduleId<>@scheduleId)
)";
            SqlParameter[] para = {
                new SqlParameter("@scheduleID", scheduleID)
            };
            DS_Employee ds = new DS_Employee();
            m_dao.FillDataSet(ds, "NameList", sql, para);
            return ds.NameList;
        }
        #endregion

        #region Roles and poistions
        public void AddUserRole(int employeeID, int roleID)
        {
            string sql = @"
if(select count(*) from userRole where employeeID=@employeeID and roleID=@roleID and roleType=1)=0
begin
    insert into userRole
    (employeeID, roleID, roleType)
    values
    (@employeeID, @roleID, 1);
end;";
            SqlParameter[] para = {
                new SqlParameter("@employeeID", employeeID),
                new SqlParameter("@roleID", roleID)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        public void DelUserRole(int employeeID, string roles)
        {
            string sql = @"
delete userRole
where employeeID=@employeeID and roleType=1";
            if (roles != null && roles.Trim() != string.Empty)
            {
                sql += " and roleID not in (" + roles + ")";
            }
            SqlParameter[] para = {
                new SqlParameter("@employeeID", employeeID)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }

        public void AddUserPosition(int employeeID, int positionID)
        {
            string sql = @"
if(select count(*) from userRole where employeeID=@employeeID and roleID=@roleID and roleType=2)=0
begin
    insert into userRole
    (employeeID, roleID, roleType)
    values
    (@employeeID, @roleID, 2);
end;";
            SqlParameter[] para = {
                new SqlParameter("@employeeID", employeeID),
                new SqlParameter("@roleID", positionID)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }
        public void DelUserPosition(int employeeID, string positions)
        {
            string sql = @"
delete userRole
where employeeID=@employeeID and roleType=2";
            if (positions != null && positions.Trim() != string.Empty)
            {
                sql += " and roleID not in (" + positions + ")";
            }
            SqlParameter[] para = {
                new SqlParameter("@employeeID", employeeID)
            };
            m_dao.ExecuteNoQuery(sql, para);
        }

        public string GetUserRoleNameList(int employeeID)
        {
            string sql = @"
select listTitle 
from userRole as r
	left join TypeRef as t on t.listClass='Role' and t.status=1 and r.roleID=t.listValue
where r.employeeID=@employeeID and r.roleType=1";
            SqlParameter[] para = {
                new SqlParameter("@employeeID", employeeID)
            };
            IDataReader dr = m_dao.ExecuteReader(sql, para);
            StringBuilder sb = new StringBuilder();
            while (dr.Read())
            {
                sb.Append(dr[0]);
                sb.Append(',');
            }
            if (sb.Length > 1) sb.Remove(sb.Length - 1, 1);
            return sb.ToString();
        }
        public string GetUserPositionNameList(int employeeID)
        {
            string sql = @"
select listTitle 
from userRole as r
	left join TypeRef as t on t.listClass='Position' and t.status=1 and r.roleID=t.listValue
where r.employeeID=@employeeID and r.roleType=2";
            SqlParameter[] para = {
                new SqlParameter("@employeeID", employeeID)
            };
            IDataReader dr = m_dao.ExecuteReader(sql, para);
            StringBuilder sb = new StringBuilder();
            while (dr.Read())
            {
                sb.Append(dr[0]);
                sb.Append(',');
            }
            if (sb.Length > 1) sb.Remove(sb.Length - 1, 1);
            return sb.ToString();
        }
        #endregion

        #region LoginName and Password
        public bool ChangeLoginName(int employeeID, string loginName)
        {
            if (employeeID == 0 || loginName == null || loginName.Trim() == string.Empty)
                return false;

            string sql = @"
select count(*) from employeeInfo
where loginName=@loginName";
            SqlParameter[] para = {
                new SqlParameter("@loginName", loginName)
            };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o != null && Convert.ToInt32(o) > 0)
                return false;

            sql = "update employeeInfo set loginName=@loginName where employeeID=@employeeID";
            SqlParameter[] para1 = {
                new SqlParameter("@loginName", loginName),
                new SqlParameter("@employeeID", employeeID)
            };
            int i = m_dao.ExecuteNoQuery(sql, para1);
            return (i == 1);
        }

        public bool ChangePassword(int employeeID, string password)
        {
            string sql = "update employeeInfo set password=@password where employeeID=@employeeID";
            SqlParameter[] para = {
                new SqlParameter("@employeeID", employeeID),
                new SqlParameter("@password", password)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return i == 1;
        }

        public bool ChangeMyPassword(int employeeID, string oldPassword, string newPassword)
        {
            string sql = "update employeeInfo set password=@password where employeeID=@employeeID and password=@oldPassword";
            SqlParameter[] para = {
                new SqlParameter("@employeeID", employeeID),
                new SqlParameter("@password", newPassword),
                new SqlParameter("@oldPassword", oldPassword)
            };
            int i = m_dao.ExecuteNoQuery(sql, para);
            return i == 1;
        }
        #endregion

        #region GetEmployeeNameByID
        public string GetEmployeeNameByID(int employeeID)
        {
            string sql = "select nickname from employeeInfo where employeeID=@employeeID";
            SqlParameter[] para = { new SqlParameter("@employeeID", employeeID), };
            object o = m_dao.ExecuteScalar(sql, para);
            if (o != null && !(o is DBNull))
                return o.ToString();
            else
                return "[employee not found]";
        }
        #endregion
    }
}
