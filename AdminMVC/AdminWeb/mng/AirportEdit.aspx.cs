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

using Infragistics.WebUI.UltraWebGrid;

using com.Omei.BLL.Admin;
using com.Omei.DLL;

public partial class AirportEdit : System.Web.UI.Page
{
    private DS_Flight.AirportCodeDataTable airportTable = new DS_Flight.AirportCodeDataTable();
    private System.Drawing.Color ColorSuccess = System.Drawing.Color.LightGreen,
        ColorFailure = System.Drawing.Color.Pink;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnChange_Click(object sender, EventArgs e)
    {

    }
    protected void lstAirport_UpdateRowBatch(object sender, Infragistics.WebUI.UltraWebGrid.RowEventArgs e)
    {
        DS_Flight.AirportCodeRow row = airportTable.NewAirportCodeRow();
        foreach (UltraGridCell c in e.Row.Cells)
        {
            if(c.Value!=null)
                row[c.Column.Key] = c.Value;
        }

        AirportBiz biz = new AirportBiz();
        bool b = false;

        switch (e.Row.DataChanged)
        {
            case (DataChanged.Added):
                b = biz.AddAirportCode(row.airportCode, row.name, row.name_cn, row.country);
                break;
            case (DataChanged.Modified):
                b = biz.UpdateAirportCode(row.airportID, row.airportCode, row.name, row.name_cn, row.country);
                break;
        }
        if (b)
            e.Row.Style.BackColor = ColorSuccess;
        else
            e.Row.Style.BackColor = ColorFailure;

    }

}
