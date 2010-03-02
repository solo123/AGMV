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

public partial class CompanyEdit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int companyID = PageTools.GetSavedId("AgentID", Request.QueryString["id"]);
            if (companyID <= 0) Response.Redirect("Companys.aspx");

            CompanyDetailDataset.SelectParameters["companyId"].DefaultValue = companyID.ToString();
            fvCompanyDetail.DataBind();
        }
    }
    protected void CompanyDetailDataset_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
    {
        Response.Redirect("Companys.aspx");
    }
    protected void CompanyDetailDataset_Deleted(object sender, ObjectDataSourceStatusEventArgs e)
    {
        Response.Redirect("Companys.aspx");
    }
}
