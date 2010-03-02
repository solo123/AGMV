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

public partial class SearchCustomer : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["id"] != null)
            {
                txtSearch.Text = Request.QueryString["id"];
                btnSearch_Click(null, null);
            }
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        UserListDataset.SelectParameters["searchText"].DefaultValue = txtSearch.Text;
        lstUsers.DataBind();
    }

    
    protected void lstUsers_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row;
        if (row.RowType == DataControlRowType.DataRow)
        {
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
            row.Attributes.Add("onclick", "itemClick('UserInfo.aspx?id=" + DataBinder.Eval(row.DataItem, "userID") + "')");
            
            CheckBox cb = row.FindControl("chkUsers") as CheckBox;
            if (cb != null)
            {
                cb.Attributes.Add("onclick", "event.cancelBubble = true;");
            }
        }
    }

    protected string EditPageUrl(object userId)
    {
        return "EditCustomer('"+ userId.ToString() +"')";
    }

    protected void lstUsers_DataBound(object sender, EventArgs e)
    {
        // create check box array
        foreach (GridViewRow row in lstUsers.Rows)
        {
            CheckBox cb = row.FindControl("chkUsers") as CheckBox;
            ClientScript.RegisterArrayDeclaration("CheckBoxIDs", "'" + cb.ClientID + "'");
        }
    }

    #region Del Users
    protected void btnDelUsers_Click(object sender, EventArgs e)
    {
        lbMsg.Text = "";
        AdminUserBiz biz = new AdminUserBiz();
        string userIDs = GetSelectedUsers();
        if (userIDs.Length > 0)
        {
            int c = biz.SetUserStatus(userIDs, 0);
            lbMsg.Text = c.ToString() + " users deleted."; 
            btnSearch_Click(null, null);
        }
    }
    private string GetSelectedUsers()
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        foreach (GridViewRow row in lstUsers.Rows)
        {
            CheckBox cb = row.FindControl("chkUsers") as CheckBox;
            if (cb.Checked)
            {
                sb.Append(cb.Text);
                sb.Append(',');
            }
        }
        if (sb.Length > 0) sb.Remove(sb.Length - 1, 1);
        return sb.ToString();
    }
    protected void btnUndel_Click(object sender, EventArgs e)
    {
        lbMsg.Text = "";
        AdminUserBiz biz = new AdminUserBiz();
        string userIDs = GetSelectedUsers();
        if (userIDs.Length > 0)
        {
            int c = biz.SetUserStatus(userIDs, 1);
            lbMsg.Text = c.ToString() + " users un-deleted.";
            btnSearch_Click(null, null);
        }
    }
    #endregion

   
}
