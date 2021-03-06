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

public partial class AgentRecvInvoiceList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int agentID = PageTools.ParseInt(Request.QueryString["agent"]);
            if (agentID > 0)
                AgentInfoCtl1.AgentID = agentID;
        }

    }
    protected void lstInvoice_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        GridViewRow row = e.Row;
        if (row.RowType == DataControlRowType.DataRow)
        {
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
            row.Attributes.Add("onclick", "itemClick('AgentRecvInvoice.aspx?recv=" + DataBinder.Eval(row.DataItem, "recvInvID") + "')");
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        Response.Redirect("AgentRecvInvoice.aspx?recv=" + txtInvoiceID.Text);
    }
}
