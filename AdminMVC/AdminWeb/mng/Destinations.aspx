<%@ Page Language="C#" MasterPageFile="~/AdminWeb/public/AdminContent.master" AutoEventWireup="true" Inherits="Destinations" Title="Untitled Page" Codebehind="Destinations.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div class="toolbox listButtons">
    <ul>
        <li><a href="DestinationEdit.aspx?mode=add" visible='<%# PageLogic.CheckActionAuth("auth_DestinationNew") %>'>New Destination</a></li>
    </ul>
    <div style="clear:both"></div>
</div>

<asp:ObjectDataSource ID="DestinationDataset" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDestinationList"
    TypeName="com.Omei.DLL.DS_DestinationsTableAdapters.DestListTableAdapter">
</asp:ObjectDataSource>
    <asp:GridView ID="lstDestinations" runat="server" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        DataKeyNames="DestinationID" DataSourceID="DestinationDataset" 
        OnRowDataBound="lstDestinations_RowDataBound" SkinID="DataList" Width="100%" PageSize="300" >
        <Columns>
            <asp:BoundField DataField="DestinationID" HeaderText="ID" InsertVisible="False"
                ReadOnly="True" SortExpression="DestinationID" />
            <asp:BoundField DataField="DestinationName" HeaderText="Name" SortExpression="DestinationName" />
            <asp:BoundField DataField="DestinationName_cn" HeaderText="Name_cn" SortExpression="DestinationName_cn" />
            <asp:BoundField DataField="city" HeaderText="City" SortExpression="city" />
            <asp:BoundField DataField="state" HeaderText="State" SortExpression="state" />
            <asp:BoundField DataField="country" HeaderText="Country" SortExpression="country" />
            <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" >
                <ItemStyle Width="40px" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
</asp:Content>

