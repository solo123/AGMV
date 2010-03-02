<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="ReportBusTour" Title="Untitled Page" Codebehind="ReportBusTour.aspx.cs" %>

<%@ Register Src="../Controls/DateInputCtl.ascx" TagName="DateInputCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



<div class=toolbox>
<table>
    <tr>
        <td>From:</td>
        <td><uc1:DateInputCtl ID="inpDateFrom" runat="server" /></td>
        <td>To:</td>
        <td><uc1:DateInputCtl ID="inpDateTo" runat="server" /></td>
        <td><asp:Button ID="btnGo" Text="Go" runat=server /></td>
    </tr>
</table><div style="clear:both"></div>
</div>

    <asp:ObjectDataSource ID="TourScheduleDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="TourScheduleReport" TypeName="com.Omei.DLL.DS_SchedulesTableAdapters.TourScheduleReportTableAdapter">
        <SelectParameters>
            <asp:ControlParameter ControlID="inpDateTo" Name="toDate" PropertyName="DateValue"
                Type="DateTime" />
            <asp:ControlParameter ControlID="inpDateFrom" Name="fromDate" PropertyName="DateValue"
                Type="DateTime" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:GridView ID="lstReport" runat="server" AutoGenerateColumns="False" DataSourceID="TourScheduleDataset" SkinID="NormalDataList" Width="100%" ShowFooter="True" OnRowDataBound="lstReport_RowDataBound" AllowSorting="True">
        <Columns>
            <asp:BoundField DataField="tourID" HeaderText="ID" SortExpression="tourId" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="tourName" SortExpression="tourName">
                <ItemTemplate>
                    <asp:Label ID="lbTourName" runat="server" Text='<%# Bind("tourName") %>'></asp:Label><br />
                    <asp:Label ID="lbTourName_cn" runat="server" Text='<%# Eval("tourName_cn") %>' />
                </ItemTemplate>
                <FooterTemplate><asp:Label ID="lbTotal" runat="server" Text="Total" CssClass="StrongNumber" /></FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Schedule Count" SortExpression="scheduleCount">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbScheduleCount" runat="server" Text='<%# Bind("scheduleCount") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lbTotScheduleCount" runat="server" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Book Customers" SortExpression="bookCustomers">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbBookCustomers" runat="server" Text='<%# Bind("bookCustomers") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lbTotBookCustomers" runat="server" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Actual Customers" SortExpression="actualCustomers">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Label ID="lbActualCustomers" runat="server" Text='<%# Bind("actualCustomers") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lbTotActualCustomers" runat="server" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Rooms" SortExpression="actualRooms">
                <ItemStyle HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="lbActualRooms" runat="server" Text='<%# Eval("actualRooms","{0:N1}") %>'></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    <asp:Label ID="lbTotActualRooms" runat="server" />
                </FooterTemplate>
                <FooterStyle HorizontalAlign="Right" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Sales Amount" SortExpression="salesAmount">
                <ItemStyle HorizontalAlign="Right" />
                <ItemTemplate>
                    <asp:Label ID="lbSalesAmount" runat="server" Text='<%# Bind("salesAmount") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Right" />
                <FooterTemplate>
                    <asp:Label ID="lbTotSalesAmount" runat="server" />
                </FooterTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</asp:Content>

