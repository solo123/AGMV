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
using com.Omei.OmeiDataSet;

public partial class DayBalance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            lbToday.Text = DateTime.Now.ToShortDateString();
        }

    }
    protected void btnBalanceStart_Click(object sender, EventArgs e)
    {
        DayBalanceBiz biz = new DayBalanceBiz();
        DateTime dt = DateTime.Parse(lbToday.Text);
        D_LoginUserInfo ui = Session["LoginUserInfo"] as D_LoginUserInfo;

        if (dt != null && ui != null)
        {
            // daily balance
            int preScheduleNum = biz.GenBalanceTable(dt, ui.userId);
            int closedScheduleNum = biz.SchedulesBalance();
            int orderNum = biz.OrdersBalance();
            string genScheduleNum = biz.AutoGenSchedule();
            int agentOrderNum = biz.AgentOrdersBalance();

            lbPreSchedule.Text = "Process "  + preScheduleNum.ToString() + " schedules, " + closedScheduleNum.ToString() + " schedules closed.";
            lbOrderNum.Text    = orderNum.ToString() + " orders closed.";
            lbAutoGen.Text = "<div class='ContentBox' style='height:200px; overflow-x:hidden; overflow-y:scroll;'>" + genScheduleNum + "</div>";
            lbAgent.Text = agentOrderNum.ToString() + " of agent orders full paid.";

        }

        btnBalanceStart.Visible = false;
        lbToday.Text = "結算已經完成。";
    }
}
