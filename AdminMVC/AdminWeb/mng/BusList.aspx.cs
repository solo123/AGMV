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

using com.Omei.OmeiDataSet;
using com.Omei.BLL.Admin;

public partial class Admin_BusList : AdminList
{
    protected void Page_Load(object sender, EventArgs e)
    {
        base.EditPageUrl = "BusEdit.aspx";
        if (!Page.IsPostBack)
        {
            lstBusType.DataBind();
            LoadData();
        }
    }

    protected void lstBus_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        base.RowOnMouseOverEvent(e.Row, "vehicleId");
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        LoadData();
    }
    protected void lstStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadData();
    }

    private void LoadData()
    {
        BusDataset.SelectParameters["vehicleType"].DefaultValue = lstBusType.SelectedValue;
        if (lstStatus.SelectedIndex >= 0)
            BusDataset.SelectParameters["status"].DefaultValue = lstStatus.SelectedValue;
        else
            BusDataset.SelectParameters["status"].DefaultValue = "99";

        string n = "";
        if (inpBusName.Text.Trim() != "")
            n = "%" + inpBusName.Text.Trim() + "%";

        BusDataset.SelectParameters["vehicleName"].DefaultValue = n;

        lstBus.DataBind();
    }
}
