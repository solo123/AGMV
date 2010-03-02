<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Schedules" Title="Untitled Page" Codebehind="Schedules.aspx.cs" %>

<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    時間範圍:<asp:TextBox ID="txtDateFrom" runat="server" Width="80px"></asp:TextBox>&nbsp;
    ～
    <asp:TextBox ID="txtDateTo" runat="server" Width="80px"></asp:TextBox>
    <asp:Button ID="btnQuery" runat="server" CssClass="OmeiButton" Text="查詢" OnClick="btnQuery_Click" />
    <asp:Label ID="txtMsg" runat="server" ForeColor="Red"></asp:Label>
    <hr />
    <asp:ObjectDataSource ID="ScheduleListDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="com.Omei.DLL.DS_SchedulesTableAdapters.SchedulesTblTableAdapter">
        <SelectParameters>
            <asp:Parameter DefaultValue="2100-1-1" Name="startDate" Type="DateTime" />
            <asp:Parameter Name="endDate" Type="DateTime" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:GridView ID="lstSchedule" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="scheduleId" DataSourceID="ScheduleListDataset"
        SkinID="DataList" Width="100%" AllowPaging="True" OnPageIndexChanged="lstSchedule_PageIndexChanged" OnRowDataBound="lstSchedule_RowDataBound" OnSelectedIndexChanged="lstSchedule_SelectedIndexChanged">
        <Columns>
            <asp:CommandField SelectText="" ShowSelectButton="True" UpdateImageUrl="~/Images/master/white.gif" />
            <asp:BoundField DataField="scheduleId" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                SortExpression="scheduleId" />
            <asp:BoundField DataField="TourName_cn" HeaderText="Name" SortExpression="TourName_cn" />
            <asp:BoundField DataField="startDate" DataFormatString="{0:d}" HeaderText="Start"
                HtmlEncode="False" SortExpression="startDate" />
            <asp:BoundField DataField="maxSeats" HeaderText="Seats" SortExpression="maxSeats" />
            <asp:BoundField DataField="bookCustomers" HeaderText="Booked" SortExpression="bookCustomers" />
            <asp:BoundField DataField="actualCustomers" HeaderText="Full pay" SortExpression="actualCustomers" />
            <asp:BoundField DataField="driver" HeaderText="Driver" ReadOnly="True" SortExpression="driver" />
            <asp:BoundField DataField="tourGuide" HeaderText="Tour guide" ReadOnly="True" SortExpression="tourGuide" />
        </Columns>
    </asp:GridView>
    <br />
    <asp:ObjectDataSource ID="ScheduleBaseInfoDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="com.Omei.DLL.DS_SchedulesTableAdapters.ScheduleBaseInfoTableAdapter"
        UpdateMethod="UpdateQuery">
        <UpdateParameters>
            <asp:Parameter Name="vehicleId" Type="Int32" />
            <asp:Parameter Name="maxSeats" Type="Int32" />
            <asp:Parameter Name="driverId" Type="Int32" />
            <asp:Parameter Name="driverAssistanceId" Type="Int32" />
            <asp:Parameter Name="tourGuideId" Type="Int32" />
            <asp:Parameter Name="tourGuideAssistanceId" Type="Int32" />
            <asp:Parameter Name="Original_scheduleId" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:Parameter Name="scheduleId" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:FormView ID="fvScheduleBaseInfo" runat="server" DataKeyNames="scheduleId" DataSourceID="ScheduleBaseInfoDataset">
        <EditItemTemplate>
            ID:
            <asp:Label ID="scheduleIdLabel1" runat="server" Text='<%# Eval("scheduleId") %>'>
            </asp:Label>
            <asp:Label ID="lbTourName" runat="server" Text='<%# Eval("TourName_cn") %>' CssClass="head01"></asp:Label>&nbsp;<br />
            <table cellpadding="2" cellspacing="2" class="detail_view" style="width: 100%">
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        出發日期:</td>
                    <td class="content">
            <asp:Label ID="lbStartDate" runat="server" Text='<%# Eval("startDate") %>'></asp:Label></td>
                    <td class="prompt" nowrap="nowrap">
                        返囬日期:</td>
                    <td class="content">
            <asp:Label ID="lbEndDate" runat="server" Text='<%# Eval("endDate") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        巴士:</td>
                    <td>
                        <uc1:DataSelector ID="seleBus" runat="server" SelectedValue='<%# Bind("vehicleId") %>' />
                    </td>
                    <td class="prompt" nowrap="nowrap">
                        客位數:</td>
                    <td>
            <asp:TextBox ID="maxSeatsTextBox" runat="server" Text='<%# Bind("maxSeats") %>' Width="80px"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        司機:</td>
                    <td>
                        <uc1:DataSelector ID="seleDriver" runat="server" SelectedValue='<%# Bind("driverId") %>' />
                    </td>
                    <td class="prompt" nowrap="nowrap">
                        司機助手:</td>
                    <td>
                        <uc1:DataSelector ID="seleDriverAss" runat="server" SelectedValue='<%# Bind("driverAssistanceId") %>' />
                    </td>
                </tr>
                <tr>
                    <td class="prompt" nowrap="nowrap">
                        導遊:</td>
                    <td>
                        <uc1:DataSelector ID="seleTourGuide" runat="server" SelectedValue='<%# Bind("tourGuideId") %>' />
                    </td>
                    <td class="prompt" nowrap="nowrap">
                        導遊助手:</td>
                    <td>
                        <uc1:DataSelector ID="seleTourGuideAss" runat="server" SelectedValue='<%# Bind("tourGuideAssistanceId") %>' />
                    </td>
                </tr>
            </table>
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                Text="Update">
            </asp:LinkButton>
            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton>
        </EditItemTemplate>
        <InsertItemTemplate>
            startDate:
            <asp:TextBox ID="startDateTextBox" runat="server" Text='<%# Bind("startDate") %>'>
            </asp:TextBox><br />
            endDate:
            <asp:TextBox ID="endDateTextBox" runat="server" Text='<%# Bind("endDate") %>'>
            </asp:TextBox><br />
            vehicleId:
            <asp:TextBox ID="vehicleIdTextBox" runat="server" Text='<%# Bind("vehicleId") %>'>
            </asp:TextBox><br />
            maxSeats:
            <asp:TextBox ID="maxSeatsTextBox" runat="server" Text='<%# Bind("maxSeats") %>'>
            </asp:TextBox><br />
            driverId:
            <asp:TextBox ID="driverIdTextBox" runat="server" Text='<%# Bind("driverId") %>'>
            </asp:TextBox><br />
            driverAssistanceId:
            <asp:TextBox ID="driverAssistanceIdTextBox" runat="server" Text='<%# Bind("driverAssistanceId") %>'>
            </asp:TextBox><br />
            tourGuideId:
            <asp:TextBox ID="tourGuideIdTextBox" runat="server" Text='<%# Bind("tourGuideId") %>'>
            </asp:TextBox><br />
            tourGuideAssistanceId:
            <asp:TextBox ID="tourGuideAssistanceIdTextBox" runat="server" Text='<%# Bind("tourGuideAssistanceId") %>'>
            </asp:TextBox><br />
            TourName_cn:
            <asp:TextBox ID="TourName_cnTextBox" runat="server" Text='<%# Bind("TourName_cn") %>'>
            </asp:TextBox><br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                Text="Insert">
            </asp:LinkButton>
            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton>
        </InsertItemTemplate>
        <ItemTemplate>
            &nbsp;<asp:Label ID="scheduleIdLabel" runat="server" Text='<%# Eval("scheduleId") %>'></asp:Label>#
            <asp:Label ID="TourName_cnLabel" runat="server" Text='<%# Bind("TourName_cn") %>'></asp:Label><br />
            <table cellpadding="2" cellspacing="2" class="detail_view" style="width: 100%">
                <tr>
                    <td align="right" class="prompt" nowrap="nowrap" width="20%">
                        出發日期:</td>
                    <td class="content" width="30%">
                        <asp:Label ID="startDateLabel" runat="server" Text='<%# Bind("startDate", "{0:d}") %>'></asp:Label></td>
                    <td align="right" class="prompt" nowrap="nowrap" width="20%">
                        返回日期:</td>
                    <td class="content" width="30%">
                        <asp:Label ID="endDateLabel" runat="server" Text='<%# Bind("endDate") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td align="right" class="prompt" nowrap="nowrap">
                        巴士编号:</td>
                    <td class="content">
                        <asp:Label ID="vehicleIdLabel" runat="server" Text='<%# Bind("vehicleId") %>'></asp:Label></td>
                    <td align="right" class="prompt" nowrap="nowrap">
                        客位數:</td>
                    <td class="content">
                        <asp:Label ID="maxSeatsLabel" runat="server" Text='<%# Bind("maxSeats") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td align="right" class="prompt" nowrap="nowrap">
                        司机:</td>
                    <td class="content">
                        <asp:Label ID="driverIdLabel" runat="server" Text='<%# Bind("driverId") %>'></asp:Label></td>
                    <td align="right" class="prompt" nowrap="nowrap">
                        司机助手:</td>
                    <td class="content">
                        <asp:Label ID="driverAssistanceIdLabel" runat="server" Text='<%# Bind("driverAssistanceId") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td align="right" class="prompt" nowrap="nowrap">
                        导游:</td>
                    <td class="content">
                        <asp:Label ID="tourGuideIdLabel" runat="server" Text='<%# Bind("tourGuideId") %>'></asp:Label></td>
                    <td align="right" class="prompt" nowrap="nowrap">
                        导游助理:</td>
                    <td class="content">
                        <asp:Label ID="tourGuideAssistanceIdLabel" runat="server" Text='<%# Bind("tourGuideAssistanceId") %>'></asp:Label></td>
                </tr>
            </table>
            <br />
            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                Text="Edit"></asp:LinkButton>
        </ItemTemplate>
    </asp:FormView>
    <br />
    <br />
    <br />
</asp:Content>

