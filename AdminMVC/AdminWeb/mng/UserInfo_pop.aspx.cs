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

using System.Text;

public partial class UserInfo_pop : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int id = PageTools.ParseInt(Request.QueryString["id"]);
            if (id < 1)
            {
                fvUserInfo.ChangeMode(FormViewMode.Insert);
            }
        }
    }
    protected void fvUserInfo_DataBound(object sender, EventArgs e)
    {
        if (fvUserInfo.CurrentMode == FormViewMode.ReadOnly)
        {
            HyperLink lnk = fvUserInfo.FindControl("lnkSelect") as HyperLink;
            if (lnk != null)
            {
                DataRowView dv = (DataRowView)fvUserInfo.DataItem;
                StringBuilder sb = new StringBuilder();
                sb.Append(dv["userID"]);
                sb.Append('|');
                sb.Append(dv["firstName"]);
                sb.Append('|');
                sb.Append(dv["lastName"]);
                sb.Append('|');
                sb.Append(dv["homePhone"]);
                sb.Append('|');
                sb.Append(dv["email"]);
                lnk.Attributes.Add("onclick", "CustomerSelected('"+ sb.ToString() +"')");

                if (Request.QueryString["ro"] != null)
                {
                    lnk.Visible = false;
                    LinkButton lnkNew = fvUserInfo.FindControl("NewButton") as LinkButton;
                    if(lnkNew!=null) lnkNew.Visible = false;

                    HyperLink lnkSearch = fvUserInfo.FindControl("lnkSearch") as HyperLink;
                    if(lnkSearch!=null) lnkSearch.Visible = false;
                }
            }
        }
    }

    protected void UserInfoDataset_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
    {
        int id = (int)e.ReturnValue;
        Response.Redirect("UserInfo_pop.aspx?id=" + id.ToString(), true);
    }
}
