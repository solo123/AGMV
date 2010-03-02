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
/// MasterPageHelper 的摘要说明
/// </summary>
public class MasterPageHelper
{
    public MasterPageHelper()
    {
        //
        // TODO: 在此处添加构造函数逻辑
        //
    }

    public static void AddStyleSheet(Page page, string cssPath)
    {
        HtmlLink link = new HtmlLink();
        link.Href = cssPath;
        link.Attributes["rel"] = "stylesheet";
        link.Attributes["type"] = "text/css";
        page.Header.Controls.Add(link);
    }

}
