﻿using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class WebParts_AgentInfoCtl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public int AgentID
    {
        set
        {
            AgentDataset.SelectParameters["agentID"].DefaultValue = value.ToString();
            fvAgent.DataBind();
        }
    }
}
