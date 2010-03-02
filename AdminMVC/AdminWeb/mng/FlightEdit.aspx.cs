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

public partial class FlightEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["new"] != null)
                fvFlight.ChangeMode(FormViewMode.Insert);
        }

    }
    protected void AirportCode_ServerValidate(object source, ServerValidateEventArgs args)
    {
        AirportBiz biz = new AirportBiz();
        args.IsValid = biz.ValidateAirportCode(args.Value);
    }
    protected void AirlineCode_ServerValidate(object source, ServerValidateEventArgs args)
    {
        AirlineBiz biz = new AirlineBiz();
        args.IsValid = biz.ValidateAirlineCode(args.Value);
    }
    protected void fvFlight_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        Response.Redirect("FlightsList.aspx");
    }
    protected void fvFlight_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        Response.Redirect("FlightsList.aspx");
    }
    protected void fvFlight_ItemCreated(object sender, EventArgs e)
    {
        if (fvFlight.CurrentMode == FormViewMode.Edit && fvFlight.DataItem!=null)
        {
            Infragistics.WebUI.WebCombo.WebCombo wcFrom = fvFlight.FindControl("seleAirportFrom") as Infragistics.WebUI.WebCombo.WebCombo;
            if (wcFrom != null)
            {
                Infragistics.WebUI.WebCombo.WebCombo wcTo = fvFlight.FindControl("seleAirportTo") as Infragistics.WebUI.WebCombo.WebCombo;
                Infragistics.WebUI.WebCombo.WebCombo wcAirline = fvFlight.FindControl("seleAirline") as Infragistics.WebUI.WebCombo.WebCombo;
                wcFrom.DisplayValue = DataBinder.Eval(fvFlight.DataItem, "airportFrom").ToString();
                wcTo.DisplayValue = DataBinder.Eval(fvFlight.DataItem, "airportTo").ToString();
                wcAirline.DisplayValue = DataBinder.Eval(fvFlight.DataItem, "airline").ToString();
            }

        }
    }
    protected void FlightDataset_Updating(object sender, ObjectDataSourceMethodEventArgs e)
    {
        Infragistics.WebUI.WebCombo.WebCombo wcFrom = fvFlight.FindControl("seleAirportFrom") as Infragistics.WebUI.WebCombo.WebCombo;
        if (wcFrom != null)
        {
            Infragistics.WebUI.WebCombo.WebCombo wcTo = fvFlight.FindControl("seleAirportTo") as Infragistics.WebUI.WebCombo.WebCombo;
            Infragistics.WebUI.WebCombo.WebCombo wcAirline = fvFlight.FindControl("seleAirline") as Infragistics.WebUI.WebCombo.WebCombo;

            e.InputParameters["airportFrom"] = wcFrom.DisplayValue;
            e.InputParameters["airportTo"] = wcTo.DisplayValue;
            e.InputParameters["airline"] = wcAirline.DisplayValue;
        }


    }
}
