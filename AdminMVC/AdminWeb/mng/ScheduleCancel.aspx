<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="ScheduleCancel" Title="Untitled Page" Codebehind="ScheduleCancel.aspx.cs" %>

<%@ Register Src="../Controls/DateInputCtl.ascx" TagName="DateInputCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="toolbox listButtons">
    &nbsp;時間:
    <uc1:DateInputCtl ID="dateFrom" runat="server" />
    &nbsp;
    ～
    <uc1:DateInputCtl ID="dateTo" runat="server" />
    &nbsp;
    Type:<asp:DropDownList ID="seleTourType" runat="server">
        <asp:ListItem Text="--All--" Value="0" Selected=true />
        <asp:ListItem Text="Bus tour" Value="1" />
        <asp:ListItem Text="Package" Value="2" />
        <asp:ListItem Text="Cruise" Value="3" />
    </asp:DropDownList>
    &nbsp;
    Tour ID:<asp:TextBox ID="txtTourID" runat="server" Width="40px"></asp:TextBox>
    &nbsp;
    <asp:Button ID="btnQuery" runat="server" CssClass="OmeiButton"
        Text="查詢" OnClick="btnQuery_Click" />
<div style="clear:both"></div></div>

<asp:ObjectDataSource ID="ScheduleListDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="SearchSchedules" TypeName="com.Omei.BLL.Admin.ScheduleBiz">
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="tourID" Type="Int32" />
        <asp:ControlParameter ControlID="seleTourType" Name="tourType" PropertyName="SelectedValue"
            Type="Int32" />
        <asp:Parameter Name="startDate" Type="DateTime" />
        <asp:Parameter Name="endDate" Type="DateTime" />
        <asp:Parameter Name="showAll" Type="Int32" DefaultValue="1" />
    </SelectParameters>
</asp:ObjectDataSource>


    <div class="toolbox listButtons">
        <input id="Checkbox1" onclick="ChangeAllCheckBoxStates(this.checked)" type="checkbox" />
        <label for="Checkbox2">
            Select all</label>
        &nbsp;
        <asp:Button ID="Button1" runat="server" OnClick="btnCancel_Click" Text="Cancel" OnClientClick="javascript:return confirm('您将取消所有选中的Schedule，\n\n确认吗？');" />
        <asp:Button ID="Button2" runat="server" OnClick="btnOpen_Click" Text="Open" OnClientClick="javascript:return confirm('您将所有选中的Schedule设为Open，\n\n确认吗？')" />
        (for checked schedules)
    <div style="clear:both"></div></div>
    
    <asp:GridView ID="lstSchedule" runat="server" Width="100%" AutoGenerateColumns="False" SkinID="NormalDataList" 
        DataSourceID="ScheduleListDataset" DataKeyNames="scheduleId" AllowSorting="True" 
        AllowPaging="True" PageSize="300" OnRowCommand="lstSchedule_RowCommand" 
        OnDataBound="lstSchedule_DataBound" >
        <Columns>
            <asp:TemplateField HeaderText="Schedule ID" SortExpression="scheduleId">
                <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:CheckBox ID="chkSchedule" runat="server" />&nbsp;
                    <asp:HyperLink ID="lnkScheduleID" runat="server" NavigateUrl='<%# Eval("scheduleId", "BusSeats.aspx?id={0}") %>'
                        Text='<%# Eval("scheduleId") %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tour name" SortExpression="TourName_cn">
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("TourName") %>' /><br />
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("TourName_cn") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="startDate" HeaderText="Start" SortExpression="startDate" DataFormatString="{0:yyyy.MM.dd (ddd)}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="tourGuide" HeaderText="Tour guide" SortExpression="tourGuide">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Seats" SortExpression="maxSeats">
                <HeaderTemplate>
                    <span title="Max seats / Book customers / Actual customers">Seats</span>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("maxSeats") %>'/>/<asp:Label ID="Label2" 
                    runat="server" Text='<%# Bind("bookCustomers") %>'/>/<asp:Label ID="Label3" 
                    runat="server" Text='<%# Bind("actualCustomers") %>'/>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("scheduleId", "ScheduleEdit.aspx?id={0}") %>'
                        Text='<%# OmeiStatus.GetOmeiStatusText("ScheduleStatus",Eval("status"),"en") %>'></asp:HyperLink>                
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <div class="toolbox listButtons">
        <input id="Checkbox2" onclick="ChangeAllCheckBoxStates(this.checked)" type="checkbox" />
        <label for="Checkbox2">
            Select all</label>
        &nbsp;
        <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Cancel" OnClientClick="javascript:return confirm('您将取消所有选中的Schedule，\n\n确认吗？');" />
        <asp:Button ID="btnOpen" runat="server" OnClick="btnOpen_Click" Text="Open" OnClientClick="javascript:return confirm('您将所有选中的Schedule设为Open，\n\n确认吗？')" />
        (for checked schedules)
    <div style="clear:both"></div></div>

</asp:Content>

