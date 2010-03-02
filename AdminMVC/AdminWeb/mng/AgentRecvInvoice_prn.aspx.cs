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
using com.Omei.DLL;

public partial class AgentRecvInvoice_prn : System.Web.UI.Page
{
    private int numAdult=0, numChild=0, numFree=0;
    private decimal totFare=0, totRec=0, totComm=0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int recv = PageTools.ParseInt(Request.QueryString["recv"]);
            if (recv > 0)
            {
                AgentOrderBiz aobiz = new AgentOrderBiz();
                DataSet ds = aobiz.GetAgentRecvInvoice(recv);
                if (ds != null)
                {
                    int agentID = (int)(ds.Tables[0].Rows[0]["agentID"]);
                    if (agentID > 0)
                    {
                        AdminCompanyBiz biz = new AdminCompanyBiz();
                        DS_Companys.CompanyDetailDataTable dt = biz.GetCompanyDetail(agentID);
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            DS_Companys.CompanyDetailRow crow = dt.Rows[0] as DS_Companys.CompanyDetailRow;
                            lbAgentName.Text = crow.companyName + " / " + crow.companyName_cn;
                            lbAgentAddress.Text = crow.address + " <br /> " + crow.city + ", " + crow.state + " " + crow.zip + "<br />" + crow.country;
                            lbAgentTel.Text = crow.telephone;
                            lbAgentFax.Text = crow.fax;
                        }
                    }
                    lbCreateDate.Text = ((DateTime)ds.Tables[0].Rows[0]["createDate"]).ToShortDateString();
                    lbInvoiceNumber.Text = recv.ToString();
                }
            }
        }
    }
    protected void lstAgentOrders_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRow row = ((DataRowView)e.Row.DataItem).Row;
            numAdult += (int)row["numberAdult"];
            numChild += (int)row["numberChild"];
            numFree += (int)row["numberFree"];
            totFare += (decimal)row["actualAmount"];
            totRec += (decimal)row["agentCredit"];
            totComm += (decimal)row["agentCmt"];
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lbTotAdult = e.Row.FindControl("lbTotAdult") as Label;
            Label lbTotChild = e.Row.FindControl("lbTotChild") as Label;
            Label lbTotFree = e.Row.FindControl("lbTotFree") as Label;
            Label lbTotFare = e.Row.FindControl("lbTotFare") as Label;
            Label lbTotAgentReceivable = e.Row.FindControl("lbTotAgentReceivable") as Label;
            Label lbTotCommission = e.Row.FindControl("lbTotCommission") as Label;
            
            lbTotAdult.Text = numAdult.ToString();
            lbTotChild.Text = numChild.ToString();
            lbTotFree.Text = numFree.ToString();
            lbTotFare.Text = totFare.ToString("N2");
            lbTotAgentReceivable.Text = totRec.ToString("N2");
            lbTotCommission.Text = totComm.ToString("N2");
        }
    }
}
