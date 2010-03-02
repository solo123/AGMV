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

public partial class WebParts_OrderInfoCtl : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #region 属性
    public int OrderId
    {
        set
        {
            OrderDetailDataset.SelectParameters["orderId"].DefaultValue = value.ToString();
            fvOrderDetail.DataBind();
        }
    }

    public int AgentID
    {
        get
        {
            HiddenField hd = fvOrderDetail.FindControl("hdAgentID") as HiddenField;
            if (hd != null)
                return PageTools.ParseInt(hd.Value);
            else
                return 0;
        }
    }
    #endregion

    protected string GetAgentName(object agentID)
    {
        if (agentID == null)
            return string.Empty;

        AdminCompanyBiz biz = new AdminCompanyBiz();
        return biz.GetCompanyNameByID((int)agentID);
    }

    protected string GetSeatList(object orderId)
    {
        if (orderId == null) return string.Empty;

        com.Omei.BLL.Admin.AdminOrderBiz biz = new com.Omei.BLL.Admin.AdminOrderBiz();
        return biz.GetSeatList((int)orderId);
    }

    protected string GetTicketName(object orderType, object departureDate)
    {
        if (orderType == null || Convert.ToInt32(orderType) == 0)
            return string.Empty;
        else
        {
            string s = OmeiStatus.GetOmeiStatusText("TicketType", orderType, "en");
            if (departureDate!=null && (departureDate is DateTime))
                s += "&nbsp;(" + ((DateTime)departureDate).ToString("D") + ")";
            return s;
        }
    }
}
