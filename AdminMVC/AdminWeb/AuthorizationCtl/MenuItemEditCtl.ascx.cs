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

public partial class AuthorizationCtl_MenuItemEditCtl : System.Web.UI.UserControl
{
    private string strOnChanged = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public int MenuID
    {
        set
        {
            MenuItemDataset.SelectParameters["menuID"].DefaultValue = value.ToString();
            fvMenuItem.DataBind();
        }
    }

    public string OnChanged
    {
        set { strOnChanged = value; }
    }


    protected void fvMenuItem_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        ItemChanged();
    }
    protected void fvMenuItem_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        ItemChanged();
    }
    protected void fvMenuItem_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        ItemChanged();
    }

    private void ItemChanged()
    {
        if (strOnChanged != null && strOnChanged != "")
        {
            Delegate d = Delegate.CreateDelegate(typeof(EventHandler), Page, strOnChanged);
            ((EventHandler)d)(this, null);
        }
    }

    protected void MenuItemDataset_Inserting(object sender, ObjectDataSourceMethodEventArgs e)
    {
        e.InputParameters["pageName"] = "ASP." + e.InputParameters["navigateUrl"].ToString().Replace('.', '_');
    }
}
