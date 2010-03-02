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
public partial class PrintVoucher : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            VoucherBiz biz = new VoucherBiz();
            DataSet ds = biz.GetVoucherDetail(PageTools.ParseInt(Request.QueryString["id"]));
            if (ds == null)
            {
            }
            else
            {
                int orderID = (int)ds.Tables[0].Rows[0]["refundOrder"];
                OrderDetailDataset.SelectParameters["orderID"].DefaultValue = orderID.ToString();
            }
        }
    }
    protected void fvOrder_DataBound(object sender, EventArgs e)
    {
        com.Omei.OmeiDataSet.D_LoginUserInfo ui = Session["LoginUserInfo"] as com.Omei.OmeiDataSet.D_LoginUserInfo;

        if (fvOrder.FindControl("lbPrintTime") != null)
        {
            int orderID = PageTools.GetSavedId("OrderId", null);
            com.Omei.BLL.Admin.AdminOrderBiz biz = new com.Omei.BLL.Admin.AdminOrderBiz();

            ((Label)fvOrder.FindControl("lbPrintTime")).Text =
                ((Label)fvOrder.FindControl("lbPrintTime1")).Text =
                DateTime.Now.ToString();

            ((Label)fvOrder.FindControl("lbOpt")).Text =
                ((Label)fvOrder.FindControl("lbOpt1")).Text =
                ui.userId.ToString();

            ((Label)fvOrder.FindControl("lbSeatNumber")).Text =
                ((Label)fvOrder.FindControl("lbSeatNumber1")).Text =
                biz.GetSeats(orderID);
        }

    }
}
