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

public partial class AgentPayment : System.Web.UI.Page
{
    private string _agentName = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        // regist javascript
        string scriptBlockName = "AgentBillBlock";
        if (!ClientScript.IsClientScriptBlockRegistered(scriptBlockName))
        {
            string editScript = @"
<script type='text/javascript'>
var PayItemIDs, PayItemSum;

function Calculate(){
    var totalPay = 0.0;
    if(PayItemIDs!=undefined && PayItemIDs!=null){
        for (var i = 0; i < PayItemIDs.length; i++){
            var p = document.getElementById(PayItemIDs[i]);
            if (p!=null){
                var v = parseFloat(p.value);
                if ( isNaN(v) ) v = 0;
                totalPay += v;
            }
        }
    }

    if(PayItemSum!=undefined && PayItemSum!=null){
        var lb = document.getElementById(PayItemSum[0]);
        if (lb!=null)
            lb.innerText = totalPay.toFixed(2);
    }
}
function CheckPayment(){
    if(PayItemSum!=undefined && PayItemSum!=null){
        var p1 = document.getElementById(PayItemSum[0]);
        var p2 = document.getElementById(PayItemSum[1]);
        if( eval(p1.innerText) == eval(p2.value)){
            if( confirm('Are you sure?') == false ) {
                window.event.returnValue = false;
                return false;
            }
            return true;
        }
    }
    alert('Pay amount not equal to items sum. Please check.');
    window.event.returnValue = false;
    return false;
}

function CheckPayItem(field, maxVal){
    if( eval(field.value) > eval(maxVal) ){
        alert('Can not pay more than balance. Please check.');
        window.event.returnValue = false;
        field.focus();
        field.select();
    }
    else
        Calculate();
}
</script>
";
            ClientScript.RegisterClientScriptBlock(this.GetType(), scriptBlockName, editScript);

            if (!Page.IsPostBack)
            {
                int agentID = PageTools.GetSavedId("AgentID", Request.QueryString["agent"]);
                if (agentID <= 0)
                    Response.Redirect("AgentNewOrders.aspx");
                OrdersDataset.SelectParameters["agentID"].DefaultValue = agentID.ToString();
                lstOrders.DataBind();
            }
        }
    }

    #region gridview process
    protected void lstOrders_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        // show agent name
        if (_agentName == null && e.Row.RowType == DataControlRowType.DataRow)
        {
            _agentName = DataBinder.Eval(e.Row.DataItem, "agentName").ToString();
            lbAgentName.Text = _agentName;
        }

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox tb = e.Row.FindControl("inpPay") as TextBox;
            if (tb != null)
            {
                decimal b = (decimal)(DataBinder.Eval(e.Row.DataItem, "balance"));
                tb.Attributes.Add("onchange", "CheckPayItem(this, '"+ b.ToString() +"' )");
            }
        }

        // sum
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label ppp = e.Row.FindControl("sumPay") as Label;
            ClientScript.RegisterArrayDeclaration("PayItemSum", "'" + ppp.ClientID + "'");
            ClientScript.RegisterArrayDeclaration("PayItemSum", "'" + txtPay.ClientID + "'");
        }
    }

    #endregion

    protected void btnDoPayment_Click(object sender, EventArgs e)
    {
        int agentID = PageTools.GetSavedId("AgentID", null);
        AgentBiz biz = new AgentBiz();
        int apid = biz.UpdatePayment(agentID, PageTools.ParseDecimal(txtPay.Text), PageTools.ParseInt(selePayMethod.SelectedValue), txtRemark.Text);

        if (apid > 0)
        {
            // input array
            foreach (GridViewRow row in lstOrders.Rows)
            {
                TextBox tb = row.FindControl("inpPay") as TextBox;
                Label lb = row.FindControl("lbOrderID") as Label;
                if (tb != null)
                {
                    decimal payItem = PageTools.ParseDecimal(tb.Text);
                    int orderID = PageTools.ParseInt(lb.Text);

                    biz.UpdatePaymentItem(apid, orderID, agentID, payItem);
                }
            }
            lbMsg.Text = "Payment successed.";
        }
        lstOrders.DataBind();

    }



    protected void lstOrders_DataBound(object sender, EventArgs e)
    {
        // input array
        foreach (GridViewRow row in lstOrders.Rows)
        {
            TextBox tb = row.FindControl("inpPay") as TextBox;
            if (tb != null)
            {
                ClientScript.RegisterArrayDeclaration("PayItemIDs", "'" + tb.ClientID + "'");
            }
        }
    }
}
