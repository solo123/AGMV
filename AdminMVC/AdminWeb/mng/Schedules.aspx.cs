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

public partial class Schedules : System.Web.UI.Page
{
    #region Page_Load
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtDateFrom.Text = DateTime.Now.ToShortDateString();
            txtDateTo.Text = DateTime.Now.AddDays(7).ToShortDateString();
            
            btnQuery_Click(null, null);
        }
    }
    #endregion

    #region ��ԃ���ڹ����ȵ�schedules
    protected void btnQuery_Click(object sender, EventArgs e)
    {
        txtMsg.Text = "";
        try
        {
            DateTime dts = DateTime.Parse(txtDateFrom.Text);
            DateTime dte = DateTime.Parse(txtDateTo.Text);
            ScheduleListDataset.SelectParameters["startDate"].DefaultValue = dts.ToShortDateString();
            ScheduleListDataset.SelectParameters["endDate"].DefaultValue = dte.ToShortDateString();
            lstSchedule.DataBind();
        }
        catch
        {
            txtMsg.Text = "���ڸ�ʽ������Ո�z�顣";
        }

    }
    #endregion

    #region ���x��
    protected void lstSchedule_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["OnClick"] = ClientScript.GetPostBackEventReference(lstSchedule, "Select$" + e.Row.RowIndex);
            e.Row.Style["cursor"] = "hand";
        }
    }
    #endregion

    #region �Q�
    protected void lstSchedule_PageIndexChanged(object sender, EventArgs e)
    {
        lstSchedule.SelectedIndex = -1;
    }
    #endregion

    #region ���x��
    protected void lstSchedule_SelectedIndexChanged(object sender, EventArgs e)
    {
        ScheduleBaseInfoDataset.SelectParameters["scheduleId"].DefaultValue =
            lstSchedule.SelectedDataKey.Value.ToString();

        fvScheduleBaseInfo.DataBind();
    }
    #endregion
}
