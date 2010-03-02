using System;
using System.Collections.Generic;
using System.Text;

using System.Data;
using System.Data.SqlClient;
using com.Omei.OmeiDataSet;
using com.Omei.OmeiAdminData;
using com.Omei.DLL;
using com.Omei.DLL.DS_CompanysTableAdapters;

namespace com.Omei.BLL.Admin
{
    [System.ComponentModel.DataObject]
    public class AdminCompanyBiz : AdminBll
    {
        #region GetCompanyNameByID
        public string GetCompanyNameByID(int companyID)
        {
            if (companyID == 0)
                return "&lt;no agent&gt;";
            string sql = "select companyName + ' / ' + companyName_cn as companyName from company where companyID=" + companyID.ToString();
            object o = m_dao.ExecuteScalar(sql, null);
            if (o == null)
                return string.Empty;
            else
                return (string)o;
        }
        #endregion

        #region Add &  Delete


        public int Add()
        {
            string SQL = @"
insert company
(status)
values
(0);
select SCOPE_IDENTITY() as id;
";
            object o = m_dao.ExecuteScalar(SQL, null);
            int id = Convert.ToInt32(o);
            return id;
        }

        public void Delete(int original_companyId)
        {
            string SQL = @"
update company set status=0 where companyId=@companyId
";
            SqlParameter[] para = {
                new SqlParameter("@companyId", original_companyId)
            };
            m_dao.ExecuteNoQuery(SQL, para);
        }

        #endregion

        #region company List, detail get & update
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Companys.CompanyListDataTable GetCompanys(int status, int companyType, string companyName)
        {
            string sql = @"
SELECT companyId, shortname, companyName, telephone, contactPerson, 
      companyType, status
FROM Company";
            
            string cnd = "";
            bool b = false;
            if (status>=0 && status<3)
                cnd += "status=" + status.ToString() + " and ";

            if (companyType>0)
                cnd += "companyType=" + companyType.ToString() + " and ";

            if (companyName!=null && companyName.Length>2)
            {
                cnd += "companyName like @companyName and ";
                b = true;
            }
            if (cnd.Length > 0)
                sql += " WHERE " + cnd.Substring(0,cnd.Length-5);

            DS_Companys ds = new DS_Companys();

            if(b){
                SqlParameter[] para = {
                    new SqlParameter("@companyName", companyName),
                };
                m_dao.FillDataSet(ds,"CompanyList", sql, para);
            }
            else
                m_dao.FillDataSet(ds,"CompanyList", sql, null);
            return ds.CompanyList;
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Companys.CompanyDetailDataTable GetCompanyDetail(int companyID)
        {
            CompanyDetailTableAdapter adp = new CompanyDetailTableAdapter();
            return adp.GetCompanyDetail(companyID);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Update, false)]
        public bool UpdateCompanyDetail(
            string shortName,string companyName, string companyName_cn, 
            string address, string city, string state, string zip, string country,
            string telephone, string fax, string contactPerson, string email,
            byte companyType, string iconUrl, string website, string description, string description_cn,
            decimal discount, byte status, int Original_companyId
            )
        {
            string sql = @"
update company
    set shortName=@shortName,companyName=@companyName, companyName_cn=@companyName_cn, 
        address=@address, city=@city, state=@state, zip=@zip, country=@country,
        telephone=@telephone, fax=@fax, contactPerson=@contactPerson, email=@email, 
        companyType=@companyType, iconUrl=@iconUrl, website=@website, 
        description=@description, description_cn=@description_cn,
        discount=@discount, status=@status
where companyID=@companyID";

            SqlParameter[] para = {
                new SqlParameter("@shortName", shortName),
                new SqlParameter("@companyName", companyName), 
                new SqlParameter("@companyName_cn", companyName_cn),
                new SqlParameter("@address", address),
                new SqlParameter("@city", city),
                new SqlParameter("@state", state),
                new SqlParameter("@zip", zip),
                new SqlParameter("@country", country),
                new SqlParameter("@telephone", telephone),
                new SqlParameter("@fax",fax),
                new SqlParameter("@contactPerson", contactPerson),
                new SqlParameter("@email", email),
                new SqlParameter("@companyType", companyType),
                new SqlParameter("@iconUrl", iconUrl),
                new SqlParameter("@website", website),
                new SqlParameter("@description", description),
                new SqlParameter("@description_cn", description_cn),
                new SqlParameter("@discount", discount),
                new SqlParameter("@status", status),
                new SqlParameter("@companyID", Original_companyId),
            };

            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Insert, false)]
        public bool AddCompany(
            string shortName, string companyName, string companyName_cn, 
            string address, string city, string state, string zip, string country,
            string telephone, string fax, string contactPerson, string email,
            byte companyType, string iconUrl, string website, string description, string description_cn,
            decimal discount, byte status
        )
        {
            string sql = @"
insert company
(
    shortName,companyName, companyName_cn, 
    address, city, state, zip, country,
    telephone, fax, contactPerson, email, 
    companyType, iconUrl, website, 
    description, description_cn,
    discount, status)
values
(
    @shortName,@companyName, @companyName_cn, 
    @address, @city, @state, @zip, @country,
    @telephone, @fax, @contactPerson, @email, 
    @companyType, @iconUrl, @website, 
    @description, @description_cn,
    @discount, @status);";

            SqlParameter[] para = {
                new SqlParameter("@shortName", shortName),
                new SqlParameter("@companyName", companyName), 
                new SqlParameter("@companyName_cn", companyName_cn),
                new SqlParameter("@address", address),
                new SqlParameter("@city", city),
                new SqlParameter("@state", state),
                new SqlParameter("@zip", zip),
                new SqlParameter("@country", country),
                new SqlParameter("@telephone", telephone),
                new SqlParameter("@fax",fax),
                new SqlParameter("@contactPerson", contactPerson),
                new SqlParameter("@email", email),
                new SqlParameter("@companyType", companyType),
                new SqlParameter("@iconUrl", iconUrl),
                new SqlParameter("@website", website),
                new SqlParameter("@description", description),
                new SqlParameter("@description_cn", description_cn),
                new SqlParameter("@discount", discount),
                new SqlParameter("@status", status),
            };

            int i = m_dao.ExecuteNoQuery(sql, para);
            return (i == 1);
        }
        #endregion

        #region Agent List
        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Companys.CompanyNameListDataTable GetAllAgents()
        {
            CompanyNameListTableAdapter adp = new CompanyNameListTableAdapter();
            return adp.GetCompanyNameList(3);
        }

        [System.ComponentModel.DataObjectMethodAttribute(System.ComponentModel.DataObjectMethodType.Select, false)]
        public DS_Companys.CompanyNameListDataTable GetHaveOrdersAgents()
        {
            DS_Companys ds = new DS_Companys();
            string sql = @"
SELECT companyId, companyName_cn, companyName + ', ' +  companyName_cn as companyName
FROM Company
WHERE companyId in (select distinct agentID from agentOrders where status<7)";
            m_dao.FillDataSet(ds, "CompanyNameList", sql, null);
            return ds.CompanyNameList;
        }
        #endregion


    }
}
