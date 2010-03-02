<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="ScheduleEdit" Title="Untitled Page" Codebehind="ScheduleEdit.aspx.cs" %>

<%@ Register Src="../WebParts/ScheduleHotelCtl.ascx" TagName="ScheduleHotelCtl" TagPrefix="uc3" %>
<%@ Register Src="../WebParts/ScheduleBriefCtl.ascx" TagName="ScheduleBriefCtl" TagPrefix="uc2" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:ObjectDataSource ID="ScheduleBaseInfoDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetSchedulleInfo" TypeName="com.Omei.BLL.Admin.ScheduleBiz"
    UpdateMethod="UpdateScheduleBaseInfo">
    <UpdateParameters>
        <asp:Parameter Name="Original_scheduleId" Type="Int32" />
        <asp:Parameter Name="vehicleID" Type="Int32" />
        <asp:Parameter Name="maxSeats" Type="Int32" />
        <asp:Parameter Name="driverID" Type="Int32" />
        <asp:Parameter Name="driverAssistanceID" Type="Int32" />
        <asp:Parameter Name="tourGuideID" Type="Int32" />
        <asp:Parameter Name="tourGuideAssistanceID" Type="Int32" />
        <asp:Parameter Name="status" Type="Int32" />
        <asp:Parameter Name="subTitle" Type="String" ConvertEmptyStringToNull=False />
        <asp:Parameter Name="priceAdult" Type="Decimal" />
        <asp:Parameter Name="priceChild" Type="Decimal" />
    </UpdateParameters>
    <SelectParameters>
        <asp:QueryStringParameter Name="scheduleId" QueryStringField="id" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="BusDataset" runat="server" 
    OldValuesParameterFormatString="original_{0}" SelectMethod="GetAvalibleBus" 
    TypeName="com.Omei.BLL.Admin.EmployeeBiz">
    <SelectParameters>
        <asp:QueryStringParameter Name="scheduleID" QueryStringField="id" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="DriverDataset" runat="server" 
    OldValuesParameterFormatString="original_{0}" SelectMethod="GetAvalibleDriver" 
    TypeName="com.Omei.BLL.Admin.EmployeeBiz">
    <SelectParameters>
        <asp:QueryStringParameter Name="scheduleId" QueryStringField="id" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="TourguideDataset" runat="server" 
    OldValuesParameterFormatString="original_{0}" SelectMethod="GetAvailableTourGuideList" 
    TypeName="com.Omei.BLL.Admin.EmployeeBiz">
    <SelectParameters>
        <asp:QueryStringParameter Name="scheduleId" QueryStringField="id" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>

