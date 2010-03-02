<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="AgentRecvInvoice" Title="Untitled Page" Codebehind="AgentRecvInvoice.aspx.cs" %>

<%@ Register Src="../WebParts/AgentInfoCtl.ascx" TagName="AgentInfoCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:AgentInfoCtl ID="AgentInfoCtl1" runat="server" />
    <asp:GridView ID="lstAgentOrders" runat="server" SkinID="NormalDataList" Width="100%"
        AutoGenerateColumns="False" DataSourceID="AgentOrderDataset" ShowFooter="True"
        OnRowDataBound="lstAgentOrders_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="Order#" SortExpression="orderID">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label1" CssClass="head02" runat="server" Text='<%# Bind("orderID") %>'></asp:Label>
                    <br />
                    <asp:Label ID="lbInv" runat="server" Text='<%# Eval("agentInv") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tour Name">
                <ItemTemplate>
                    <asp:Label ID="lbTourName" runat="server" Text='<%# Eval("tourName") %>' /><br />
                    <asp:Label ID="lbTourName_cn" runat="server" Text='<%# Eval("tourName_cn") %>' />
                    <asp:Label ID="lbSubTitle" runat="server" Text='<%# Eval("subTitle") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="startDate" HeaderText="Departure" SortExpression="startDate"
                DataFormatString="{0:d}" HtmlEncode="False" />
            <asp:TemplateField HeaderText="Customer" SortExpression="username">
                <ItemTemplate>
                    <asp:Label ID="lbCustomerName" runat="server" Text='<%# Eval("username") %>' />
                </ItemTemplate>
                <FooterTemplate>
                    Total:
                </FooterTemplate>
                <FooterStyle CssClass="head01" HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="# Adult/Child">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Literal ID="lbNumAdult" runat="server" Text='<%# Eval("numberAdult") %>' />
                    /
                    <asp:Literal ID="lbNumChild" runat="server" Text='<%# Eval("numberChild") %>' />
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lbTotAdult" runat="server" />
                    /
                    <asp:Label ID="lbTotChild" runat="server" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Fare">
                <ItemStyle HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="lbFare" runat="server" Text='<%# Eval("actualAmount") %>' />
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lbTotFare" runat="server" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Receivable" SortExpression="agentCredit">
                <ItemStyle HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="lbAgentReceivable" runat="server" Text='<%# Eval("agentCredit") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lbTotAgentReceivable" runat="server" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Paid" SortExpression="agentBillAmount">
                <ItemStyle HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="lbAgentPaid" runat="server" Text='<%# Eval("agentBillAmount") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lbTotAgentPaid" runat="server" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Balance">
                <ItemTemplate>
                    <asp:Label ID="lbBalance" runat="server" Text='<%# Bind("balance") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Right" />
                <FooterTemplate>
                    <asp:Label ID="lbTotBalance" runat="server" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:BoundField DataField="orderDate" DataFormatString="{0:d}" HeaderText="Order Date"
                HtmlEncode="False" SortExpression="orderDate">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="AgentOrderDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetAgentRecvInvoiceOrders" TypeName="com.Omei.BLL.Admin.AgentOrderBiz">
        <SelectParameters>
            <asp:QueryStringParameter Name="recvID" QueryStringField="recv" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <div class="toolbox listButtons">
        <ul>
            <li>
                <asp:HyperLink ID="lnkPrint" runat="server" Text="Print" Target="AgentReportWin" /></li><li>
                    <asp:HyperLink ID="lnkAgentOrders" runat="server">Agent Orders</asp:HyperLink></li></ul>
                    <div style="clear:both"></div>
    </div>
    <div>
        <asp:GridView ID="lstPayment" runat="server" DataSourceID="AgentPaymentItemsDataset"
            AutoGenerateColumns="False" BorderColor="white">
            <Columns>
                <asp:BoundField HeaderText="Order#" DataField="orderID">
                    <ItemStyle HorizontalAlign="Center" Font-Bold="true" />
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Payment#" DataField="apID">
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Agent Inv#" DataField="matchID" />
                <asp:BoundField HeaderText="Paid" DataField="payAmount">
                    <ItemStyle HorizontalAlign="Right" />
                    <HeaderStyle HorizontalAlign="Right" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Pay Date" DataField="payDate" DataFormatString="{0:d}"
                    HtmlEncode="false">
                    <ItemStyle HorizontalAlign="center" />
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:BoundField>
            </Columns>
            <HeaderStyle CssClass="list_head" />
            <FooterStyle CssClass="list_item_alt" />
            <EmptyDataTemplate>
                <p>
                    No agent payment exist.</p>
            </EmptyDataTemplate>
        </asp:GridView>
        <asp:ObjectDataSource ID="AgentPaymentItemsDataset" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetAgentPaymentByRecvID" TypeName="com.Omei.BLL.Admin.AgentBiz">
            <SelectParameters>
                <asp:QueryStringParameter Name="recvID" QueryStringField="recv" Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
</asp:Content>
