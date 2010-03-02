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

public partial class SearchCustomer_pop : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (PageTools.ParseInt(Request.QueryString["id"]) > 0)
            {
                Response.Redirect("userInfo_pop.aspx?id=" + Request.QueryString["id"]);
            }
            txtSearch.Focus();
        }
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        btnSearch_Click(null, null);
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        UserListDataset.SelectParameters["searchStr"].DefaultValue = GetQueryString(txtSearch.Text);
        lstUsers.DataBind();
    }

    private string GetQueryString(string qryString)
    {
        if (qryString == null || qryString.Trim().Length == 0)
            return "";
        else
        {
            string s = qryString.Trim();
            if (s.IndexOf('*') >= 0 || s.IndexOf('?') >= 0)
            {
                s = s.Replace('*', '%');
                s = s.Replace('?', '_');
                return s;
            }
            else
            {
                return s + "%";
            }
        }
    }
    protected void lstUsers_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row;
        if (row.RowType == DataControlRowType.DataRow)
        {
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
            row.Attributes.Add("onclick", "itemClick('UserInfo_pop.aspx?id=" + DataBinder.Eval(row.DataItem, "userID") + "')");
        }
    }

}
