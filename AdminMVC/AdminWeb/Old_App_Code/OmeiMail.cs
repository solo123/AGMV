using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using System.Text;
using System.Collections.Specialized;
using System.Net;
using System.Net.Mail;

/// <summary>
/// Summary description for OmeiMail
/// </summary>
public class OmeiMail
{
    private string m_errorMessage = null;

    public OmeiMail()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public string ErrorMessage
    {
        get { return m_errorMessage; }
    }

    public int SendMail(string mail_sender, string mail_from, string mail_to, string mail_subject, string mail_body )
    {
        int r = 0;
        WebClient webClient = new WebClient();
        NameValueCollection postVal = new NameValueCollection();
        postVal.Add("mail_sender", mail_sender);
        postVal.Add("mail_from", mail_from);
        postVal.Add("mail_to", mail_to);
        postVal.Add("mail_subject", mail_subject);
        postVal.Add("mail_body", mail_body);

        try
        {
            byte[] result = webClient.UploadValues("http://localhost/mail/OmeiSendMail.asp", "POST", postVal);
            string s = Encoding.ASCII.GetString(result);
            r = int.Parse(s);
        }
        catch (WebException ex)
        {
            r = -1;
            m_errorMessage = ex.ToString();
        }
        return r;
    }
}
