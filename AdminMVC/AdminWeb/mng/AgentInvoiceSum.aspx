<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="AgentInvoiceSum" Title="Untitled Page" Codebehind="AgentInvoiceSum.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="toolbox listButtons">
    <ul>
        <li><a href="AgentReceivables.aspx">New Receivable</a></li>
    </ul>
    <div class="notes">* 
                <a href="agentNewOrders.aspx">Unfinished orders</a> &gt;&gt; 
                <a href="agentReceivables.aspx">New agent receivable</a> &gt;&gt; 
                <b>Invoices</b> &gt;&gt 
                Match!</div>
                
                <div style="clear:both"></div>
</div>

<asp:Label ID="lbTTT" runat="server" ></asp:Label>
<asp:GridView ID="lstInvoice" runat="server" AutoGenerateColumns="False" DataSourceID="InvoiceDataset" 
    OnRowDataBound="lstInvoice_RowDataBound" SkinID="NormalDataList" Width="100%" AllowPaging="True" PageSize="50" AllowSorting="True">
        <Columns>
        <asp:BoundField DataField="agentID" HeaderText="Agent#" ReadOnly="True" SortExpression="agentID" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Agent" SortExpression="companyName">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("companyName") %>'></asp:Label><br />
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("companyName_cn") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="amount" HeaderText="Amount" ReadOnly="True" SortExpression="amount" DataFormatString="{0:N2}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="commission" HeaderText="Commission" ReadOnly="True" SortExpression="commission" DataFormatString="{0:N2}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="netTotal" HeaderText="Net total" ReadOnly="True" SortExpression="netTotal" DataFormatString="{0:N2}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="payAmount" HeaderText="Paid" ReadOnly="True" SortExpression="payAmount" DataFormatString="{0:N2}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="balance" HeaderText="Balance" ReadOnly="True" SortExpression="balance" DataFormatString="{0:N2}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
    <FooterStyle Font-Bold="True" />
    </asp:GridView>
    <asp:ObjectDataSource ID="InvoiceDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="com.Omei.DLL.DS_AgentInvoiceTableAdapters.AgentInvoiceSumTableAdapter">
    </asp:ObjectDataSource>


</asp:Content>

