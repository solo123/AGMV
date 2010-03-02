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

public partial class AirlineEdit : System.Web.UI.Page
{
    private DS_Airline.AirlineCodeDataTable airlineTable = new DS_Airline.AirlineCodeDataTable();
    private System.Drawing.Color ColorSuccess = System.Drawing.Color.LightGreen,
        ColorFailure = System.Drawing.Color.Pink;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnChange_Click(object sender, EventArgs e)
    {

    }
    protected void lstAirline_UpdateRowBatch(object sender, Infragistics.WebUI.UltraWebGrid.RowEventArgs e)
    {
        DS_Airline.AirlineCodeRow row = airlineTable.NewAirlineCodeRow();
        foreach (UltraGridCell c in e.Row.Cells)
            if(c.Value!=null) row[c.Column.Key] = c.Value;

        AirlineBiz biz = new AirlineBiz();
        bool b = false;

        switch (e.Row.DataChanged)
        {
            case DataChanged.Added:
                b = biz.AddAirlineCode(row.airlineCode, row.name, row.name_cn);
                break;
            case DataChanged.Modified:
                b = biz.UpdateAirlineCode(row.airlineID, row.airlineCode, row.name, row.name_cn);
                break;
        }
        if (b)
            e.Row.Style.BackColor = ColorSuccess;
        else
            e.Row.Style.BackColor = ColorFailure;
        
    }

}
