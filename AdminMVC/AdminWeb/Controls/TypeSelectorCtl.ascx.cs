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

public partial class Controls_TypeSelectorCtl : System.Web.UI.UserControl
{
    private bool _isListChanged = false;
    private bool _isSelectChanged = false;
    private string _selectedValue;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (_isListChanged)
        {
            lstTypes.Items.Clear();
            string tn = TypeName;
            if (tn != null)
            {
                TypeRefBiz biz = new TypeRefBiz();
                DS_TypeRef.DListDataTable dt = biz.GetValidListValue(tn);
                foreach (DS_TypeRef.DListRow row in dt.Rows)
                {
                    ListItem item = new ListItem(row.listTitle, row.listValue);
                    lstTypes.Items.Add(item);
                }
                if (lstTypes.Items.Count > 0)
                {
                    ListItem item = new ListItem("--Please Select--", "0");
                    lstTypes.Items.Insert(0, item);
                }
            }
        }

        if (_isSelectChanged || lstTypes.Items.Count>0)
        {
            int i;
            for (i = 0; i < lstTypes.Items.Count; i++)
            {
                if (lstTypes.Items[i].Value == _selectedValue)
                {
                    lstTypes.Items[i].Selected = true;
                    break;
                }
            }
            if (i > lstTypes.Items.Count)
            {
                lstTypes.SelectedIndex = 0;
            }
        }
    }

    #region ÊôÐÔ
    public string TypeName
    {
        set
        {
            if (value == null)
                ViewState["TypeName"] = null;
            else
            {
                _isListChanged = (ViewState["TypeName"] == null || ViewState["TypeName"].ToString() != value);
                if (_isListChanged)
                {
                    ViewState["TypeName"] = value;
                    hdTypeName.Value = value;
                }
            }
        }
        get
        {
            if (ViewState["TypeName"] == null)
                return null;
            else
                return (string)ViewState["TypeName"];
        }
    }
    public string SelectedValue
    {
        set
        {
            _selectedValue = value;
            _isSelectChanged = true;
        }
        get
        {
            if (lstTypes.SelectedIndex >= 0)
                return lstTypes.SelectedValue;
            else
                return "0";
        }
    }
    #endregion
}
