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

public partial class WebParts_TypeRefCtl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ReLoad();
        }

    }
    private void ReLoad()
    {
        typeRefDataset.SelectParameters["listClass"].DefaultValue = ListClass;
        lstTypes.DataBind();

        if (lstTypes.SelectedIndex >= 0)
            fvTypeRef.ChangeMode(FormViewMode.ReadOnly);
        else
            fvTypeRef.ChangeMode(FormViewMode.Insert);
    }

    #region  Ù–‘
    public string ListClass
    {
        set
        {
            ViewState["listClass"] = value;
        }
        get
        {
            if (ViewState["listClass"] == null)
                return null;
            else
                return (string)ViewState["listClass"];
        }
    }
    #endregion

    protected void lstTypes_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (lstTypes.SelectedIndex < 0)
        {
            fvTypeRef.ChangeMode(FormViewMode.Insert);
        }
        else
        {
            fvTypeRef.ChangeMode(FormViewMode.ReadOnly);
            typeRefDetailDataset.SelectParameters["tid"].DefaultValue = lstTypes.SelectedValue.ToString();
            fvTypeRef.DataBind();
        }

    }

    protected void fvTypeRef_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        typeRefDetailDataset.InsertParameters["listClass"].DefaultValue = ListClass;
    }
    protected void fvTypeRef_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        ReLoad();
    }
    protected void fvTypeRef_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        ReLoad();
    }
    protected void fvTypeRef_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        ReLoad();
    }
}
