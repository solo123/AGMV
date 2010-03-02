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
public partial class OrderRecvAgent : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int orderID = PageTools.GetSavedId("orderID", null);
            if (orderID <= 0)
            {
                Response.Redirect("MyOrders.aspx");
                return;
            }
            OrderInfoCtl1.OrderId = orderID;
            ResetAgentID();
        }
    }

    private void ResetAgentID()
    {
        int orderID = PageTools.GetSavedId("orderID", null);
        AdminOrderBiz biz = new AdminOrderBiz();
        int agentID = biz.GetAgentID(orderID);

        AgentOrderBiz abiz = new AgentOrderBiz();
        bool isChangeable = abiz.IsAgentChangeable(orderID);

        seleAgent.SelectedValue = agentID.ToString();
        if (isChangeable)
        {
            btnChange.Enabled = true;
            lbMsg.Text = "";
        }
        else
        {
            btnChange.Enabled = false;
            lbMsg.Text = "不能修改Agent！請先撤銷此Order對應的收付賬單。";
        }
    }
    protected void btnChange_Click(object sender, EventArgs e)
    {
        int orderID = PageTools.GetSavedId("orderID", null);
        AgentOrderBiz biz = new AgentOrderBiz();
        if (biz.ChangeAgent(orderID, PageTools.ParseInt(seleAgent.SelectedValue)))
            Response.Redirect("OrderDetail.aspx");
        else
            lbMsg.Text = "修改Agent失敗，請檢查！";

    }
}
