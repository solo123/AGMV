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

public partial class Controls_CheckBoxListCtl : System.Web.UI.UserControl
{
    private string m_dataSourceID = null;
    private string m_tableName = null, m_textFieldName = null, m_valueFieldName = null;
    private string m_selectedValue = null;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #region 属性
    public string DataSourceID
    {
        set { m_dataSourceID = value; }
    }
    public string TableName
    {
        set { m_tableName = value; }
    }
    public string DataTextField
    {
        set { m_textFieldName = value; }
    }
    public string DataValueField
    {
        set { m_valueFieldName = value; }
    }
    public string SelectedValue
    {
        set { m_selectedValue = value; }
        get
        {
            if (chkList.Items.Count <= 0) return string.Empty;

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            for (int i = 0; i < chkList.Items.Count; i++)
            {
                if (chkList.Items[i].Selected)
                {
                    sb.Append('[');
                    sb.Append(chkList.Items[i].Value);
                    sb.Append(']');
                }
            }
            return sb.ToString();
        }
    }
    #endregion

    public override void DataBind()
    {
        chkList.DataSourceID = m_dataSourceID;
        chkList.DataTextField = m_textFieldName;
        chkList.DataValueField = m_valueFieldName;
        base.DataBind();

        if (m_selectedValue != null && m_selectedValue != "")
        {
            for (int i = 0; i < chkList.Items.Count; i++)
            {
                if (m_selectedValue.IndexOf("[" + chkList.Items[i].Value.ToString() + "]") >= 0)
                    chkList.Items[i].Selected = true;
            }
        }
    }
}
