<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="AgentOrders" Title="Untitled Page" Codebehind="AgentOrders.aspx.cs" %>

<%@ Register Src="../WebParts/AgentInfoCtl.ascx" TagName="AgentInfoCtl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="toolbox listButtons">
        <ul>
            <li><a href="AgentPayment.aspx">Agent payment</a></li><li><a href="AgentCommission.aspx"><b>Edit Commission</b></a></li><li><a href="AgentNewRecv.aspx"><b>Create Invoice</b></a></li><li>
                <asp:HyperLink ID="lnkInvoices" runat="server">Invoice history</asp:HyperLink>
                </li>
            </ul>
            <a href="help/help_agent.htm" target="OmeiHelpWin" class="help">Help</a>
            <div style="clear:both"></div>
    </div>
    
    <uc1:AgentInfoCtl ID="AgentInfoCtl1" runat="server" />

    <asp:GridView ID="lstOrders" runat="server" AutoGenerateColumns="False" DataKeyNames="orderID"
        DataSourceID="OrdersDataset" SkinID="DataList" Width="100%" AllowSorting="True">
        <Columns>
            <asp:TemplateField HeaderText="Order#" SortExpression="orderID">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:HyperLink ID="lnkOrderID" runat="server" NavigateUrl='<%# Eval("orderID", "OrderDetail.aspx?id={0}") %>'
                        Text='<%# Eval("orderID") %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField HeaderText="Invoice#" DataTextField="agentRecvPrintID" SortExpression="agentRecvPrintID"
                DataNavigateUrlFields="agentRecvPrintID" DataNavigateUrlFormatString="AgentRecvInvoice.aspx?recv={0}" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:HyperLinkField>
            <asp:BoundField HeaderText="Agent Inv#" DataField="agentInv" SortExpression="agentInv" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Customer">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbCustomer" runat="server" Text='<%# Eval("customer") %>' />
                </ItemTemplate>
                <FooterTemplate>
                    Total:</FooterTemplate>
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
            <asp:BoundField HeaderText="Balance" DataField="balance">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="OrdersDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetAgentOrders" TypeName="com.Omei.BLL.Admin.AgentOrderBiz">
        <SelectParameters>
            <asp:Parameter Name="agentID" Type="Int32" DefaultValue="0" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
