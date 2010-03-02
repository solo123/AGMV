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

public partial class AuthorizationCtl_ActionEditCtl : System.Web.UI.UserControl
{
    string strOnChanged = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public int ActionID
    {
        set
        {
            ActionDataset.SelectParameters["actionID"].DefaultValue = value.ToString();
            fvAction.DataBind();
        }
    }

    public string OnChanged
    {
        set { strOnChanged = value; }
    }
    protected void fvAction_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        ItemChanged();
    }
    protected void fvAction_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        ItemChanged();
    }
    protected void fvAction_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
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
}
