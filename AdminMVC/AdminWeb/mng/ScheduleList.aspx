<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="ScheduleList" Title="Untitled Page" Codebehind="ScheduleList.aspx.cs" %>

<%@ Register Src="../Controls/DateInputCtl.ascx" TagName="DateInputCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:ObjectDataSource ID="ScheduleListDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="SearchSchedules" TypeName="com.Omei.BLL.Admin.ScheduleBiz">
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="tourID" Type="Int32" />
        <asp:QueryStringParameter DefaultValue="0" Name="tourType" QueryStringField="tourtype"
            Type="Int32" />
        <asp:Parameter Name="startDate" Type="DateTime" />
        <asp:Parameter Name="endDate" Type="DateTime" />
        <asp:ControlParameter ControlID="seleStatus" DefaultValue="" Name="showAll" PropertyName="SelectedValue"
            Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
    
<div class="toolbox listButtons">
    &nbsp;Departure From:
    <uc1:DateInputCtl ID="dateFrom" runat="server" />
    &nbsp; To:<uc1:DateInputCtl ID="dateTo" runat="server" />
    &nbsp;&nbsp;<asp:DropDownList ID="seleStatus" runat="server">
        <asp:ListItem Value="0" Selected="True">Show Valid</asp:ListItem>
        <asp:ListItem Value="1">Show All</asp:ListItem>
    </asp:DropDownList>
    &nbsp;&nbsp;
    <asp:Button ID="btnQuery" runat="server" CssClass="OmeiButton"
        Text="查詢" OnClick="btnQuery_Click" />
<div style="clear:both"></div></div>

    

    <asp:GridView ID="lstSchedule" runat="server" Width="100%" AutoGenerateColumns="False" SkinID="NormalDataList" 
        DataSourceID="ScheduleListDataset" DataKeyNames="scheduleId" AllowSorting="True" 
        AllowPaging="True" PageSize="300" OnRowCommand="lstSchedule_RowCommand">
        <Columns>
            <asp:TemplateField HeaderText="Schedule ID" SortExpression="scheduleId">
                <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" Width="3" Height="5" BorderStyle="none" ImageUrl='<%# SeatImg(Eval("hasSeatTable")) %>' />
                    <asp:HyperLink ID="lnkScheduleID" runat="server" NavigateUrl='<%# ScheduleSeatsUrl(Eval("scheduleId"), Eval("hasSeatTable")) %>'
                        Text='<%# Eval("scheduleId") %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tour name" SortExpression="TourName_cn">
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" CssClass="TourName" Text='<%# Bind("TourName_cn") %>' /><br />
                    <asp:Label ID="Label5" runat="server"  Text='<%# Bind("TourName") %>' />
                    
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="SubTitle" SortExpression="subTitle" DataField="subTitle" />
            <asp:BoundField HeaderText="Days" SortExpression="tourDay" DataField="tourDay" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Price" SortExpression="priceAdult">
                <ItemStyle HorizontalAlign="center" />
                <ItemTemplate>
                    <asp:Label ID="lbPriceAdult" runat="server" Text='<%# Eval("priceAdult") %>' />
                    / 
                    <asp:Label ID="lbPriceChild" runat="server" Text='<%# Eval("priceChild") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="startDate" HeaderText="Start" SortExpression="startDate" DataFormatString="{0:yyyy-MM-dd (ddd)}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="tourGuide" HeaderText="Tour guide" SortExpression="tourGuide">
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="driver" HeaderText="Driver" ReadOnly="True" SortExpression="driver" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="Seats" SortExpression="maxSeats">
                <HeaderTemplate>
                    <span title="Max seats / Book customers / Actual customers">Seats</span>
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("maxSeats") %>'/>
                    /
                    <asp:Label ID="Label2" 
                    runat="server" Text='<%# Bind("bookCustomers") %>'/>
                    /
                    <asp:Label ID="Label3" 
                    runat="server" Text='<%# Bind("actualCustomers") %>'/>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status" SortExpression="status">
                <ItemStyle HorizontalAlign="Center" />
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# Eval("scheduleId", "ScheduleEdit.aspx?id={0}") %>'
                        Text='<%# OmeiStatus.GetOmeiStatusText("ScheduleStatus",Eval("status"),"en") %>' />                
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</asp:Content>

