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
using com.Omei.BLL.Admin;
public partial class AgentCommission : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int agentID = PageTools.GetSavedId("AgentID", Request.QueryString["agent"]);
            if (agentID <= 0) Response.Redirect("AgentReceivables.aspx");
            else
            {
                OrdersDataset.SelectParameters["agentID"].DefaultValue = agentID.ToString();
                lstOrders.DataBind();

                AgentDataset.SelectParameters["agentID"].DefaultValue = agentID.ToString();
                fvAgent.DataBind();
            }
        }
    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();

        // check change list
        int cnt = 0;
        AgentOrderBiz biz = new AgentOrderBiz();
        foreach (GridViewRow row in lstOrders.Rows)
        {
            HyperLink lbID = row.FindControl("lnkOrderID") as HyperLink;
            Label lbCustomer = row.FindControl("lbCustomer") as Label;
            TextBox txtAgentCmt = row.FindControl("txtAgentCmt") as TextBox;
            HiddenField hdAgentCmt = row.FindControl("hdAgentCmt") as HiddenField;

            int orderID = PageTools.ParseInt(lbID.Text);
            decimal oldCmt = PageTools.ParseDecimal(hdAgentCmt.Value);
            decimal newCmt = PageTools.ParseDecimal(txtAgentCmt.Text);
            if (orderID>0 && newCmt != oldCmt)
            {
                cnt++;
                bool r = biz.ChangeOrderCommission(orderID, oldCmt, newCmt);
                sb.Append("<tr><td>");
                sb.Append(orderID);
                sb.Append("</td><td>");
                sb.Append(lbCustomer.Text);
                sb.Append("</td><td>&nbsp;");
                sb.Append(oldCmt.ToString("N2"));
                sb.Append(" ==&gt; ");
                sb.Append(newCmt.ToString("N2"));
                sb.Append("</td><td>");
                if (r)
                    sb.Append("<font color='darkGreen'>修改成功！</font>");
                else
                    sb.Append("<font color='darkRed'>修改失敗！</font>");
                sb.Append("</td></tr>");
            }
        }

        if (cnt > 0)
        {
            sb.Insert(0, @"
共修改 " + cnt.ToString() + @" 條記錄。
<table cellpadding=4 cellspacing=0 border=1 class=DataList>
<tr class=list_head align=middle>
    <td>Order#</td>
    <td>Customer</td>
    <td>Agent Commission</td>
    <td>修改狀態</td>
</tr>");
            sb.Append("</table>");

            lbMsg.Text = sb.ToString();
            lstOrders.DataBind();
        }
        else
            lbMsg.Text = "沒有記錄被修改。";
    }


}
