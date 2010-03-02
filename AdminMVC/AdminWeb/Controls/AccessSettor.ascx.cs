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

using com.Omei.OmeiAdminData;

public partial class Controls_AccessSettor : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }
/*
    public void LoadData(DS_Roles dsRole, string userRoles)
    {
        if (dsRole == null || dsRole.RoleTbl.Rows.Count < 1)
            return;

        chkList.Items.Clear();
        foreach (DS_Roles.RoleTblRow row in dsRole.RoleTbl.Rows)
        {
            ListItem li = new ListItem(row.roleName, row.roleId.ToString());
            li.Selected = (userRoles.IndexOf("[" + row.roleId.ToString() + "]") >= 0);
            chkList.Items.Add(li);
        }
        chkAll.Checked = (userRoles == "");
    }
*/
    public string RoleIds
    {
        get
        {
            if (chkAll.Checked) return "";

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            foreach (ListItem li in chkList.Items)
            {
                if (li.Selected == true)
                {
                    sb.Append('[');
                    sb.Append(li.Value);
                    sb.Append(']');
                }
            }
            return sb.ToString();
        }
    }
}
