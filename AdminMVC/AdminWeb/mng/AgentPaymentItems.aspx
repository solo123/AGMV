<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="AgentPaymentItems" Title="Untitled Page" Codebehind="AgentPaymentItems.aspx.cs" %>
<%@ Register Src="../WebParts/AgentTitleCtl.ascx" TagName="AgentTitleCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="toolbox listButtons">
        <ul>
            <li><a href="AgentPaymentHistory.aspx">Payments History</a></li><li><a href="AgentReceivables.aspx">Agent Receivables</a></li><li>
                <asp:HyperLink ID="lnkOrders" runat="server">Agent Orders</asp:HyperLink></li></ul>
                <div style="clear:both"></div>
    </div>

    <uc1:AgentTitleCtl ID="AgentTitleCtl1" runat="server" />
    <hr />
    
    <asp:GridView ID="lstAgentPaymentItems" runat="server" AutoGenerateColumns="False" DataSourceID="AgentPaymentItemsDataset" Width="100%" SkinID="NormalDataList" OnRowDataBound="lstAgentPaymentItems_RowDataBound">
        <Columns>
            <asp:BoundField DataField="apiID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                SortExpression="apiID">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="matchID" HeaderText="Payment#" SortExpression="matchID" />
            <asp:BoundField DataField="invoiceID" HeaderText="Invoice#" SortExpression="invoiceID">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="orderID" HeaderText="Order ID" SortExpression="orderID">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="payAmount" HeaderText="Amount" SortExpression="payAmount">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="payDate" DataFormatString="{0:d}" HeaderText="Date" HtmlEncode="False"
                SortExpression="payDate">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="AgentPaymentItemsDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="com.Omei.DLL.DS_AgentPaymentTableAdapters.AgentPaymentItemTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter Name="apID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    

</asp:Content>

