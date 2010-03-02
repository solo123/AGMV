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

public partial class Controls_PubControls_CtlLb_AgentName : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public int agentID
    {
        set 
        {
            AgentBiz biz = new AgentBiz();
            lbAgentName.Text = biz.GetAgentNameByID(value) + " (agent ID:" + value.ToString() + ")";
        }
        get { return 0; }
    }
}
