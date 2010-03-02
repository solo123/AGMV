<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="AgentReceivables" Title="Untitled Page" Codebehind="AgentReceivables.aspx.cs" %>

<%@ Register Src="../Controls/OmeiTypeSelectorCtl.ascx" TagName="OmeiTypeSelectorCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="toolbox listButtons">
        <ul>
            <li>Agent ID:
                <asp:TextBox ID="txtAgentID" runat="server" Width="80px"></asp:TextBox>
                <asp:LinkButton ID="btnGo" runat="server" OnClick="btnGo_Click">Go</asp:LinkButton>
            &nbsp;&nbsp;&nbsp; </li><li><asp:Label ID="lbMsg" runat="server" /></li></ul>
        
        <div class="notes">* 
                <a href="agentNewOrders.aspx">Unfinished orders</a> &gt;&gt; 
                <b>New agent receivable</b> &gt;&gt; 
                <a href="agentInvoiceList.aspx">Invoices</a> &gt;&gt 
                Match!</div>
        <div style="clear:both"></div>
        </div>


    <asp:ObjectDataSource ID="AgentOrdersDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="AgentReceivablesQuery" TypeName="com.Omei.BLL.Admin.AgentBiz">
    </asp:ObjectDataSource>


        
    <asp:GridView ID="lstAgentOrders" runat="server" SkinID="NormalDataList" Width="100%" AutoGenerateColumns="False" 
        DataSourceID="AgentOrdersDataset" OnRowDataBound="lstAgentOrders_RowDataBound" AllowSorting="True">
        <Columns>
            <asp:TemplateField HeaderText="Agent" SortExpression="companyName">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("companyName") %>'></asp:Label><br />
                    <asp:Label ID="lbAgentName_cn" runat="server" Text='<%# Eval("companyName_cn") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="orderID" HeaderText="Order#" SortExpression="orderID">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="username" HeaderText="Customer" SortExpression="username" />
            <asp:BoundField DataField="agentReceivable" HeaderText="Receivable" SortExpression="agentReceivable">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="additionalDiscount" HeaderText="Discount" SortExpression="additionalDiscount">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="agentPaid" HeaderText="Paid" SortExpression="agentPaid">
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="orderClosedDate" DataFormatString="{0:d}" HeaderText="Added date"
                HtmlEncode="False" SortExpression="orderClosedDate">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="reportDate" DataFormatString="{0:d}" HeaderText="Reprt Date"
                HtmlEncode="False" SortExpression="reportDate">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("AgentOrders", Eval("status"), "en") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            <p>No new agent receivable.</p>
            <ul>
                <li><a href="AgentNewOrders.aspx">Unfinished agent orders</a></li>
                <li><a href="AgentInvoiceList.aspx">Agent invoices</a></li>
            </ul>
        </EmptyDataTemplate>
    </asp:GridView>
    

    
</asp:Content>

