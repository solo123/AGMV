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

using com.Omei.DLL;
using com.Omei.DLL.DS_TypeRefTableAdapters;

public partial class Controls_TypeMultiSelector : System.Web.UI.UserControl
{
    private string _listClass = "";
    private string _selectedValue = null;
    private bool _isChanged = false;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        //如果列表中没有数据，则添加
        if (clTypes.Items.Count == 0 && _listClass!=null && _listClass!="")
        {
            DListTableAdapter adp = new DListTableAdapter();
            DS_TypeRef.DListDataTable dt = adp.GetValidList(_listClass);
            foreach (DS_TypeRef.DListRow row in dt.Rows)
            {
                ListItem item = new ListItem(row.listTitle, row.listValue);
                clTypes.Items.Add(item);
            }
        }

        //选中SelectedValue中的项目
        if (_isChanged && _selectedValue != null && _selectedValue != "" && clTypes.Items.Count > 0)
        {
            string[] valList = _selectedValue.Split(',');
            for (int i = 0; i < clTypes.Items.Count; i++)
            {
                clTypes.Items[i].Selected = ValInList(clTypes.Items[i].Value, valList);
            }
        }
    }

    private bool ValInList(string val, string[] valList)
    {
        if (valList.Length < 1) return false;

        for (int i = 0; i < valList.Length; i++)
        {
            if (val == valList[i]) return true;
        }
        return false;
    }

    #region 屬性
    public String ListClass
    {
        set { _listClass = value; }
    }

    public string SelectedValue
    {
        set
        {
            _selectedValue = value;
            _isChanged = true;
        }
        get
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            for (int i = 0; i < clTypes.Items.Count; i++)
            {
                if (clTypes.Items[i].Selected)
                {
                    sb.Append(clTypes.Items[i].Value);
                    sb.Append(',');
                }
            }
            if (sb.Length > 1) sb.Remove(sb.Length - 1, 1);
            return sb.ToString();
        }
    }
    #endregion

    private void ShowValue()
    {
        
    }
}
