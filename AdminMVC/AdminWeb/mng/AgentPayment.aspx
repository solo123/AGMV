<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" 
    Inherits="AgentPayment" Title="Untitled Page" Codebehind="AgentPayment.aspx.cs" %>
<%@ Register Src="../Controls/OmeiTypeSelectorCtl.ascx" TagName="OmeiTypeSelectorCtl"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="toolbox listButtons">
<div class="notes">* Pay by Agent.</div>
<div style="clear:both"></div>
</div>


<h2>
    Agent:<asp:Label ID="lbAgentName" runat="server" />
</h2>

    <asp:GridView ID="lstOrders" runat="server" AutoGenerateColumns="False" DataKeyNames="orderID"
        DataSourceID="OrdersDataset" SkinID="DataList" Width="100%" ShowFooter="True" OnDataBound="lstOrders_DataBound" OnRowDataBound="lstOrders_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="Order#">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbOrderID" runat="server" Text='<%# Eval("orderID") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Amount" DataField="actualAmount">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Commission" DataField="agentCmt">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Net Total" DataField="agentCredit">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Paid" DataField="agentBillAmount">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Balance">
                <ItemStyle HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("balance") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    Total:</FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Pay">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:TextBox ID="inpPay" runat="server" Text="" Width="80px" />
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Center" />
                <FooterTemplate>
                    <asp:Label ID="sumPay" runat="server" Text="0.00" CssClass="StrongNumber" />
                </FooterTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="OrdersDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetAgentOrders" TypeName="com.Omei.BLL.Admin.AgentOrderBiz">
        <SelectParameters>
            <asp:Parameter Name="agentID" Type="Int32" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>

<table width="100%" cellpadding=4 cellspacing=0 border=0>
    <tr>
        <td width="15%">
            Payment method:</td>
        <td width="85%">
            <uc1:OmeiTypeSelectorCtl ID="selePayMethod" runat="server" NoSelectPrompt="--Pay method--" DefaultValue="0" TypeName="PaymentMethod" />
        </td>
    </tr>
    <tr>
        <td width="15%">Remark:</td>
        <td width="85%"><asp:TextBox ID="txtRemark" runat="server" Rows="4" TextMode="MultiLine" Width="90%"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>
            Pay Amount:</td>
        <td><asp:TextBox ID="txtPay" runat="server" Width="80px"></asp:TextBox>&nbsp;
            <asp:Button ID="btnDoPayment" runat="server" Text="Pay to Agent" OnClientClick="return CheckPayment();" OnClick="btnDoPayment_Click" />
            <asp:Label ID="lbMsg" runat="server" EnableViewState="false" />
            
            </td>
    </tr>
</table>


</asp:Content>

