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

public partial class ScheduleCancel : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            dateFrom.DateValue = DateTime.Now;
            dateTo.DateValue = DateTime.Now.AddDays(7);

            btnQuery_Click(null, null);
        }

    }

    protected void btnQuery_Click(object sender, EventArgs e)
    {
        LoadScheduleList();
    }
    private void LoadScheduleList()
    {
        ScheduleListDataset.SelectParameters["startDate"].DefaultValue = dateFrom.DateValue.ToShortDateString();
        ScheduleListDataset.SelectParameters["endDate"].DefaultValue = dateTo.DateValue.ToShortDateString();

        string tourID = "0";
        if (txtTourID.Text != null && txtTourID.Text.Trim() != string.Empty) tourID = txtTourID.Text;
        ScheduleListDataset.SelectParameters["tourID"].DefaultValue = tourID;
        lstSchedule.DataBind();

    }

    protected void lstSchedule_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int idx;
        switch (e.CommandName)
        {
            case "ScheduleEdit":
                idx = int.Parse(e.CommandArgument.ToString());
                Response.Redirect("ScheduleEdit.aspx?id=" + lstSchedule.DataKeys[idx].Value.ToString());
                break;
            case "ShowSeats":
                idx = int.Parse(e.CommandArgument.ToString());
                Response.Redirect("BusSeats.aspx?id=" + lstSchedule.DataKeys[idx].Value.ToString());
                break;
            default:
                break;
        }
    }

    protected void lstSchedule_DataBound(object sender, EventArgs e)
    {
        // create check box array
        foreach (GridViewRow row in lstSchedule.Rows)
        {
            CheckBox cb = row.FindControl("chkSchedule") as CheckBox;
            ClientScript.RegisterArrayDeclaration("CheckBoxIDs", "'" + cb.ClientID + "'");
        }
    }

    #region Open & Cancel schedules
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        AdminTourScheduleBiz biz = new AdminTourScheduleBiz();
        string ids = GetSelectedSchedules();
        if (ids.Length > 0)
        {
            biz.ChangeStatus(ids, 7);
            LoadScheduleList();
        }
    }
    protected void btnOpen_Click(object sender, EventArgs e)
    {
        AdminTourScheduleBiz biz = new AdminTourScheduleBiz();
        string ids = GetSelectedSchedules();
        if (ids.Length > 0)
        {
            biz.ChangeStatus(ids, 1);
            LoadScheduleList();
        }
    }
    private string GetSelectedSchedules()
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        foreach (GridViewRow row in lstSchedule.Rows)
        {
            CheckBox cb = row.FindControl("chkSchedule") as CheckBox;
            HyperLink lb = row.FindControl("lnkScheduleID") as HyperLink;
            if (cb.Checked)
            {
                sb.Append(lb.Text);
                sb.Append(',');
            }
        }
        if (sb.Length > 0) sb.Remove(sb.Length - 1, 1);
        return sb.ToString();
    }
    #endregion
}
