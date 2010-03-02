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

public partial class AgentPaymentItems : System.Web.UI.Page
{
    int agentID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
        }

    }
    protected void lstAgentPaymentItems_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (agentID == 0 && e.Row.RowType == DataControlRowType.DataRow)
        {
            agentID = (int)DataBinder.Eval(e.Row.DataItem, "agentID");
            AgentTitleCtl1.AgentID = agentID;

            lnkOrders.NavigateUrl = "AgentOrders.aspx?agent=" + agentID.ToString();
        }

    }
}
