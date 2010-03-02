<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="AgentNewOrders" Title="Untitled Page" Codebehind="AgentNewOrders.aspx.cs" %>

<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="toolbox listButtons">
        <ul><li>
        <uc4:DataSelector ID="seleAgent" runat="server" DataSourceID="AgentDataset" DataTextField="agentName"
            DataValueField="agentID" DefaultValue="0" NoSelectPrompt="..::Please Select Agent::.."
            AutoPostBack="true" />
        </li></ul>
        
        <asp:ObjectDataSource ID="AgentDataset" runat="server" OldValuesParameterFormatString="original_{0}"
            SelectMethod="GetAgentOrdersAgent" TypeName="com.Omei.BLL.Admin.AgentOrderBiz">
        </asp:ObjectDataSource>
        <a href="help/help_agent.htm" target="OmeiHelpWin" class="help">Help</a>
        <div style="clear:both"></div>
    </div>

    <asp:GridView ID="lstOrders" runat="server" AutoGenerateColumns="False" DataKeyNames="orderID"
        DataSourceID="OrdersDataset" SkinID="DataList" Width="100%" AllowSorting="True">
        <Columns>
            <asp:TemplateField HeaderText="Order#" SortExpression="orderID">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("orderID", "OrderDetail.aspx?id={0}") %>'
                        Text='<%# Eval("orderID") %>'></asp:HyperLink>
                </ItemTemplate>
                <FooterTemplate>
                    Total:</FooterTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="Inv #" DataField="agentInv" SortExpression="agentInv">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Departure" DataField="startDate" DataFormatString="{0:d}"
                HtmlEncode="False" SortExpression="startDate">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:HyperLinkField HeaderText="Agent" DataTextField="agentName" DataNavigateUrlFields="agentID"
                DataNavigateUrlFormatString="AgentOrders.aspx?agent={0}" />
            <asp:BoundField HeaderText="Amount" DataField="actualAmount">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Deposit" DataField="deposit">
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
            <asp:ControlParameter ControlID="seleAgent" DefaultValue="0" Name="agentID" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
