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

using com.Omei.BLL.Admin;
using com.Omei.DLL;
using com.Omei.DLL.DS_EmployeeTableAdapters;

public partial class EmployeeRoleEdit : System.Web.UI.Page
{
    private DS_Employee.userRoleDataTable userRolesTable = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int employeeID = PageTools.ParseInt(Request.QueryString["id"]);
            if (employeeID <= 0)
            {
                Response.Redirect("EmployeeList.aspx");
                return;
            }

            EmployeeBiz biz = new EmployeeBiz();
            lbEmployeeName.Text = biz.GetEmployeeName(employeeID);
        }
    }

    protected void lstRoles_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (userRolesTable == null)
        {
            userRoleTableAdapter adp = new userRoleTableAdapter();
            userRolesTable = adp.GetRolesByEmployeeID(PageTools.ParseInt(Request.QueryString["id"]));
        }

        GridViewRow row = e.Row;
        if (row.RowType == DataControlRowType.DataRow)
        {
            int roleID = PageTools.ParseInt(DataBinder.Eval(row.DataItem, "listValue").ToString());
            if (roleID > 0 && userRolesTable.Rows.Count > 0)
            {
                DataRow[] rows = userRolesTable.Select("roleType=1 and roleID=" + roleID.ToString());
                if (rows.Length > 0)
                {
                    CheckBox cb = row.FindControl("CheckBox1") as CheckBox;
                    if (cb != null)
                    {
                        cb.Checked = true;
                    }
                }
            }
        }
    }

    protected void lstPositions_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (userRolesTable == null)
        {
            userRoleTableAdapter adp = new userRoleTableAdapter();
            userRolesTable = adp.GetRolesByEmployeeID(PageTools.ParseInt(Request.QueryString["id"]));
        }

        GridViewRow row = e.Row;
        if (row.RowType == DataControlRowType.DataRow)
        {
            int roleID = PageTools.ParseInt(DataBinder.Eval(row.DataItem, "listValue").ToString());
            if (roleID > 0 && userRolesTable.Rows.Count > 0)
            {
                DataRow[] rows = userRolesTable.Select("roleType=2 and roleID=" + roleID.ToString());
                if (rows.Length > 0)
                {
                    CheckBox cb = row.FindControl("CheckBox1") as CheckBox;
                    if (cb != null)
                    {
                        cb.Checked = true;
                    }
                }
            }
        }
    }

    protected void btnSaveRole_Click(object sender, EventArgs e)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        EmployeeBiz biz = new EmployeeBiz();
        int employeeID = PageTools.ParseInt(Request.QueryString["id"]);
        if (employeeID<=0) return;

        // create check box array
        foreach (GridViewRow row in lstRoles.Rows)
        {
            CheckBox cb = row.FindControl("CheckBox1") as CheckBox;
            if (cb != null && cb.Checked)
            {
                HiddenField hf = row.FindControl("HiddenField1") as HiddenField;
                sb.Append(hf.Value);
                sb.Append(',');

                biz.AddUserRole(employeeID, PageTools.ParseInt(hf.Value));
            }
        }
        if (sb.Length > 1) sb.Remove(sb.Length - 1, 1);
        biz.DelUserRole(employeeID, sb.ToString());
    }
    protected void btnSavePos_Click(object sender, EventArgs e)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        EmployeeBiz biz = new EmployeeBiz();
        int employeeID = PageTools.ParseInt(Request.QueryString["id"]);
        if (employeeID <= 0) return;

        // create check box array
        foreach (GridViewRow row in lstPositions.Rows)
        {
            CheckBox cb = row.FindControl("CheckBox1") as CheckBox;
            if (cb != null && cb.Checked)
            {
                HiddenField hf = row.FindControl("HiddenField1") as HiddenField;
                sb.Append(hf.Value);
                sb.Append(',');

                biz.AddUserPosition(employeeID, PageTools.ParseInt(hf.Value));
            }
        }
        if (sb.Length > 1) sb.Remove(sb.Length - 1, 1);
        biz.DelUserPosition(employeeID, sb.ToString());
    }
    
}
