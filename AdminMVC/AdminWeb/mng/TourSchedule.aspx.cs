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
using com.Omei.DLL;

public partial class Admin_TourSchedule : AdminBase
{

    #region Page_Load
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int tourID = PageTools.GetSavedId("tourID", Request.QueryString["id"]);
            if (tourID > 0 && Request.QueryString["id"] == null)
                Response.Redirect("TourSchedule.aspx?id=" + tourID.ToString());

            if (tourID == 0)
                Response.Redirect("tours.aspx");

            LoadWeekly(tourID);
            lstSchedule.DataBind();
        }
    }
    #endregion


    #region 顯示每週齣發選項
    private void LoadWeekly(int tourID)
    {
        if (tourID>0)
        {
            AdminTourBiz biz = new AdminTourBiz();
            string weekly = biz.GetWeekly(tourID);

            chkAutoCreate.Checked = (weekly[0] == 'Y');
            chkMonday.Checked = (weekly.IndexOf('1') >= 0);
            chkTuesday.Checked = (weekly.IndexOf('2') >= 0);
            chkWednesday.Checked = (weekly.IndexOf('3') >= 0);
            chkThursday.Checked = (weekly.IndexOf('4') >= 0);
            chkFriday.Checked = (weekly.IndexOf('5') >= 0);
            chkSaturday.Checked = (weekly.IndexOf('6') >= 0);
            chkSunday.Checked = (weekly.IndexOf('0') >= 0);

            DS_Tours.tourDetailDataTable dt = biz.GetTourDetail(tourID);
            if (dt.Rows.Count > 0)
            {
                DS_Tours.tourDetailRow row = dt.Rows[0] as DS_Tours.tourDetailRow;
                lbTourName.Text = "#" + row.TourID.ToString() + ":" + row.TourName + " / " + row.TourName_cn;
            }
        }
    }
    #endregion

    #region 保存齣發週期設置
    protected void btnSaveWeekly_Click(object sender, EventArgs e)
    {
        int tourID = PageTools.ParseInt(Request.QueryString["id"]);
        if (tourID>0)
        {
            AdminTourBiz biz = new AdminTourBiz();
            string weekly = (chkAutoCreate.Checked ? 'Y' : 'N') + GetWeekly();
            biz.SetWeekly(tourID, weekly);
            LoadWeekly(tourID);
        }
    }
    private string GetWeekly()
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        if (chkSunday.Checked) sb.Append('0');
        if (chkMonday.Checked) sb.Append('1');
        if (chkTuesday.Checked) sb.Append('2');
        if (chkWednesday.Checked) sb.Append('3');
        if (chkThursday.Checked) sb.Append('4');
        if (chkFriday.Checked) sb.Append('5');
        if (chkSaturday.Checked) sb.Append('6');
        return sb.ToString();
    }
    #endregion

    #region 自動齣團
    protected void btnCreateScheduleNow_Click(object sender, EventArgs e)
    {
        int tourID = PageTools.ParseInt(Request.QueryString["id"]);
        if (tourID<=0) return;

        //先保存再生成
        btnSaveWeekly_Click(null, null);

        AdminTourBiz tbiz = new AdminTourBiz();
        int days = tbiz.GetTourDays(tourID) - 1;

        AdminTourScheduleBiz biz = new AdminTourScheduleBiz();
        biz.GenSchedule(tourID, GetWeekly(), days);
        biz.GetPriceFromTour();

        lstSchedule.DataBind();
    }
    #endregion

    #region 添加臨時日程
    protected void btnAddSchedule_Click(object sender, EventArgs e)
    {
        int tourID = PageTools.ParseInt(Request.QueryString["id"]);
        
        if (tourID<=0) return;

        DateTime startDate = dateStart.DateValue;
        if (startDate < DateTime.Now)
        {
            txtAddScheduleMessage.Text = "日期不能在今日之前！";
            txtAddScheduleMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        AdminTourBiz biz = new AdminTourBiz();
        AdminTourScheduleBiz asbiz = new AdminTourScheduleBiz();
        int scheduleId = asbiz.GenSepcialSchedule(tourID, startDate, biz.GetTourDays(tourID));
        if (scheduleId>0)
        {
            txtAddScheduleMessage.Text = "成功添加新Schedule：<b><a href='ScheduleEdit.aspx?id=" + scheduleId.ToString() + "'>" + scheduleId.ToString() + "</a></b>";
            txtAddScheduleMessage.ForeColor = System.Drawing.Color.DarkGreen;
            asbiz.GetPriceFromTour();
        }
        else
        {
            txtAddScheduleMessage.Text = "添加指定日期團失敗：" + biz.ErrorMessage ;
            txtAddScheduleMessage.ForeColor = System.Drawing.Color.Red;
        }
        lstSchedule.DataBind();

    }
    #endregion 
    
    
}
