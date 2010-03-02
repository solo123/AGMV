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
using com.Omei.DLL;
public partial class Controls_OmeiTypeSingleSelector : System.Web.UI.UserControl
{
    private string _typeName = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadItems();
        }
    }

    private void LoadItems()
    {
        if (_typeName!=null)
        {
            TypeRefBiz biz = new TypeRefBiz();
            DS_TypeRef.DListDataTable dt = biz.GetValidListValue(_typeName);
            foreach (DS_TypeRef.DListRow row in dt.Rows)
            {
                ListItem item = new ListItem(row.listTitle, row.listValue);
                lstOmeiType.Items.Add(item);
            }
        }
    }

    #region 属性
    public string TypeName
    {
        set { _typeName = value; }
    }
    public string SelectedValue
    {
        get
        {
            if (lstOmeiType.Items.Count < 1)
                return null;
            else if (lstOmeiType.SelectedIndex >= 0)
                return lstOmeiType.SelectedValue;
            else
                return null;
        }
        set { }
    }
    public bool AutoPostBack
    {
        set { lstOmeiType.AutoPostBack = value; }
    }
    #endregion
}
