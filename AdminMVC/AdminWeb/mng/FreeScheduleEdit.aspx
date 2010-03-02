<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="FreeScheduleEdit" Title="Untitled Page" Codebehind="FreeScheduleEdit.aspx.cs" %>

<%@ Register Src="../WebParts/TourNameCtl.ascx" TagName="TourNameCtl" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<asp:ObjectDataSource ID="ScheduleBaseInfoDataset" runat="server" OldValuesParameterFormatString="original_{0}"
    SelectMethod="GetFreeScheduleDetail" TypeName="com.Omei.BLL.Admin.ScheduleBiz"
    UpdateMethod="UpdateFreeSchedule" InsertMethod="AddFreeSchedule">
    <UpdateParameters>
        <asp:Parameter Name="Original_scheduleId" Type="Int32" />
        <asp:Parameter Name="subTitle" Type="String" ConvertEmptyStringToNull=False />
        <asp:Parameter Name="priceChild" Type="Decimal" />
        <asp:Parameter Name="priceAdult" Type="Decimal" />
        <asp:Parameter Name="status" Type="Int32" />
    </UpdateParameters>
    <SelectParameters>
        <asp:QueryStringParameter Name="scheduleId" QueryStringField="id" Type="Int32" />
    </SelectParameters>
    <InsertParameters>
        <asp:QueryStringParameter Name="tourId" QueryStringField="tourID" Type="Int32" />
        <asp:Parameter Name="subTitle" Type="String" />
        <asp:Parameter Name="priceChild" Type="Decimal" />
        <asp:Parameter Name="priceAdult" Type="Decimal" />
        <asp:Parameter Name="status" Type="Int32" />
    </InsertParameters>
</asp:ObjectDataSource>
    &nbsp; &nbsp;

<table width="100%">
            <tr>
                <td>
                    ScheduleID<br />
                    <asp:Label ID="lbScheduleID" runat="server" CssClass="StrongNumber" Text=''></asp:Label></td>
                <td class="prompt" nowrap="nowrap" colspan="3">
                    <uc1:TourNameCtl ID="TourNameCtl1"  runat="server" />
                </td>
            </tr>
</table>
        
<asp:FormView ID="fvScheduleBaseInfo" runat="server" DataKeyNames="scheduleId" 
    DataSourceID="ScheduleBaseInfoDataset" Width="100%" 
     >
    <EditItemTemplate>
    <div class="toolbox listButtons">
        <ul>
            <li><asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                Text="Update" Enabled='<%# PageLogic.CheckActionAuth("auth_ScheduleEdit") %>'>
            </asp:LinkButton></li><li><asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton></li></ul><div style="clear:both"></div>
    </div>
    <div>
        
        <br />
        <table class="detail_view" width="100%">
            <tr>
                <td>
                    ScheduleID<br />
                    <asp:Label ID="lbScheduleID" runat="server" CssClass="StrongNumber" Text='<%# Eval("scheduleId") %>'></asp:Label></td>
                <td class="prompt" nowrap="nowrap" colspan="3">
                    <uc1:TourNameCtl ID="TourNameCtl1" TourID='<%# Eval("tourId") %>' runat="server" />
                </td>
            </tr>
            <tr>
                <td class="prompt" nowrap="nowrap">
                    Subtitle:</td>
                <td colspan="3">
                    <asp:TextBox ID="txtSubTitle" runat="server" Text='<%# Bind("subTitle") %>' Width="200px"></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="prompt" nowrap="noWrap">
                    Price Adult:</td>
                <td>
                    <asp:TextBox ID="txtPriceAdult" runat="server" Text='<%# Bind("priceAdult") %>' /></td>
                <td class="prompt" nowrap="noWrap">
                    Price Child:</td>
                <td>
                    <asp:TextBox ID="txtPriceChild" runat="server" Text='<%# Bind("priceChild") %>' /></td>
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
                <td class="prompt" nowrap="nowrap">
                </td>
                <td>
                </td>
            </tr>
        </table><br />
        
     </div>

        
    </EditItemTemplate>
    
    <InsertItemTemplate>
    <div class="toolbox listButtons">
        <ul>
            <li><asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                Text="Add" Enabled='<%# PageLogic.CheckActionAuth("auth_ScheduleEdit") %>'>
            </asp:LinkButton></li><li><asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                Text="Cancel">
            </asp:LinkButton></li></ul><div style="clear:both"></div>
    </div>
    <div>
        
        <br />
        <table class="detail_view" width="100%">
            <tr>
                <td class="prompt" nowrap="nowrap">
                    Subtitle:</td>
                <td colspan="3">
                    <asp:TextBox ID="txtSubTitle" runat="server" Text='<%# Bind("subTitle") %>' Width="200px"></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="prompt" nowrap="noWrap">
                    Price Adult:</td>
                <td>
                    <asp:TextBox ID="txtPriceAdult" runat="server" Text='<%# Bind("priceAdult") %>' /></td>
                <td class="prompt" nowrap="noWrap">
                    Price Child:</td>
                <td>
                    <asp:TextBox ID="txtPriceChild" runat="server" Text='<%# Bind("priceChild") %>' /></td>
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
                <td class="prompt" nowrap="nowrap">
                </td>
                <td>
                </td>
            </tr>
        </table><br />
        
     </div>
    </InsertItemTemplate>

    <ItemTemplate>
        <div class="toolbox listButtons">
            <ul>
                <li><a href="ScheduleList.aspx">Schedule list</a></li><li><a href='BusSeats.aspx?id=<%# Eval("scheduleId") %>'>×ùÎ»±í</a></li><li><asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                Text="Edit" Enabled='<%# PageLogic.CheckActionAuth("auth_ScheduleEdit") %>'></asp:LinkButton></li></ul><div style="clear:both"></div>
        </div>
        
        <br />
        <table class="detail_view" width="400">
            <tr>
                <td>
                    ScheduleID<br />
                    <asp:Label ID="lbScheduleID" runat="server" CssClass="StrongNumber" Text='<%# Eval("scheduleId") %>'></asp:Label></td>
                <td class="prompt" nowrap="nowrap" colspan="3">
                    <uc1:TourNameCtl ID="TourNameCtl1" TourID='<%# Eval("tourId") %>' runat="server" />
                </td>
            </tr>
            <tr>
                <td class="prompt" nowrap="nowrap">
                    Subtitle:</td>
                <td class="content" colspan="3" nowrap="nowrap">
                    <asp:Label ID="lbSubTitle" runat="server" Font-Bold="True" Text='<%# Eval("subTitle") %>'></asp:Label></td>
            </tr>
            <tr>
                <td class="prompt" nowrap="nowrap">
                    Price Adult:</td>
                <td class="content" nowrap="nowrap">
                    </td>
                <td class="prompt" nowrap="nowrap">
                    Price Child:</td>
                <td class="content" nowrap="nowrap">
                    </td>
            </tr>
            <tr>
                <td class="prompt" nowrap="nowrap">
                    ×´Ì¬:</td>
                <td class="content" nowrap="nowrap">
                    <asp:Label ID="lbStatus" runat="server" Text='<%# OmeiStatus.GetOmeiStatusText("ScheduleStatus",Eval("status"),"en") %>'></asp:Label></td>
                <td class="prompt" nowrap="nowrap">
                    </td>
                <td class="content" nowrap="nowrap">
                    </td>
            </tr>
        </table>
        <br />
    </ItemTemplate>
</asp:FormView>

</asp:Content>

