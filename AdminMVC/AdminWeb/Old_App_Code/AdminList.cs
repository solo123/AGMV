using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for AdminList
/// </summary>
public class AdminList : AdminBase
{
    private string m_editPageUrl = null;

    public AdminList()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    /// <summary>
    /// 编辑页面的URL
    /// </summary>
    public string EditPageUrl
    {
        get { return m_editPageUrl; }
        set { m_editPageUrl = value; }
    }

    /// <summary>
    /// 为该行加上OnMouseOver事件
    /// </summary>
    /// <param name="row"></param>
    /// <param name="keyFieldName"></param>
    protected void RowOnMouseOverEvent(GridViewRow row, string keyFieldName)
    {
        if (row.RowType == DataControlRowType.DataRow)
        {
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
            row.Attributes.Add("onclick", "itemClick('" + m_editPageUrl + "?id=" + DataBinder.Eval(row.DataItem, keyFieldName) + "')");
        }
    }
    protected void RowOnMouseOverEvent(GridViewRow row, string keyFieldName, string editPage)
    {
        if (row.RowType == DataControlRowType.DataRow)
        {
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
            row.Attributes.Add("onclick", "itemClick('" + editPage + "?id=" + DataBinder.Eval(row.DataItem, keyFieldName) + "')");
        }
    }
    protected void RowOnMouseOverEvent1(GridViewRow row, string editPage)
    {
        if (row.RowType == DataControlRowType.DataRow)
        {
            row.Attributes.Add("onmouseover", "this.style.backgroundColor='#ffffcc'");
            row.Attributes.Add("onmouseout", "this.style.backgroundColor=''");
            row.Attributes.Add("onclick", "itemClick(\"" + editPage + "\")");
        }
    }
}
