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

public partial class WebParts_OplogList : System.Web.UI.UserControl
{
    private int _opType = 0, _relateID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (_opType > 0 && _relateID > 0)
            {
                logDataset.SelectParameters["opType"].DefaultValue = _opType.ToString();
                logDataset.SelectParameters["relateID"].DefaultValue = _relateID.ToString();
                lstOp.DataBind();
            }
        }
    }

    public int OpType
    {
        set { _opType = value; }
    }
    public int RelateID
    {
        set
        {
            _relateID = value;
        }
    }
}
