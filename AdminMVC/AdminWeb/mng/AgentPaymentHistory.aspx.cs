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

public partial class AgentPaymentHistory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
        }

    }
    protected void lstAgentPayment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row;
        if (row.RowType == DataControlRowType.DataRow)
        {
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
            row.Attributes.Add("onclick", "itemClick('AgentPaymentItems.aspx?id=" + DataBinder.Eval(row.DataItem, "apID") + "')");
        }
    }
}
