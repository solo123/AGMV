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

using System.Text;
using com.Omei.BLL.Admin;

public partial class Controls_PaymentBriefList : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    public int OrderID
    {
        set
        {
            AdminPaymentBiz biz = new AdminPaymentBiz();
            DataSet ds = biz.GetPaymentBriefList(value);
            StringBuilder sb = new StringBuilder();
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    sb.Append('$');
                    decimal d = (decimal)row["amount"];
                    sb.Append(d);
                    if (d < 0) sb.Append(" refund");
                    sb.Append(' ');
                    sb.Append(row["method"]);
                    sb.Append(", ");
                }
                if (sb.Length > 2)
                {
                    sb.Remove(sb.Length - 2, 2);
                    sb.Insert(0, " (");
                    sb.Append(")");
                }
            }
            txtPayment.Text = sb.ToString();
        }
    }
}
