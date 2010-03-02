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

public partial class Controls_OmeiTypeSelectorCtl : System.Web.UI.UserControl
{
    private string _typeName = null;
    private string _noSelectPrompt = "--Please select--";
    private string _defaultValue = "0";
    private string _selectedValue = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack && _typeName!=null)
        {
            lstTypes.Items.Clear();
            TypeRefBiz biz = new TypeRefBiz();
            DS_TypeRef.DListDataTable dt = biz.GetValidListValue(_typeName);
            foreach (DS_TypeRef.DListRow row in dt.Rows)
            {
                ListItem item = new ListItem(row.listTitle, row.listValue);
                lstTypes.Items.Add(item);
            }
            if (lstTypes.Items.Count > 0 && _defaultValue!="nodefault")
            {
                ListItem item = new ListItem(_noSelectPrompt, _defaultValue);
                lstTypes.Items.Insert(0, item);
            }
        }
    }

    private void SetSelection()
    {
        if (_selectedValue != null && lstTypes.Items.Count > 0)
        {
            for (int i = 0; i < lstTypes.Items.Count; i++)
            {
                if (lstTypes.Items[i].Value == _selectedValue)
                {
                    lstTypes.Items[i].Selected = true;
                    break;
                }
            }
        }
    }

    #region ÊôÐÔ
    public DropDownList OmeiTypeDropDownList
    {
        get
        {
            return lstTypes;
        }
    }
    public string TypeName
    {
        set { _typeName = value; }
    }
    public string SelectedValue
    {
        get
        {
            if (lstTypes.SelectedIndex >= 0)
                return lstTypes.SelectedValue;
            else
                return "0";
        }
        set
        {
            _selectedValue = value;
            SetSelection();
        }
    }
    public bool AutoPostBack
    {
        set { lstTypes.AutoPostBack = value; }
    }
    public string NoSelectPrompt
    {
        set { _noSelectPrompt = value; }
    }
    public string DefaultValue
    {
        set { _defaultValue = value; }
    }
    #endregion
}
