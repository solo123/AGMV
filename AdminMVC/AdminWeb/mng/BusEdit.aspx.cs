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
using com.Omei.OmeiAdminData;

public partial class Admin_BusEdit : AdminBase
{
    #region Page_Load
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] == null)
            Response.Redirect("BusList.aspx");

        if (!Page.IsPostBack)
        {
            int vehicleId = int.Parse(Request.QueryString["id"]);
            AdminBusBiz biz = new AdminBusBiz();
            this.BusInfo = biz.GetVehicleDetail(vehicleId);
        }
    }
    #endregion

    #region BusInfo
    public D_BusInfo BusInfo
    {
        set
        {
            ViewState["vehicleId"] = value.vehicleId;
            if (value.vehicleId < 0)
                txtVehicleId.Text = "<b>新車</b>";
            else
                txtVehicleId.Text = value.vehicleId.ToString();
            txtName.Text = value.vehicleName;
            if (value.vehicleType > 0)
                lstVehicleType.SelectedValue = value.vehicleType.ToString();
            else
                lstVehicleType.SelectedIndex = -1;
            txtSeatNum.Text = value.customerSeatNum.ToString();
            txtInspDate.Text = value.inspectionDate.ToShortDateString();
            txtPlate.Text = value.plateNumber;
            txtVin.Text = value.vinNumber;
            chkOwn.Checked = (value.own == 1);
            chkStatus.Checked = (value.status == 1);
            txtNotes.Text = value.notes;
            lstBusUsage.VehicleId = value.vehicleId;
        }
        get
        {
            D_BusInfo bi = new D_BusInfo();
            bi.vehicleId = (int)ViewState["vehicleId"];
            bi.vehicleName = txtName.Text;
            if (lstVehicleType.SelectedIndex < 0)
                bi.vehicleType = 0;
            else
                bi.vehicleType = byte.Parse(lstVehicleType.SelectedValue);
            bi.customerSeatNum = int.Parse(txtSeatNum.Text);
            bi.inspectionDate = DateTime.Parse(txtInspDate.Text);
            bi.plateNumber = txtPlate.Text;
            bi.vinNumber = txtVin.Text;
            bi.own = (chkOwn.Checked ? (byte)1 : (byte)0);
            bi.status = (chkStatus.Checked ? (byte)1 : (byte)0);
            bi.notes = txtNotes.Text;
            return bi;
        }
    }
    #endregion

    #region Button Event: Save, Delete

    protected void btnSave_Click(object sender, EventArgs e)
    {
        AdminBusBiz biz = new AdminBusBiz();
        D_BusInfo bi = this.BusInfo;
        if (bi.vehicleId < 0)
        {
            bi.vehicleId = biz.Add();
        }
        if (biz.Update(bi))
        {
            txtToolMessage.Text = "保存成功！";
            txtToolMessage.ForeColor = System.Drawing.Color.DarkGreen;
            this.BusInfo = bi;
        }
        else
        {
            txtToolMessage.Text = "保存失败，请检查。";
            txtToolMessage.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        AdminBusBiz biz = new AdminBusBiz();
        biz.Delete(this.BusInfo.vehicleId);
        Response.Redirect("BusList.aspx");
    }
    #endregion
}
