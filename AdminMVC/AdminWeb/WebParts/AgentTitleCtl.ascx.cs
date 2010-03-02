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

public partial class WebParts_AgentTitleCtl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #region  Ù–‘£∫agentID
    public int AgentID
    {
        set
        {
            if (value <= 0)
                lbAgentName.Text = "";
            else
            {
                AdminCompanyBiz biz = new AdminCompanyBiz();
                lbAgentName.Text = biz.GetCompanyNameByID(value);
            }
        }
    }
    #endregion
}
