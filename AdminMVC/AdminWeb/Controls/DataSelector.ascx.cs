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

public partial class Controls_DataSelector : System.Web.UI.UserControl
{
    #region 局部变量
    private string m_defaultSelectedValue = "-1";
    private string m_onSelectStr = null;
    private string m_selectedValue = null;
    private string m_noselectPrompt = "-- Please select --";
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (m_selectedValue != null && lstData.Items.Count > 0)
        {
            SetSelectedValue(m_selectedValue);
        }
    }

    #region 属性: DataSelectDataset, DefaultValue, SelectedValue
    public string DefaultValue
    {
        set { m_defaultSelectedValue = value; }
    }
    public string DataSourceID
    {
        set { lstData.DataSourceID = value; }
    }
    public string DataTextField
    {
        set { lstData.DataTextField = value; }
    }
    public string DataValueField
    {
        set { lstData.DataValueField = value; }
    }
    public bool AutoPostBack
    {
        set { lstData.AutoPostBack = value; }
    }
    public string OnSelectedIndexChanged
    {
        set { m_onSelectStr = value; }
    }
    public int SelectedIndex
    {
        set { lstData.SelectedIndex = value; }
        get { return lstData.SelectedIndex; }
    }
    public ListItem SelectedItem
    {
        get { return lstData.SelectedItem; }
    }
    public string NoSelectPrompt
    {
        set { m_noselectPrompt = value; }
    }

    public string SelectedValue
    {
        get
        {
            if (lstData.SelectedIndex < 0)
                return m_defaultSelectedValue;
            else
                return lstData.SelectedValue;
        }
        set
        {
            m_selectedValue = value;
            SetSelectedValue(value);
        }
    }
    private void SetSelectedValue(string val)
    {
        int idx = 0;
        if (lstData.Items.Count > 0)
        {
            if (val != lstData.SelectedValue)
            {
                for (int i = 0; i < lstData.Items.Count; i++)
                {
                    if (lstData.Items[i].Value == val)
                    {
                        idx = i;
                        break;
                    }
                }
                lstData.SelectedIndex = idx;
            }
        }
    }
    #endregion

    #region SelectedIndexChanged事件
    protected void lstData_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (m_onSelectStr != null && m_onSelectStr != "")
        {
            Delegate d = Delegate.CreateDelegate(typeof(EventHandler), Page, m_onSelectStr);
            ((EventHandler)d)(this, null);
        }
    }
    #endregion

    protected void lstData_DataBound(object sender, EventArgs e)
    {
        // 添加第一个默认选项
        ListItem item = new ListItem();
        string s = m_noselectPrompt;
        if (s != null && s.Length > 0 && s.IndexOf("{n}") >= 0)
        {
            s = s.Replace("{n}", lstData.Items.Count.ToString());
        }
        item.Text = s;

        item.Value = m_defaultSelectedValue;
        lstData.Items.Insert(0, item);

        if (m_selectedValue != null)
        {
            this.SelectedValue = m_selectedValue;
        }

    }
}