<div>
<asp:FormView ID="fvScheduleBaseInfo" runat="server" DataKeyNames="scheduleId" 
    DataSourceID="ScheduleBaseInfoDataset" Width="100%" 
    OnDataBound="fvScheduleBaseInfo_DataBound" OnItemUpdated="fvScheduleBaseInfo_ItemUpdated" >
    <EditItemTemplate>
    <div class="toolbox listButtons">
        <ul>
            <li><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                Text="Update" Enabled='<%# PageLogic.CheckActionAuth("auth_ScheduleEdit") %>'>
            </asp:LinkButton></li><li><asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton></li></ul>
    <div style="clear:both"></div></div>
    <div>
        <uc2:ScheduleBriefCtl ID="ScheduleBriefCtl1" runat="server" ScheduleId='<%# Eval("scheduleId") %>' />
        <hr />
        <table class="detail_view" width="100%">
            <tr>
                <td class="prompt" nowrap="nowrap">
                    Subtitle:</td>
                <td colspan="3">
                    <asp:TextBox ID="txtSubTitle" runat="server" Text='<%# Bind("subTitle") %>' Width="200px"></asp:TextBox>
                    * will print in ticket</td>
            </tr>
            <tr>
                <td class="prompt" nowrap="noWrap">
                    客位數:</td>
                <td>
            <asp:TextBox ID="txtMaxSeats" runat="server" Text='<%# Bind("maxSeats") %>'></asp:TextBox></td>
                <td class="prompt" nowrap="noWrap">
            車名:</td>
                <td>
            <uc1:dataselector id="lstBus" runat="server" 
                DefaultValue="0" DataSourceID="BusDataset" 
                SelectedValue='<%# Bind("vehicleId") %>'
                DataTextField="username"
                DataValueField="userId" 
                 /></td>
            </tr>
            <tr>
                <td class="prompt" nowrap="noWrap">
                    司機:</td>
                <td>
            <uc1:dataselector id="lstDriver" runat="server" DefaultValue=0 
                DataSourceID="DriverDataset" DataTextField="username" DataValueField="userId" 
                SelectedValue='<%# Bind("driverId") %>' />
                
                    </td>
                <td class="prompt" nowrap="noWrap">
            司機助手:</td>
                <td>
            <uc1:dataselector id="lstDriverAss" runat="server" DefaultValue="0" DataSourceID="DriverDataset" 
                DataTextField="username" DataValueField="userId" 
                SelectedValue='<%# Bind("driverAssistanceId") %>' />
                </td>
            </tr>
            <tr>
                <td class="prompt" nowrap="noWrap">
                    導遊:</td>
                <td>
            <uc1:dataselector id="lstTourGuide" runat="server" DefaultValue="0" 
                DataSourceID="TourguideDataset" DataTextField="username" DataValueField="userId" 
                SelectedValue='<%# Bind("tourGuideId") %>' />
                </td>
                <td class="prompt" nowrap="noWrap">
            導遊助手:</td>
                <td>
            <uc1:dataselector id="lstTourGuideAss" runat="server" DefaultValue="0" 
                DataSourceID="TourguideDataset" DataTextField="username" DataValueField="userId" 
                SelectedValue='<%# Bind("tourGuideAssistanceId") %>' />
                </td>
            </tr>
            <tr>
                <td class="prompt" nowrap="nowrap">
                    Status:</td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("status") %>'>
                        <asp:ListItem Selected="True" Value="0">Not open</asp:ListItem>
                        <asp:ListItem Value="1">Open</asp:ListItem>
                        <asp:ListItem Value="7">Canceled</asp:ListItem>
                        <asp:ListItem Value="8">Closed</asp:ListItem>
                    </asp:DropDownList></td>
                <td class="prompt" nowrap="nowrap">座位表:
                </td>
                <td>
                    <asp:CheckBox ID="chkHasSeat" runat="server" Enabled="false" Checked='<%# Eval("hasSeatTable") %>' />
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <hr />
                </td>
            </tr>
            <tr>
                <td class="prompt" nowrap="nowrap">
                    成人价:</td>
                <td class="content" nowrap="nowrap">
                    <asp:TextBox ID="lbPriceAdult" runat="server" Text='<%# Bind("priceAdult") %>'/></td>
                <td class="prompt" nowrap="nowrap">
                    小童价:</td>
                <td class="content" nowrap="nowrap">
                    <asp:TextBox ID="lbPriceChild" runat="server" Text='<%# Bind("priceChild") %>'/></td>
            </tr>
        </table><br />
        <uc3:ScheduleHotelCtl id="ScheduleHotelCtl1" runat="server" >
        </uc3:ScheduleHotelCtl>
     </div>

        
    </EditItemTemplate>

    <ItemTemplate>
        <div class="toolbox listButtons">
            <ul>
                <li><a href="ScheduleList.aspx">Schedule list</a></li><li><a href='BusSeats.aspx?id=<%# Eval("scheduleId") %>'>座位表</a></li><li><asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                Text="Edit" Enabled='<%# PageLogic.CheckActionAuth("auth_ScheduleEdit") %>'></asp:LinkButton></li></ul>
        <div style="clear:both"></div></div>
        <uc2:ScheduleBriefCtl ID="ScheduleBriefCtl1" runat="server" ScheduleId='<%# Eval("scheduleId") %>' />
        <hr />
        <table class="detail_view" width="400">
            <tr>
                <td class="prompt" nowrap="nowrap">
                    Subtitle:</td>
                <td class="content" colspan="3" nowrap="nowrap">
                    <asp:Label ID="lbSubTitle" runat="server" Font-Bold="True" Text='<%# Eval("subTitle") %>'></asp:Label></td>
            </tr>
            <tr>
                <td class="prompt" nowrap="nowrap">
                    客位數:</td>
                <td class="content" nowrap="nowrap">
                    <asp:Label ID="maxSeatsLabel" runat="server" Text='<%# Eval("maxSeats") %>'></asp:Label></td>
                <td class="prompt" nowrap="nowrap">
                    車號:</td>
                <td class="content" nowrap="nowrap">
                    <asp:Label ID="vehicleIdLabel" runat="server" Text='<%# Eval("vehicleName") %>'></asp:Label></td>
            </tr>
            <tr>
                <td class="prompt" nowrap="nowrap">
                    司機:</td>
                <td class="content" nowrap="nowrap">
                    <asp:Label ID="driverIdLabel" runat="server" Text='<%# Eval("driverName") %>'></asp:Label></td>
                <td class="prompt" nowrap="nowrap">
                    助手:</td>
                <td class="content" nowrap="nowrap">
                    <asp:Label ID="driverAssistanceIdLabel" runat="server" Text='<%# Eval("driverAssName") %>'></asp:Label></td>
            </tr>
            <tr>
                <td class="prompt" nowrap="nowrap">
                    導遊:</td>
                <td class="content" nowrap="nowrap">
                    <asp:Label ID="tourGuideIdLabel" runat="server" Text='<%# Eval("tourGuideName") %>'></asp:Label></td>
                <td class="prompt" nowrap="nowrap">
                    助手:</td>
                <td class="content" nowrap="nowrap">
                    <asp:Label ID="tourGuideAssistanceIdLabel" runat="server" Text='<%# Eval("tourGuideAssName") %>'></asp:Label></td>
            </tr>
            <tr>
                <td class="prompt" nowrap="nowrap">
                    状态:</td>
                <td class="content" nowrap="nowrap">
                    <asp:Label ID="lbStatus" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("ScheduleStatus",Eval("status"),"en") %>'></asp:Label></td>
                <td class="prompt" nowrap="nowrap">
                    座位表:</td>
                <td class="content" nowrap="nowrap">
                    <asp:CheckBox ID="chkHasSeats" runat="server" Enabled="false" Checked='<%# Eval("hasSeatTable") %>' /></td>
            </tr>
            <tr>
                <td colspan="4">
                    <hr />
                </td>
            </tr>
            <tr>
                <td class="prompt" nowrap="nowrap">
                    成人价:</td>
                <td class="content" nowrap="nowrap">
                    <asp:Label ID="lbPriceAdult" runat="server" Text='<%# Eval("priceAdult") %>'></asp:Label></td>
                <td class="prompt" nowrap="nowrap">
                    小童价:</td>
                <td class="content" nowrap="nowrap">
                    <asp:Label ID="lbPriceChild" runat="server" Text='<%# Eval("priceChild") %>'></asp:Label></td>
            </tr>
        </table>
        <br />
    </ItemTemplate>
</asp:FormView>
</div>    
    

</asp:Content>

