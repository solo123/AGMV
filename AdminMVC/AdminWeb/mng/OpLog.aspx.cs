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

public partial class OpLog : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected string LogNavUrl()
    {
        object t = Eval("opType");
        object r = Eval("relateID");

        if (t != null && r != null)
        {
            return OmeiStatus.GetLogRelatePage( Convert.ToInt32(t), (int)r);
        }
        return string.Empty;
    }
}
