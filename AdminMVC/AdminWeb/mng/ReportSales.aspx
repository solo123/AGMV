<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="ReportSales" Title="Untitled Page" Codebehind="ReportSales.aspx.cs" %>

<%@ Register Src="../Controls/DateInputCtl.ascx" TagName="DateInputCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="toolbox listButtons">
        <ul>
            <li>From:</li><li>
                <uc1:DateInputCtl ID="dateFrom" runat="server"  />
            </li>
            <li>To:</li><li>
                <uc1:DateInputCtl ID="dateTo" runat="server" />
            </li>
            <li>
                <asp:LinkButton ID="btnQuery" runat="server" OnClick="btnQuery_Click">Query</asp:LinkButton></li><li>
                <asp:LinkButton ID="btnDaily" runat="server" OnClick="btnDaily_Click">Daily</asp:LinkButton></li><li>
                <asp:LinkButton ID="btnMonthly" runat="server" OnClick="btnMonthly_Click">Monthly</asp:LinkButton></li></ul>
    <div style="clear:both"></div></div>
    
    
    <asp:GridView ID="lstReport" runat="server" DataSourceID="SalesReportDataset" SkinID="DataList" Width="100%" AutoGenerateColumns="False" OnRowDataBound="lstReport_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="Employee Name">
                <ItemTemplate>
                    <asp:Label ID="lbEmployeeName" runat="server" Text='<%# Eval("nickname") %>' />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="Cash" DataField="cash" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Credit Card" DataField="creditCard" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Check" DataField="check" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Agent" DataField="agent" >
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    
    
    <asp:ObjectDataSource ID="SalesReportDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetSalesReport" TypeName="com.Omei.BLL.Admin.SalesReportBiz">
        <SelectParameters>
            <asp:ControlParameter ControlID="dateFrom" Name="fromDate" PropertyName="DateValue"
                Type="DateTime" />
            <asp:ControlParameter ControlID="dateTo" Name="toDate" PropertyName="DateValue"
                Type="DateTime" />
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>

