<%@ Page Language="C#" MasterPageFile="~/PrintMaster.master" AutoEventWireup="true" Inherits="BusSeats_Prn" Title="Bus Seat"
    theme="themePrint" Codebehind="BusSeats_Prn.aspx.cs" %>

<%@ Register Src="../Controls/HotelListCtl.ascx" TagName="HotelListCtl" TagPrefix="uc5" %>
<%@ Register Src="../WebParts/ScheduleBaseInfo.ascx" TagName="ScheduleBaseInfo" TagPrefix="uc4" %>
<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc3" %>
<%@ Register Src="../WebParts/ScheduleBriefCtl.ascx" TagName="ScheduleBriefCtl" TagPrefix="uc2" %>
<%@ Register Src="../WebParts/BusSeatCtl.ascx" TagName="BusSeatCtl" TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table width="680">
    <tr>
        <td>
<div>
    <uc2:ScheduleBriefCtl ID="ScheduleBriefCtl1" runat="server" />
    <hr />    
    <uc4:ScheduleBaseInfo ID="ScheduleBaseInfo1" runat="server" />
</div>

<asp:ObjectDataSource ID="NewOrderDataset" runat="server" SelectMethod="GetData" TypeName="com.Omei.DLL.DS_OrdersTableAdapters.NewOrderListTableAdapter" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:QueryStringParameter Name="scheduleId" QueryStringField="scheduleId" Type="Int32" />
        </SelectParameters>
</asp:ObjectDataSource>

<div>
    <table width="100%">
        <tr>
            <td>
            </td>
            <td align="right">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:HiddenField ID="hdSeatList" runat="server" />
                <uc1:BusSeatCtl id="BusSeatCtl1" IsPrintMode=true runat="server"></uc1:BusSeatCtl>
            </td>
        </tr>
    </table>
</div>
    <uc5:HotelListCtl ID="HotelListCtl1" runat="server" />
        </td>
    </tr>
</table>

</asp:Content>
