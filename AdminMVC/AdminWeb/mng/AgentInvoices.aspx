<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="AgentInvoices" Title="Untitled Page" Codebehind="AgentInvoices.aspx.cs" %>

<%@ Register Src="../WebParts/AgentTitleCtl.ascx" TagName="AgentTitleCtl" TagPrefix="uc1" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="toolbox listButtons">
<ul>
<li>
        <asp:Label ID="lbMsg" runat="server" CssClass="successful"></asp:Label></li>
        
    <li>
        <a href="agentOrders.aspx">Agent Orders</a></li>    
        </ul>
        <div style="clear:both"></div>
</div>

<b>Invoices:</b><br />

    <asp:GridView ID="lstInvoice" runat="server" AutoGenerateColumns="False" DataKeyNames="invoiceID" DataSourceID="InvoiceDataset" SkinID="NormalDataList" Width="100%" OnRowDataBound="lstInvoice_RowDataBound">
        <Columns>
            <asp:BoundField DataField="invoiceID" HeaderText="Invoice#" InsertVisible="False"
                ReadOnly="True" SortExpression="invoiceID" >
                <ItemStyle HorizontalAlign="Center" Font-Bold="true" />
            </asp:BoundField>
            <asp:BoundField DataField="amount" HeaderText="Amount" SortExpression="amount" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="commission" HeaderText="Commission" SortExpression="commission" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="netTotal" HeaderText="Net total" SortExpression="netTotal" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="payAmount" HeaderText="Paid" SortExpression="payAmount" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="createDate" HeaderText="Created" SortExpression="createDate" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="lastUpdate" HeaderText="Updated" SortExpression="lastUpdate" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("AgentOrders",Eval("status"),"en") %>'></asp:Label>
                </ItemTemplate>

            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="InvoiceDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetDataByAgent" TypeName="com.Omei.DLL.DS_AgentInvoiceTableAdapters.AgentInvoicesTableAdapter">
        <SelectParameters>
        <asp:Parameter Name="agentID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>




</asp:Content>

