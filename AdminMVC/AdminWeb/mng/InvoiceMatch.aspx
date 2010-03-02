<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="InvoiceMatch" Title="Untitled Page" Codebehind="InvoiceMatch.aspx.cs" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc4" %>
<%@ Register src="../Controls/OmeiTypeSelectorCtl.ascx" tagname="OmeiTypeSelectorCtl" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<script type='text/javascript'>
$(document).ready(function(){
    start_up();
 });
 
 function start_up(){
    $(".item_cost").change(dataChanged);
    $("#td_cost input").change(dataChanged);
 }
 
 function dataChanged(){
        var amount = $(this).parent().prev();
        var cost = $(this);
        var cost_val = $(this).attr("value");
        var profit = $(this).parent().next();
        
        if (cost_val=="") {  // 空
            profit.html("").attr({tag:""});
            cost.css("border","").css("background-color","").attr({tag:""});
            amount.css("font-weight","").attr({tag:""});
            cost.parent().parent().css("background-color","");
        }
        else {
            if (isNaN(cost_val)) { // 错误输入
                profit.html("Error!").css("color","red").css("font-weight","bold").attr({tag:""});
                cost.css("border","solid 1px red").css("background-color","lightyellow").attr({tag:""});
                cost.parent().parent().css("background-color","pink");
            }
            else {
                var amt =  $(this).parent().prev().html();
                var p = eval(amt - cost_val).toFixed(2);
                profit.html(p);
                if (p<0) {  // profit < 0
                    profit.css("color","red").css("font-weight","bold").attr({tag:""});
                    cost.css("border", "solid 1px red").css("background-color","lightyellow").attr({tag:""});
                    cost.parent().parent().css("background-color","pink");
                }
                else {   // profit >= 0
                    profit.css("color","darkGreen").css("font-weight","bold").attr({tag:"tg"});
                    cost.css("border", "solid 1px darkGreen").attr({tag:"tg"});
                    amount.css("font-weight","bold").attr({tag:"tg"});
                    cost.parent().parent().css("background-color","lightYellow");
                }
            }
        }
        
        // 计算汇总
        var tot = 0.0;
        $(".item_amount[tag='tg']").each(function(){
            tot += parseFloat($(this).html());
        });
        $("#tot_amount").html(tot.toFixed(2));
        
        var totCost = 0.0;
        $(".item_cost[tag='tg']").each(function(){
            totCost += parseFloat($(this).val());
        });
        $("#tot_cost").html(totCost.toFixed(2));
        
        var totProfit = 0.0;
        $(".item_profit[tag='tg']").each(function(){
            totProfit += parseFloat($(this).html());
        });
        $("#tot_profit").html(totProfit.toFixed(2));
        
        // match?
        if( eval($("#td_cost input").val() - totCost)==0 && totProfit>=0 )
            $(".match_button").removeAttr("disabled").val("Match!!");
        else
            $(".match_button").attr("disabled","disabled").val("Not Match..");

}
</script>
<div>

<table>
    <tr>
        <td><table>
        <tr>
            <td>agent:</td>
            <td><uc4:DataSelector ID="seleAgent" runat="server" DataSourceID="AgentDataset"
                    DataTextField="agentName" DataValueField="agentID" DefaultValue="0" NoSelectPrompt="..::Please Select::.."
                    AutoPostBack="true" />
                <asp:ObjectDataSource ID="AgentDataset" runat="server" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetTransforAgents" TypeName="com.Omei.BLL.Admin.AgentTransforBiz"></asp:ObjectDataSource>
                <asp:Label ID="lbMsg" Font-Bold="true" EnableViewState="false" runat="server" />
            </td>
        </tr>
    </table></td>
    </tr>
    <tr>
        <td>
        
        <fieldset style="background-color:#c8e0c0">
            <legend>Agent Payment</legend>
            <table  cellspacing="0" cellpadding="2" width="100%">
                <tr>
                    <td>INV#</td>
                    <td><asp:TextBox ID="txtAgentInv" runat="server" Text=""></asp:TextBox></td>
                    <td rowspan="4" width="40">&nbsp;</td>
                    <td rowspan="4">
                        Notes:<br />
                    <asp:TextBox ID="txtNotes" Width="300px" runat="server" TextMode="MultiLine" Rows="3" /></td>
                </tr>
                <tr>
                    <td>Pay by:</td>
                    <td><uc1:OmeiTypeSelectorCtl ID="seleAgentPaymentMethod" runat="server" TypeName="AgentPaymentMethod" />
</td>
                </tr>
                <tr>
                    <td>Total Cost:</td>
                    <td id="td_cost"><asp:TextBox ID="txtCost" runat="server" Text="0.00"></asp:TextBox></td>
                </tr>
                <tr>
                    <td>Tax:</td>
                    <td><asp:TextBox ID="txtTax" runat="server" Text="0.00"></asp:TextBox></td>
                </tr>
             </table>
        </fieldset>
        </td>
    </tr>
</table>
    </div>
    

    <asp:GridView ID="lstOrder" runat="server" AutoGenerateColumns="False" DataKeyNames="orderId"
        DataSourceID="OrderDataset" SkinID="DataList" Width="100%" 
        AllowSorting="True" PageSize="100"
        ShowFooter="True"  >
        <Columns>
            <asp:TemplateField HeaderText="Order#" SortExpression="orderID">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:HyperLink ID="lnkOrderID" runat="server" NavigateUrl='<%# Eval("orderID", "OrderDetail.aspx?id={0}") %>'
                        Text='<%# Eval("orderID") %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tour name" SortExpression="tourName">
                <ItemTemplate>
                    <asp:Label ID="lbTourName" runat="server" Text='<%# Eval("tourName") %>' />
                    <br />
                    <asp:Label ID="lbTourName_cn" runat="server" Text='<%# Eval("tourName_cn") %>' />
                </ItemTemplate>
                <FooterTemplate>
                    合计
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField DataField="customer" HeaderText="Customer" ReadOnly="True" SortExpression="customer" >
            </asp:BoundField>
            <asp:TemplateField HeaderText="Amount" SortExpression="actualAmount">
                <ItemStyle HorizontalAlign="Right" CssClass="item_amount" />
                <ItemTemplate>
                    <asp:Literal ID="lbAmount" runat="server" Text='<%# Bind("actualAmount") %>' />
                </ItemTemplate>
                <FooterTemplate>
                    <span id="tot_amount"></span>
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Cost">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:TextBox ID="txtCost" CssClass="item_cost" runat="server" Width="80px" />
                </ItemTemplate>
                <FooterTemplate>
                    <span id="tot_cost"></span>
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Profit">
                <ItemStyle HorizontalAlign="Right" Width="80px" CssClass="item_profit" />
                <ItemTemplate>
                    <asp:Literal ID="lbProfit" runat="server" />
                </ItemTemplate>
                <FooterTemplate>
                    <span id="tot_profit"></span>
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="Op employee" DataField="employee" SortExpression="employee" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Order date" DataField="orderDate" SortExpression="orderDate" 
                DataFormatString="{0:d}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="OrderDataset" runat="server" SelectMethod="GetTransforOrders" 
        TypeName="com.Omei.BLL.Admin.AgentTransforBiz" 
        OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:ControlParameter ControlID="seleAgent" Name="agentID" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:Button ID="btnMatch" CssClass="match_button" runat="server" Text="Match!" OnClick="btnMatch_Click" Enabled="false" />

</asp:Content>

