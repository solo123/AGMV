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

public partial class ListType : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["type"] != null)
            {
                string s = Request.QueryString["type"];
            }
        }
    }


    protected void lstTypeName_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void lstTypeName_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row;

        row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
        row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
        //row.Attributes.Add("onclick", "itemClick('TypeRefEdit.aspx?id=" + DataBinder.Eval(row.DataItem, "tid") + "')");
        
    }

    protected string ShowPrompt(object typeName, object listValue, string lang)
    {
        if (typeName == null || listValue == null) return string.Empty;

        string s = OmeiStatus.GetOmeiStatusText((string)typeName, listValue, lang);
        return s;
    }

    protected void btnReload_Click(object sender, EventArgs e)
    {
        OmeiStatus.ReloadStatus();
    }
}
