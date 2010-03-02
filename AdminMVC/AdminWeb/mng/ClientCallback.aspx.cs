// ClientCallback.aspx.cs code-behind page
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

public partial class ClientCallback : System.Web.UI.Page,
     System.Web.UI.ICallbackEventHandler
{
    private string callBackResult = null;

    protected System.Collections.Specialized.ListDictionary catalog;
    protected void Page_Load(object sender, EventArgs e)
    {
        String cbReference =
            Page.ClientScript.GetCallbackEventReference(this,
            "arg", "ReceiveServerData", "context");
        String callbackScript;
        callbackScript = "function CallServer(arg, context)" +
            "{ " + cbReference + "} ;";
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(),
            "CallServer", callbackScript, true);

        catalog = new System.Collections.Specialized.ListDictionary();
        catalog.Add("monitor", 12);
        catalog.Add("laptop", 10);
        catalog.Add("keyboard", 23);
        catalog.Add("mouse", 17);

        ListBox1.DataSource = catalog;
        ListBox1.DataTextField = "key";
        ListBox1.DataBind();
    }

    public void RaiseCallbackEvent(String eventArgument)
    {
        if (catalog[eventArgument] == null)
        {
            callBackResult = "-1";
        }
        else
        {
            callBackResult = catalog[eventArgument].ToString();
        }
        return;
    }

    public string GetCallbackResult()
    {
        return callBackResult;
    }
}
