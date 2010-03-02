<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="IMList" Title="Matched Invoice List" Codebehind="IMList.aspx.cs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:GridView ID="lstInvoice" AutoGenerateColumns="False" Width="100%" runat="server" DataSourceID="InvoiceDataset" SkinID="DataList" OnRowDataBound="lstInvoice_RowDataBound">
        <Columns>
            <asp:BoundField DataField="matchID" HeaderText="ID#" SortExpression="matchID" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="agentName" HeaderText="Agent" SortExpression="agentName" />
            <asp:BoundField DataField="agentInv" HeaderText="INV#" SortExpression="agentInv" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="cost" HeaderText="Cost" SortExpression="cost" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="tax" HeaderText="Tax" SortExpression="tax" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="matchAmount" HeaderText="Amount" SortExpression="matchAmount" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="profit" HeaderText="Profit" SortExpression="profit" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="matchDate" HeaderText="Date" SortExpression="matchDate" DataFormatString="{0:d}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="opEmployeeName" HeaderText="Operator" SortExpression="opEmployeeName" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("InvoiceMatchStatus",Eval("status"),"en") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="InvoiceDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetInvoiceList" TypeName="com.Omei.BLL.Admin.IMMatchBiz"></asp:ObjectDataSource>
    

</asp:Content>

