<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="AgentPaymentHistory" Title="Untitled Page" Codebehind="AgentPaymentHistory.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="toolbox listButtons">
        <ul>
            <li><a href="Agentreceivables.aspx">Agent receivables</a></li><li><a href="AgentOrders.aspx">Agent Orders</a></li><li>
                Payment#:<asp:TextBox ID="txtPaymentID" runat="server" Width="80px"></asp:TextBox>
                    <asp:LinkButton ID="btnQry" runat="server">Query</asp:LinkButton></li></ul>
                    <div style="clear:both"></div>
    </div>

    <asp:GridView ID="lstAgentPayment" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="AgentPaymentDataset" OnRowDataBound="lstAgentPayment_RowDataBound" SkinID="DataList" AllowPaging="True" AllowSorting="True" PageSize="20">
        <Columns>
            <asp:BoundField DataField="agentInvoiceID" HeaderText="Payment#" SortExpression="agentInvoiceID" />
            <asp:TemplateField HeaderText="Agent" SortExpression="companyName">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("companyName") %>'></asp:Label>
                    <br />
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("companyName_cn") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Pay by" SortExpression="payMethod">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("PaymentMethod", Eval("payMethod"), "en") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField DataField="payAmount" HeaderText="Amount" SortExpression="payAmount" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="payDate" DataFormatString="{0:d}" HeaderText="Date" HtmlEncode="False"
                SortExpression="payDate" >
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
            <asp:BoundField DataField="notes" HeaderText="Notes" SortExpression="notes" />
            <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="AgentPaymentDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="com.Omei.DLL.DS_AgentPaymentTableAdapters.AgentPaymentTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="txtPaymentID" Name="agentInvoiceID" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    

</asp:Content>

