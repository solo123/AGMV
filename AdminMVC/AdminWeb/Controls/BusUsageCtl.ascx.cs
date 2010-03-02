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

public partial class Controls_BusUsageCtl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (!PageLogic.CheckActionAuth("auth_BusDel"))
            {
                lstBusUsage.Columns[0].Visible = false;
            }
        }

    }
    public int VehicleId
    {
        set
        {
            ViewState["BusUsage_VehicleId"] = value;
            BusUsageDataset.SelectParameters["vehicleId"].DefaultValue = value.ToString();
        }
        get
        {
            if (ViewState["BusUsage_VehicleId"] == null)
                return 0;
            else
                return (int)ViewState["BusUsage_VehicleId"];
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        AdminBusBiz biz = new AdminBusBiz();
        biz.AddBusUsage(VehicleId, DateTime.Parse(txtStartDate.Text), DateTime.Parse(txtEndDate.Text));

        lstBusUsage.DataBind();
    }

}
