using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Web.Script.Services;

using com.Omei.BLL.Admin;
using com.Omei.DLL;
namespace AdminWeb.AdminService
{
    /// <summary>
    /// Summary description for InvoiceMatchService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [ScriptService]
    public class InvoiceMatchService : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        [ScriptMethod]
        public DataSet GetAgentTransforSum()
        {
            IMMatchBiz biz = new IMMatchBiz();
            return biz.GetAgentTransforSum();
        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public string GetAgentTranforSumString()
        {
            IMMatchBiz biz = new IMMatchBiz();
            DataSet ds = biz.GetAgentTransforSum();

            return JsonMethods.DtToJson(ds.Tables[0]);
        }
    }
}
