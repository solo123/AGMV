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

public partial class Controls_PubControls_CtlLst_AgentOrders : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public int MatchID
    {
        set
        {
                OrdersDataset.SelectParameters["matchID"].DefaultValue = value.ToString();
                OrdersDataset.DataBind();
        }
    }
}
