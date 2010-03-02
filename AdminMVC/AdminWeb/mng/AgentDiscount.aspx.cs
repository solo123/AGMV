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

public partial class AgentDiscount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();

        // check change list
        foreach (GridViewRow row in lstCompany.Rows)
        {
            Label lbID = row.FindControl("lbAgentID") as Label;
            Label lbCompany = row.FindControl("lbCompanyName") as Label;
            Label lbCompany_en = row.FindControl("lbCompanyName_cn") as Label;
            TextBox txtDiscount = row.FindControl("txtDiscount") as TextBox;
            HiddenField hdDiscount = row.FindControl("hdDiscount") as HiddenField;
            TextBox txtCredit = row.FindControl("txtCredit") as TextBox;
            HiddenField hdCredit = row.FindControl("hdCredit") as HiddenField;

            decimal newDiscount = PageTools.ParseDecimal(txtDiscount.Text);
            decimal oldDiscount = PageTools.ParseDecimal(hdDiscount.Value);
            decimal newCredit = PageTools.ParseDecimal(txtCredit.Text);
            decimal oldCredit = PageTools.ParseDecimal(hdCredit.Value);
            if (newDiscount != oldDiscount || newCredit!=oldCredit)
            {
                sb.Append("<tr><td>");
                sb.Append(lbID.Text);
                sb.Append("</td><td>");
                sb.Append(lbCompany.Text);
                sb.Append(" / ");
                sb.Append(lbCompany_en.Text);
                sb.Append("</td><td>&nbsp;");
                if (newCredit != oldCredit)
                {
                    sb.Append(oldCredit.ToString("N2"));
                    sb.Append(" ==&gt; ");
                    sb.Append(newCredit.ToString("N2"));
                }
                sb.Append("</td><td>&nbsp;");

                if (newDiscount != oldDiscount)
                {
                    sb.Append(oldDiscount.ToString("N2"));
                    sb.Append(" ==&gt; ");
                    sb.Append(newDiscount.ToString("N2"));
                }
                sb.Append("</td></tr>");
            }
        }

        if (sb.Length > 0)
        {
            sb.Insert(0, @"
<table cellpadding=4 cellspacing=0 border=1 class=DataList>
<tr class=list_head align=middle>
    <td>ID</td>
    <td>Agent Name</td>
    <td>Max Credit</td>
    <td>Discount</td>
</tr>");
            sb.Append("</table>");

            lbMsg.Text = sb.ToString();

            btnSave.Visible = false;
            pnResult.Visible = true;
            lstCompany.Visible = false;
        }

    }
    protected void btnSaveToDB_Click(object sender, EventArgs e)
    {
        AgentBiz biz = new AgentBiz();

        // check change list
        foreach (GridViewRow row in lstCompany.Rows)
        {
            Label lbID = row.FindControl("lbAgentID") as Label;
            TextBox txtDiscount = row.FindControl("txtDiscount") as TextBox;
            HiddenField hdDiscount = row.FindControl("hdDiscount") as HiddenField;
            TextBox txtCredit = row.FindControl("txtCredit") as TextBox;
            HiddenField hdCredit = row.FindControl("hdCredit") as HiddenField;

            decimal newDiscount = PageTools.ParseDecimal(txtDiscount.Text);
            decimal oldDiscount = PageTools.ParseDecimal(hdDiscount.Value);
            int agentID = PageTools.ParseInt(lbID.Text);

            if (newDiscount != oldDiscount)
            {
                biz.SaveAgentDiscount(agentID, newDiscount);
            }

            decimal newCredit = PageTools.ParseDecimal(txtCredit.Text);
            decimal oldCredit = PageTools.ParseDecimal(hdCredit.Value);
            if (newCredit != oldCredit)
            {
                biz.SaveAgentCredit(agentID, newCredit);
            }

        }
        lstCompany.DataBind();
        btnSave.Visible = true;
        pnResult.Visible = false;
        lstCompany.Visible = true;
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        pnResult.Visible = false;
        lstCompany.Visible = true;
        btnSave.Visible = true;

    }

}
