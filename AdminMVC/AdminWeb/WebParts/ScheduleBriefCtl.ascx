<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebParts_ScheduleBriefCtl" Codebehind="ScheduleBriefCtl.ascx.cs" %>

<asp:Panel ID="panel1" runat="server" Visible="false">
    <asp:ObjectDataSource ID="ScheduleBriefDataset" runat="server" 
        OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetData" 
        TypeName="com.Omei.DLL.DS_SchedulesTableAdapters.ScheduleBriefTblTableAdapter" 
        >
        <SelectParameters>
            <asp:Parameter Name="scheduleId" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <asp:FormView ID="fvScheduleBrief" runat="server" DataKeyNames="scheduleId" DataSourceID="ScheduleBriefDataset" Width="100%">
        <ItemTemplate>
            <table width="100%" class="detail_view">
                <tr>
                    <td nowrap="nowrap" align="right" class="prompt">
                        Schedule ID: 
                        <asp:HyperLink ID="HyperLink1" NavigateUrl='<%# Eval("scheduleId","~/ScheduleEdit.aspx?id={0}") %>' Text='<%# Eval("scheduleId") %>' runat="server"></asp:HyperLink>
                        <br />
                        Status:[S.<asp:Label ID="statusLabel" runat="server" Text='<%# Eval("status") %>'></asp:Label>,
                        T.<asp:Label ID="tourStatusLabel" runat="server" Text='<%# Eval("tourStatus") %>'></asp:Label>]</td>
                    <td  width="100%" align="center">
                        <asp:HyperLink ID="lnkTourNameCn" runat="server" CssClass="head01" Text='<%# Eval("TourName_cn") %>' NavigateUrl='<%# Eval("tourID","~/TourDetail.aspx?id={0}") %>' />
                        -<asp:Label ID="lbDays" runat="server" CssClass="head02" Text='<%# OmeiStatus.DayAndNightText(Eval("TourDay"), "cn") %>'></asp:Label>-
                        <asp:Label ID="lbSubtitle" runat="server" CssClass="head02" Text='<%# Eval("subTitle") %>'></asp:Label>
                        <br />
                        <asp:HyperLink ID="TourNameLabel" runat="server" CssClass="head01" Text='<%# Eval("TourName") %>' NavigateUrl='<%# Eval("tourID","~/TourDetail.aspx?id={0}") %>' /></td>
                    <td nowrap="nowrap">
                        出發:<asp:Label ID="startDateLabel" runat="server" CssClass="content" Text='<%# Eval("startDate","{0:d}") %>'></asp:Label><br />
                        返回:<asp:Label ID="endDateLabel" runat="server" CssClass="content" Text='<%# Eval("endDate","{0:d}") %>'></asp:Label></td>
                </tr>
            </table>
            <table width="100%" class="detail_view">
                <tr>
                    <td class="prompt">
                        价格(成人/小童): $<asp:Label ID="priceAdultLabel" runat="server" Text='<%# Bind("priceAdult") %>' CssClass="content"></asp:Label>
                        / $<asp:Label ID="priceChildLabel" runat="server" Text='<%# Bind("priceChild") %>' CssClass="content"></asp:Label>&nbsp;
                        创建模式:<asp:Label ID="createModeLabel" runat="server" CssClass="content" Text='<%# Bind("createMode") %>'></asp:Label></td>
                    <td align=right>
                        createMode: 预定人数:
                        <asp:Label ID="bookCustomersLabel" runat="server" CssClass="content" Text='<%# Bind("bookCustomers") %>'></asp:Label>
                        / 已付款人数:<asp:Label ID="actualCustomersLabel" runat="server" CssClass="content" Text='<%# Bind("actualCustomers") %>'></asp:Label>
                        / 客房总数:<asp:Label ID="actualRoomsLabel" runat="server" CssClass="content" Text='<%# Bind("actualRooms") %>'></asp:Label></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:FormView>
</asp:Panel>

<asp:Panel ID="panel2" runat="server" Visible="false">
</asp:Panel>