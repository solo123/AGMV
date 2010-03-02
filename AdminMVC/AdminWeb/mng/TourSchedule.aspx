<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Admin_TourSchedule" Title="Untitled Page" Codebehind="TourSchedule.aspx.cs" %>

<%@ Register Src="../Controls/DateInputCtl.ascx" TagName="DateInputCtl" TagPrefix="uc2" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:Label ID="lbTourName" runat="server" CssClass="head01"></asp:Label>
    <hr />

    <table style="width: 100%">
        <tr>
            <td>
                <table style="width: 100%">
                    <tr>
                        <td>
                            <asp:CheckBox ID="chkMonday" runat="server" Text="星期一" /></td>
                        <td>
                            <asp:CheckBox ID="chkTuesday" runat="server" Text="星期二" /></td>
                        <td>
                            <asp:CheckBox ID="chkWednesday" runat="server" Text="星期三" /></td>
                        <td>
                            <asp:CheckBox ID="chkThursday" runat="server" Text="星期四" /></td>
                        <td>
                            <asp:CheckBox ID="chkFriday" runat="server" Text="星期五" /></td>
                        <td>
                            <asp:CheckBox ID="chkSaturday" runat="server" Text="星期六" /></td>
                        <td>
                            <asp:CheckBox ID="chkSunday" runat="server" Text="星期日" /></td>
                    </tr>
                </table>
           </td>
        </tr>
        <tr>
            <td>
                <asp:CheckBox ID="chkAutoCreate" runat="server" Text="允許自動出團" Enabled='<%# PageLogic.CheckActionAuth("auth_TourScheduleSaveTakeOff") %>' />
                &nbsp; &nbsp;
                <asp:Button ID="btnSaveWeekly" runat="server" Text="保存出團週期" OnClick="btnSaveWeekly_Click" Enabled='<%# PageLogic.CheckActionAuth("auth_TourScheduleSaveTakeOff") %>' />&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnCreateScheduleNow" runat="server" Text="立即自動出團" OnClick="btnCreateScheduleNow_Click" Enabled='<%# PageLogic.CheckActionAuth("auth_TourScheduleAddOne") %>' />
                <asp:Label ID="txtToolMessage" runat="server" ForeColor="Red"></asp:Label></td>
        </tr>
    </table>

    <hr />
    <table style="width: 100%">
        <tr>
            <td>
                出團日期:&nbsp;<uc2:DateInputCtl ID="dateStart" runat="server" />
                &nbsp;
                <asp:Button ID="btnAddSchedule" runat="server" Text="添加臨時出團" OnClick="btnAddSchedule_Click" />
                &nbsp;
                
                <asp:Label ID="txtAddScheduleMessage" runat="server" Text=""></asp:Label></td>
        </tr>
    </table>
    
    <hr />

    <asp:GridView ID="lstSchedule" runat="server" Width="100%" AutoGenerateColumns="False" 
        SkinID="DataList" DataSourceID="TourScheduleListDataset" 
        DataKeyNames="scheduleId" AllowSorting="True">
        <Columns>
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                <ItemTemplate>
                    <asp:Label ID="lbStatus" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("ScheduleStatus",Eval("status"),"en") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="scheduleId">
                <ItemTemplate>
                    <asp:Label ID="lbScheduleID" runat="server" Text='<%# Bind("scheduleId") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="startDate" HeaderText="Start" SortExpression="startDate" ReadOnly="True" DataFormatString="{0:d}" HtmlEncode="False" />
            <asp:BoundField DataField="endDate" HeaderText="Return" SortExpression="endDate" ReadOnly="True" DataFormatString="{0:d}" HtmlEncode="False" />
            <asp:BoundField DataField="maxSeats" HeaderText="Seats" SortExpression="maxSeats" ReadOnly="True" />
            <asp:BoundField DataField="bookCustomers" HeaderText="Customers" SortExpression="bookCustomers" ReadOnly="True" />
            <asp:BoundField DataField="priceAdult" HeaderText="Price adult" SortExpression="priceAdult" ReadOnly="True" >
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="priceChild" HeaderText="Price child" SortExpression="priceChild" ReadOnly="True" >
                <ItemStyle HorizontalAlign="Right" />
                <HeaderStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Driver" HeaderText="Driver" ReadOnly="True" SortExpression="Driver" />
            <asp:BoundField DataField="tourGuide" HeaderText="Tour guide" ReadOnly="True" SortExpression="tourGuide" />
            <asp:BoundField DataField="createMode" HeaderText="Mode" SortExpression="createMode" ReadOnly="True" />
        </Columns>
    </asp:GridView>
    
    <asp:ObjectDataSource ID="TourScheduleListDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetCurrentSchedulesByTourID" TypeName="com.Omei.BLL.Admin.AdminTourScheduleBiz"
        >
        <SelectParameters>
            <asp:QueryStringParameter Name="tourId" QueryStringField="id" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>

