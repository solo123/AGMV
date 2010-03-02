using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using com.Omei.DLL;
using com.Omei.DLL.DS_EmployeeTableAdapters;
using com.Omei.DLL.DS_TypeRefTableAdapters;

public partial class EmployeeRoles : System.Web.UI.Page
{
    private DS_Employee.userRoleDataTable userRolesTable = null;
    private DS_TypeRef.DListDataTable rolesTable = null;
    private DS_TypeRef.DListDataTable positionsTable = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void lstEmployee_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row;
        if (row.RowType == DataControlRowType.DataRow)
        {
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
            row.Attributes.Add("onclick", "itemClick('EmployeeRoleEdit.aspx?id=" + DataBinder.Eval(row.DataItem, "employeeID") + "')");
        }
    }

    #region ShowRoles, ShowPositions
    protected string ShowRoles(object employeeID)
    {
        if (employeeID == null) return string.Empty;
        int eid = (int)employeeID;
        if (eid == 0) return string.Empty;

        if (userRolesTable == null)
        {
            userRoleTableAdapter adp = new userRoleTableAdapter();
            userRolesTable = adp.GetUserRoles();
        }
        if(rolesTable==null)
        {
            DListTableAdapter adp = new DListTableAdapter();
            rolesTable = adp.GetValidList("Role");
        }

        DataRow[] rows = userRolesTable.Select("roleType=1 and employeeID=" + eid.ToString());
        if (rows.Length > 0)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            foreach (DS_Employee.userRoleRow row in rows)
            {
                DataRow[] rr = rolesTable.Select("listValue='"+ row.roleID.ToString() + "'");
                if (rr.Length > 0)
                {
                    sb.Append(rr[0]["listTitle"].ToString());
                    sb.Append(",");
                }
            }
            return sb.ToString();
        }
        else
            return string.Empty;
    }

    protected string ShowPositions(object employeeID)
    {
        if (employeeID == null) return string.Empty;
        int eid = (int)employeeID;
        if (eid == 0) return string.Empty;

        if (userRolesTable == null)
        {
            userRoleTableAdapter adp = new userRoleTableAdapter();
            userRolesTable = adp.GetUserRoles();
        }
        if (positionsTable == null)
        {
            DListTableAdapter adp = new DListTableAdapter();
            positionsTable = adp.GetValidList("Position");
        }

        DataRow[] rows = userRolesTable.Select("roleType=2 and employeeID=" + eid.ToString());
        if (rows.Length > 0)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            foreach (DS_Employee.userRoleRow row in rows)
            {
                DataRow[] rr = positionsTable.Select("listValue='" + row.roleID.ToString() + "'");
                if (rr.Length > 0)
                {
                    sb.Append(rr[0]["listTitle"].ToString());
                    sb.Append(",");
                }
            }
            return sb.ToString();
        }
        else
            return string.Empty;
    }
    
    #endregion

}
