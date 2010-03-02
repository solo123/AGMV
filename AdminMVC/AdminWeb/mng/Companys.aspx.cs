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

public partial class Companys : AdminList
{
    protected void Page_Load(object sender, EventArgs e)
    {
        base.EditPageUrl = "CompanyEdit.aspx";
    }
 
    protected void lstCompany_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        RowOnMouseOverEvent(e.Row, "companyId");
    }


    protected void btnGo_Click(object sender, EventArgs e)
    {
        if (txtSearch.Text != "")
        {
            CompanyListDataset.SelectParameters["companyName"].DefaultValue = "%" + txtSearch.Text.Trim() + "%";
        }
        else
            CompanyListDataset.SelectParameters["companyName"].DefaultValue = "";
        lstCompany.DataBind();
    }
}
