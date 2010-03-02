<%@ Control Language="C#" AutoEventWireup="true" Inherits="WebParts_ScheduleBaseInfo" Codebehind="ScheduleBaseInfo.ascx.cs" %>
<asp:FormView ID="FormView1" runat="server" DataKeyNames="scheduleId" DataSourceID="ScheduleBaseDataset">
    <ItemTemplate>
        <table width="100%" class="detail_view">
            <tr>
                <td nowrap="nowrap" class="prompt">
                    Vehicle:<asp:Label ID="vehicleNameLabel" runat="server" Text='<%# Bind("vehicleName") %>' CssClass="content"></asp:Label></td>
                <td nowrap="nowrap" class="prompt">
                    Driver:
                    <asp:Label ID="driverNameLabel" runat="server" Text='<%# Bind("driverName") %>' CssClass="content"></asp:Label>,
                    <asp:Label ID="driverAssNameLabel" runat="server" Text='<%# Bind("driverAssName") %>' CssClass="content"></asp:Label></td>
                <td nowrap="nowrap" class="prompt">
                    Tour guide:<asp:Label ID="tourGuideNameLabel" runat="server" Text='<%# Bind("tourGuideName") %>' CssClass="content"></asp:Label>,<asp:Label
                        ID="tourGuideAssNameLabel" runat="server" Text='<%# Bind("tourGuideAssName") %>' CssClass="content"></asp:Label></td>
            </tr>
        </table>
    </ItemTemplate>
</asp:FormView>
<asp:ObjectDataSource ID="ScheduleBaseDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetData" TypeName="com.Omei.DLL.DS_SchedulesTableAdapters.ScheduleBaseInfoTableAdapter">
    <SelectParameters>
        <asp:QueryStringParameter Name="scheduleId" QueryStringField="scheduleId" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
