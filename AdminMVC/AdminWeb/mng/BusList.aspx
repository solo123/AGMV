<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Admin_BusList" Title="歐美旅遊-巴士管理" Codebehind="BusList.aspx.cs" %>

<%@ Register Src="../Controls/DataSelector.ascx" TagName="DataSelector" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="toolbox listButtons">
    <ul>
        <li><uc1:DataSelector ID="lstBusType" runat="server" DataSourceID="BusTypeDataset" DataTextField="listTitle_cn" DataValueField="listValue" DefaultValue="0" AutoPostBack="true" OnSelectedIndexChanged="lstStatus_SelectedIndexChanged" /></li>
        <li><asp:DropDownList ID="lstStatus" runat="server" AutoPostBack=true OnSelectedIndexChanged="lstStatus_SelectedIndexChanged" >
        <asp:ListItem Value="99">全部狀態</asp:ListItem>
        <asp:ListItem Value="1">有傚</asp:ListItem>
        <asp:ListItem Value="0">無傚</asp:ListItem>
    </asp:DropDownList></li>
    <li>Vehicle name:</li>
    <li><asp:TextBox ID="inpBusName" runat="server"></asp:TextBox></li>
    <li><asp:Button ID="btnGo" runat="server" Text="Go" OnClick="btnGo_Click" /></li>
        <li><a href="BusEdit.aspx?id=-1">新增</a></li>
    </ul>
<div style="clear:both"></div></div>    

    <asp:ObjectDataSource ID="BusTypeDataset" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetValidList" TypeName="com.Omei.DLL.DS_TypeRefTableAdapters.DListTableAdapter">
        <SelectParameters>
            <asp:Parameter DefaultValue="BusType" Name="listClass" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>

<asp:ObjectDataSource ID="BusDataset" runat="server" SelectMethod="GetVehicleList" TypeName="com.Omei.DLL.DS_VehiclesTableAdapters.vehiclesTableAdapter" OldValuesParameterFormatString="original_{0}">
    <SelectParameters>
        <asp:Parameter Name="vehicleType" Type="Int32" />
        <asp:Parameter Name="status" Type="Int32" />
        <asp:Parameter Name="vehicleName" Type="String" ConvertEmptyStringToNull=true />
    </SelectParameters>
    </asp:ObjectDataSource>
    <asp:GridView ID="lstBus" runat="server" AutoGenerateColumns="False" DataKeyNames="vehicleId"
        DataSourceID="BusDataset" SkinID="DataList" Width="100%" OnRowDataBound="lstBus_RowDataBound">
        <Columns>
            <asp:BoundField DataField="vehicleId" HeaderText="vehicleId" InsertVisible="False"
                ReadOnly="True" SortExpression="vehicleId" />
            <asp:BoundField DataField="vehicleName" HeaderText="vehicleName" SortExpression="vehicleName" />
            <asp:BoundField DataField="customerSeatNum" HeaderText="customerSeatNum" SortExpression="customerSeatNum" />
            <asp:BoundField DataField="plateNumber" HeaderText="plateNumber" SortExpression="plateNumber" />
            <asp:BoundField DataField="vinNumber" HeaderText="vinNumber" SortExpression="vinNumber" />
            <asp:BoundField DataField="inspectionDate" HeaderText="inspectionDate" SortExpression="inspectionDate" />
            <asp:BoundField DataField="vehicleType" HeaderText="vehicleType" SortExpression="vehicleType" />
            <asp:BoundField DataField="status" HeaderText="status" SortExpression="status" />
            <asp:BoundField DataField="own" HeaderText="own" SortExpression="own" />
        </Columns>
    </asp:GridView>

</asp:Content>

