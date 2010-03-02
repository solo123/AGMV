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

public partial class WebParts_ScheduleHotelCtl : System.Web.UI.UserControl
{
    private bool _isChanged = false;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (_isChanged)
        {
            ScheduleHotelDataset.SelectParameters["scheduleID"].DefaultValue = ScheduleID.ToString();
            lstHotels.DataBind();
        }
    }

    #region 属性: ScheduleID, Days
    public string Hotel
    {
        set { }
        get { return string.Empty; }
    }
    public int ScheduleID
    {
        set
        {
            ViewState["ScheduleID"] = value;
            _isChanged = true;
        }
        get
        {
            if (ViewState["ScheduleID"] == null)
                return 0;
            else
                return (int)ViewState["ScheduleID"];
        }
    }
    public int Days
    {
        set
        {
            ViewState["TourDays"] = value;
            _isChanged = true;
        }
        get
        {
            if (ViewState["TourDays"] == null)
                return 0;
            else
                return (int)ViewState["TourDays"];
        }
    }
    #endregion

    #region event: add, del
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        AdminTourScheduleBiz biz = new AdminTourScheduleBiz();
        biz.AddScheduleHotels(ScheduleID, Days-1);
        
        // reload list
        _isChanged = true;
    }
    protected void btnDel_Click(object sender, EventArgs e)
    {
        ScheduleHotelDataset.DeleteParameters["scheduleID"].DefaultValue = ScheduleID.ToString();
        ScheduleHotelDataset.Delete();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveData();
    }

    public void SaveData()
    {
        if (ScheduleID > 0 && Days > 1)
        {
            AdminTourScheduleBiz biz = new AdminTourScheduleBiz();
            foreach (GridViewRow row in lstHotels.Rows)
            {
                Controls_DataSelector d = row.FindControl("seleHotel") as Controls_DataSelector;
                int hotelID = PageTools.ParseInt(d.SelectedValue);
                int shid = PageTools.ParseInt(((HiddenField)row.FindControl("hdScheduleHotelID")).Value);
                int night = PageTools.ParseInt(((Literal)row.FindControl("txtNight")).Text);
                biz.UpdateScheduleHotel(shid, hotelID, night);
            }
            _isChanged = true;
        }
    }
    #endregion
}
