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

public partial class Controls_DateInputCtl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        RegCalendarScriptBlock();
        if (!Page.IsPostBack)
        {
            lbScript.Text = CalendarScript();
        }
    }

    private string CalendarScript()
    {
        string script = @"
<script type='text/javascript'>
Calendar.setup({
    inputField     :    '"
+ txtDate.ClientID
+ @"',
    ifFormat       :    '%m/%d/%Y',
    showsTime      :    false,
    button         :    '"
+ startDateTrigger.ClientID
+ @"',
    step           :    1
});
</script>
";
        return script;
    }

    private void RegCalendarScriptBlock()
    {
        string scriptInclude = @"
<!-- Calendar -->
    <style type='text/css'>@import url(Images/Calendar/calendar-blue.css);</style>
    <script type='text/javascript' src='Images/Calendar/calendar.js'></script>
    <script type='text/javascript' src='Images/Calendar/lang/calendar-en.js'></script>
    <script type='text/javascript' src='Images/Calendar/calendar-setup.js'></script>
";
        Type cstype = this.GetType();
        string csname = "CalendarScripts";
        ClientScriptManager cm = Page.ClientScript;
        if (!cm.IsClientScriptBlockRegistered(cstype, csname))
        {
            cm.RegisterClientScriptBlock(cstype, csname, scriptInclude);
        }
    }

    #region  Ù–‘: DateValue
    public DateTime DateValue
    {
        set
        {
            txtDate.Text = value.ToString("MM'/'dd'/'yyyy");
        }
        get
        {
            if (txtDate.Text.Trim() == "")
                return new DateTime(1900,1,1);
            else
                return DateTime.Parse(txtDate.Text);
        }
    }
    #endregion

}
